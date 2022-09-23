drop table livro;
drop table usuario;
drop table emprestimo;

create table livro(cod_livro number, nome_livro varchar2(50), idade_minima number);

create table usuario(cod_usuario number, nome_usuario varchar2(50), data_nascimento
date);

create table emprestimo(cod_emprestimo number, cod_usuario number, cod_livro number,
data_emprestimo date, devolucao_prevista date, data_devolucao date, multa
number(5,2));

/*create sequence sq_pk_livro;
create sequence sq_pk_usuario;
create sequence sq_pk_emprestimo;*/

create or replace trigger tg_pk_livro
before insert
on livro
referencing new as new
for each row
begin
    :new.cod_livro := sq_pk_livro.nextval();
end;
/
create or replace trigger tg_pk_usuario
before insert
on usuario
referencing new as new
for each row
begin
    :new.cod_usuario := sq_pk_usuario.nextval();
end;
/
create or replace trigger tg_pk_emprestimo
before insert
on emprestimo
referencing new as new
for each row
begin
    :new.cod_emprestimo := sq_pk_emprestimo.nextval();
end;
/

insert into livro (nome_livro, idade_minima) values ('Senhor dos Anéis', 12);
insert into livro (nome_livro, idade_minima) values ('A bela e a fera', 8);
insert into livro (nome_livro, idade_minima) values ('Albergue', 16);
insert into livro (nome_livro, idade_minima) values ('Sexta-feira 13', 18);
insert into livro (nome_livro, idade_minima) values ('Animais da Fazenda', 0);
insert into usuario (nome_usuario, data_nascimento) values ('Mickey Mouse', sysdate-(365*1));
insert into usuario (nome_usuario, data_nascimento) values ('Pateta', sysdate-(365*10));
insert into usuario (nome_usuario, data_nascimento) values ('Anabela', sysdate-(365*15));
insert into usuario (nome_usuario, data_nascimento) values ('Stefanny', sysdate-(365*16));
insert into usuario (nome_usuario, data_nascimento) values ('Tasha', sysdate-(365*18));
insert into usuario (nome_usuario, data_nascimento) values ('Aniqua', sysdate-(365*20));
insert into usuario (nome_usuario, data_nascimento) values ('Herbie', sysdate-(365*22));
insert into usuario (nome_usuario, data_nascimento) values ('Dick Vigarista', sysdate-(365*3));
insert into usuario (nome_usuario, data_nascimento) values ('Diana', sysdate-(365*9));
insert into usuario (nome_usuario, data_nascimento) values ('Hank', sysdate-(365*17));



create or replace trigger tg_dev
before insert
on emprestimo
referencing new as new
for each row
declare
dia_semana number;
begin
    :new.data_devolucao := :new.data_emprestimo + 3;
    if to_char(:new.data_devolucao, 'D') = 1
        then :new.data_devolucao := :new.data_emprestimo + 1;
        elsif to_char(:new.data_devolucao, 'D') = 7
            then :new.data_devolucao := :new.data_emprestimo + 2;
    end if;
end;
/

create or replace trigger tg_idade
before insert
on emprestimo
referencing new as new
for each row
declare
idadeIndicada number;
begin
    select idade_minima from livro into :idadeIndicada
    
end;
/
