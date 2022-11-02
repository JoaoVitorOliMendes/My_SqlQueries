SET SERVEROUTPUT ON;
CLEAR SCREEN;

--insert into login VALUES (1, 'JOAO', '070072074054082080052087076053');

create or replace function fn_criptografia(senha varchar2, acrescimo number)
return varchar2
as
string1 varchar2(50);
string2 varchar2(50);
string3 varchar2(50);
asc2 varchar2(150);
begin
    for x in 1..length(senha) loop
        asc2 :=(ASCII(substr(senha, x, 1)) + acrescimo);
        if mod(x, 3) = 0
        then string1 := concat(string1, rpad('0', 3-mod(length(asc2), 3), '0')||asc2);
            elsif mod(x, 3) = 1
            then string2 := concat(string2, rpad('0', 3-mod(length(asc2), 3), '0')||asc2);
                elsif mod(x, 3) = 2
                then string3 := concat(string3, rpad('0', 3-mod(length(asc2), 3), '0')||asc2);
        end if;
    end loop;
    return string2||string3||string1;
end;
/

--select fn_criptografia('VAGNERLOV', 3) from dual;

create or replace function fn_descriptografia(senhaCripto varchar2, acrescimo number)
return varchar2
as
senhaChar varchar2(150);
senhaFinal varchar2(150);
pulo number;
pulo2 number;
begin
    for x in 1..length(senhaCripto)/3 loop
        senhaChar := senhaChar||chr((substr(senhaCripto, (x*3)-2, 1)||substr(senhaCripto, (x*3)-1, 1)||substr(senhaCripto, x*3, 1) - acrescimo));
    end loop;
    
    pulo := floor(length(senhaChar)/3);
    if mod(length(senhaChar), 3) > 0
    then pulo := pulo + 1;
    end if;
    
    pulo2 := floor(length(senhaChar)/3);
    if mod(length(senhaChar), 3) > 1
    then pulo2 := pulo2 + 1;
    end if;
    
    for x in 1..pulo loop
        senhaFinal := senhaFinal||substr(senhaChar, x, 1)||substr(senhaChar, (x+pulo), 1)||substr(senhaChar, (x+pulo+pulo2), 1);
    end loop;
    
    if length(senhaFinal) <> length(senhaChar)
    then senhaFinal := substr(senhaFinal, 1, length(senhaChar));
    end if;
    
    return senhaFinal;
end;
/

--select fn_descriptografia(fn_criptografia('A', 3), 3) from dual;
--drop sequence;
--create sequence sq_login;

create or replace procedure pr_insere_login(codLogin number, loginPar varchar2, senha varchar2)
as
codLoginEx number;
loginEx varchar2(150);
senhaCripto varchar2(150);
dateTime TIMESTAMP;
begin
    dateTime := SYSTIMESTAMP;
    select (select login.cod_login from login where login.cod_login = codLogin) into codLoginEx
    from dual;
    select (select login.login from login where login.login = loginPar) into loginEx
    from dual;
    
    dbms_output.put_line(loginEx||' '||codLoginEx);
    
    if codLoginEx is null and loginEx is null
    then senhaCripto := fn_criptografia(senha, to_char(dateTime, 'FF1'));
    insert into login(cod_login, login, senha) values (codLogin, loginPar, senhaCripto);
    insert into acesso(cod_login, data_hora) values (codLogin, dateTime);
    else dbms_output.put_line('Codigo de login ou login ja cadastrados');
    end if;
end;
/

--call pr_insere_login(2, 'DAIEGAO', 'VAGNERLOV');
--select * from acesso;

create or replace procedure pr_valida_login(loginPar varchar2, senhaPar varchar2)
as
codLoginEx number;
senhaLoginEX varchar2(150);
dateTime TIMESTAMP;
mlSec varchar2(10);
descripto varchar2(150);
begin
    dateTime := SYSTIMESTAMP;
    select (select login.cod_login from login where login.login = loginPar) into codLoginEx
    from dual;
    
    if codLoginEx is not null
    then 
        select (select to_char(acesso.data_hora, 'FF1') from acesso where acesso.cod_login = codLoginEx) into mlSec
        from dual;
        select (select login.senha from login where login.login = loginPar) into senhaLoginEX
        from dual;
        descripto := fn_descriptografia(senhaLoginEX, mlSec);
        if descripto = senhaPar
        then dbms_output.put_line('Acessou');
        update acesso set data_hora = dateTime where cod_login = codLoginEx;
        update login set senha = fn_criptografia(descripto, to_char(dateTime, 'FF1')) where cod_login = codLoginEx;
        else dbms_output.put_line('Nao acessou');
        end if;
    else dbms_output.put_line('Login nao existe');
    end if;
end;
/

--call pr_valida_login('DIEGAO', 'VAGNERLOV');
--select * from acesso;
--select * from login;
