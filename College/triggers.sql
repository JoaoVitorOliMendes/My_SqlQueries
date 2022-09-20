create sequence SQ_PK_VENDA;
create sequence SQ_PK_FILME;
create sequence SQ_PK_TIPO_INGRESSO;

create or replace trigger tg_pk_venda
before insert
on venda
referencing new as new
for each row
begin
    :new.cod_venda := SQ_PK_VENDA.nextval;
end;
/

create or replace trigger tg_pk_filme
before insert
on filme
referencing new as new
for each row
begin
    :new.cod_filme := SQ_PK_FILME.nextval;
end;
/

create or replace trigger tg_pk_filme
before insert
on tipo_ingresso
referencing new as new
for each row
begin
    :new.cod_tipo := SQ_PK_TIPO_INGRESSO.nextval;
end;
/

create or replace trigger tg_limite_ingressos
before insert
on venda
referencing new as new
for each row
declare
total_vendido number;
total_ingressos number;
total_disponivel number;
begin
    select count(cod_venda) into total_vendido
    from venda
    where cod_filme = :new.cod_filme;
    
    select total_ingressos into total_ingressos
    from filme
    where cod_filme = :new.cod_filme;
    
    total_disponivel := total_ingressos - total_vendido;
    
    if total_disponivel < 1
        then raise_application_error(-20001, 'INGRESSOS ESGOTADOS');
    end if;
    
end;
/
