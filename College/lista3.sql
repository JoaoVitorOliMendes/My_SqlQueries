set serveroutput on;
clear screen

create or replace procedure PR_MOSTRA_VENDAS(nome varchar2)
is
cursor cr_resposta(valor varchar2) is
    select data_venda, valor_venda
    from venda_lista3, vendedor_lista3
    where venda_lista3.cod_vendedor = vendedor_lista3.cod_vendedor
    and lower(nome_vendedor) = lower(valor);
begin
    for x in cr_resposta(nome) loop
        DBMS_OUTPUT.PUT_LINE(x.data_venda||' '||x.valor_venda);
    end loop;
end;
/

call pr_mostra_vendas('um');

clear screen;
create or replace procedure PR_MAIOR_VENDA(nomeProduto varchar2)
is
cursor cr_vendas(codProduto number) is
select cod_vendedor, cod_produto, valor_venda
from venda_lista3 where cod_produto = codProduto;
idxCodProduto number;
idxNomeVendedor varchar2(60);
maior number := 0;
maiorVendedor number;
begin
    select cod_produto into idxCodProduto
    from produto_lista3
    where lower(produto_lista3.nome_produto) = lower(nomeProduto);
    
    for x in cr_vendas(idxCodProduto) loop
        if maior < x.valor_venda
        then maior := x.valor_venda;
        maiorVendedor := x.cod_vendedor;
        end if;
    end loop;
    
    select nome_vendedor into idxNomeVendedor
    from vendedor_lista3
    where vendedor_lista3.cod_vendedor = maiorVendedor;
    DBMS_OUTPUT.PUT_LINE(idxNomeVendedor||' '||maior);
end;
/

call PR_MAIOR_VENDA();
