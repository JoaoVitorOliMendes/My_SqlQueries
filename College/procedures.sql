/*
clear screen;

set serveroutput on;

create or replace procedure pr_mostra_par(v_ini number, v_fim number)
as
begin
    for x in v_ini .. v_fim loop
        if mod(x, 2) = 0
            then DBMS_OUTPUT.PUT(x||', ');
        end if;
    end loop;
    DBMS_OUTPUT.put_line('');
end;
/

call pr_mostra_par(3, 25);
--exec pr_mostra_par(3, 25);
*/
create or replace procedure pr_pa_pg(tipo varchar, valor_ini number, razao number, termos number)
as
total number;
begin
    total := valor_ini;
    if tipo = 'PA'
        then for x in 1 .. termos loop
            DBMS_OUTPUT.PUT(total||' ');
            total := total + razao;
        end loop;
        elsif tipo = 'PG'
            then for x in 1 .. termos loop
            DBMS_OUTPUT.PUT(total||' ');
            total := total * razao;
        end loop;
    end if;
    DBMS_OUTPUT.put_line('');
end;
/

call pr_pa_pg('PG', 1, 2, 999);
