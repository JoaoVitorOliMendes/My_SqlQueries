set serveroutput on;
clear screen;



create or replace procedure PR_FATURAMENTO_FILIAL
as
cursor cr_filial is select cod_filial, nome_filial from tb_filial;
cursor cr_venda is select cod_filial, valor_total from tb_venda;
total number;
begin
    for x in cr_filial loop
        total:=0;
        for y in cr_venda loop
            if  x.cod_filial = y.cod_filial
                then total := total + y.valor_total;
            end if;
        end loop;
        dbms_output.put_line(x.nome_filial||' - R$ '||total);
    end loop;
end;
/

--call PR_FATURAMENTO_FILIAL();

create or replace procedure PR_MAIORFATURAMENTO_FILIAL
as
cursor cr_filial is select cod_filial, nome_filial from tb_filial;
cursor cr_venda is select cod_filial, valor_total from tb_venda;
total number;
maior number := 0;
maiorFilial varchar2(30);
begin
    for x in cr_filial loop
        total:=0;
        for y in cr_venda loop
            if  x.cod_filial = y.cod_filial
                then total := total + y.valor_total;
            end if;
        end loop;
        if maior < total
            then maior := total;
                maiorFilial := x.nome_filial;
        end if;
    end loop;
    dbms_output.put_line(maiorFilial||' - R$ '||maior);
end;
/

call PR_MAIORFATURAMENTO_FILIAL();

create or replace procedure PR_FILIAL_MES(mes varchar2, filial varchar2)
as
cursor somaDias is select sum(tb_venda.valor_total) as soma, dt_venda, nome_filial from tb_venda, tb_filial where tb_filial.cod_filial = tb_venda.cod_filial group by tb_venda.dt_venda, nome_filial;
resp varchar2(300);
begin
    for x in somaDias loop
        if mes = to_char(x.dt_venda, 'MM') and x.nome_filial = filial
            then resp := resp||chr(10)||x.dt_venda||' - R$ '||x.soma;
        end if;
    end loop;
    dbms_output.put_line(resp);
end;
/

call PR_FILIAL_MES('03', 'Filial A');
