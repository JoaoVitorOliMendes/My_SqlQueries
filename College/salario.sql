set serveroutput on;
clear screen;

create or replace procedure pr_folha(valor varchar2)
as
cursor cr_vendedor is select cod_vendedor, nome_vendedor, salario_vendedor from vendedor_lista3;
cursor cr_prod_venda is select valor_venda, valor_produto, cod_vendedor, data_venda from produto_lista3 p, venda_lista3 v where v.cod_produto = p.cod_produto;
comissao number;
begin
    dbms_output.put_line('Mês: '||valor);
    dbms_output.put_line('');
    for x in cr_vendedor loop
        comissao:=0;
        dbms_output.put_line('Funcionário: '||x.nome_vendedor);
        dbms_output.put_line('Salário: '||x.salario_vendedor);
        for y in cr_prod_venda loop
            if to_char(y.data_venda, 'MM/YYYY') = valor and x.cod_vendedor = y.cod_vendedor
                then comissao:=comissao + ((y.valor_venda-y.valor_produto)*0.3);
            end if;
        end loop;
        dbms_output.put_line('Comissão: '||comissao);
        dbms_output.put_line('Total: '||(x.salario_vendedor+comissao));
        dbms_output.put_line('');
    end loop;
end;
/

call pr_folha('03/2016');
--select valor_venda, cod_vendedor, data_venda from produto_lista3 p, venda_lista3 v where v.cod_produto = p.cod_produto;
--select cod_vendedor, nome_vendedor, salario_vendedor from vendedor_lista3;
