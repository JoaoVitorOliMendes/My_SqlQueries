create or replace function fn_1a_palavra(valor varchar)
return varchar2
as
spaceIndex number:=length(valor)+1;
begin
    for x in 1 .. length(valor) loop
        if substr(valor, x, 1) = ' '
        then spaceIndex := x;
            exit;
        end if;
    end loop;
    return substr(valor, 0, spaceIndex -1);
end;
/


select fn_1a_palavra('alemanha') from dual;

set SERVEROUTPUT on;

create or replace procedure pr_conta_letra(caracter varchar, frase varchar)
as
contador number:=0;
begin
    for x in 1 .. length(frase) loop
        if substr(frase, x, 1) = caracter
        then contador := contador + 1;
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE(contador);
end;
/

exec pr_conta_letra('a', 'alemanha');
