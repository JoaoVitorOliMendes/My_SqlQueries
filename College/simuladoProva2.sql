-- 1.
-- d)

-- 2.
set SERVEROUTPUT on;
clear screen;
drop table matricula cascade CONSTRAINTS;
drop table estudante cascade CONSTRAINTS;
create table estudante(
    cod_estudante number,
    nome_estudante varchar2(30),
    serie number,
    status char(1),
    constraint cons_pk_estudante primary key(cod_estudante)
);
create table matricula(
    cod_matricula number,
    dt_matricula date,
    cod_estudante number,
    serie number,
    constraint cons_pk_matricula primary key(cod_matricula),
    constraint cons_fk_estudante foreign key(cod_estudante) references estudante(cod_estudante)
);
drop sequence SQ_PK_MATRICULA;
create sequence SQ_PK_MATRICULA;

create or replace trigger TG_PK_MATRICULA
before insert
on matricula
referencing new as new
for each row
begin
    :new.cod_matricula := sq_pk_matricula.nextVal();
end;
/

create or replace trigger TG_REGISTRA
before insert
on matricula
referencing new as new
for each row
declare
idEst number;
charEst char(1);
begin
    select estudante.cod_estudante into idEst, estudante.status into charEst
    from estudante
    where estudante.cod_estudante = :new.cod_estudante;
    
    if idEst is null
        then RAISE_APPLICATION_ERROR(-20001, 'Id de estudante nao existe');
    end if;
    if to_char(:new.dt_matricula, 'DD') <> to_char(sysdate, 'DD')
        then RAISE_APPLICATION_ERROR(-20002, 'Tentativa de adicionar registro com dia diferente de hoje');
    end if;
    
end;
/

select * from estudante;
select * from matricula;

insert into estudante values(1, 'ESTUDANTE A', 3, 'A');
insert into estudante values(2, 'ESTUDANTE B', 1, 'R');
insert into estudante values(3, 'ESTUDANTE C', 3, 'A');

insert into matricula values(null, sysdate, 1, 1);
insert into matricula values(null, sysdate, 2, 2);
insert into matricula values(null, sysdate, 3, 3);
