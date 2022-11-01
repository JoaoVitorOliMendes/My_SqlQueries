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

set serveroutput on;



select cod_atendimento, to_char(atendimento.data_atendimento, 'dd/MM/yyyy HH24:MI:SS') as data_hora, paciente.nome_paciente from atendimento, funcionario, paciente, tarefa where atendimento.cod_funcionario = funcionario.cod_funcionario and atendimento.cod_paciente = paciente.cod_paciente and funcionario.nome_funcionario = 'Franjinha';
clear screen;
create or replace procedure PR_ATENDIMENTO(nomeFunc varchar2)
as
cursor cr_atendimento is select cod_atendimento, cod_funcionario, cod_paciente, cod_tarefa, to_char(atendimento.data_atendimento, 'dd/MM/yyyy HH24:MI:SS') as data_hora from atendimento;
cursor cr_funcionario is select cod_funcionario, nome_funcionario from funcionario;
cursor cr_paciente is select cod_paciente, nome_paciente from paciente;
cursor cr_tarefa is select cod_tarefa, nome_tarefa from tarefa;
begin
    for w in cr_funcionario loop
        if w.nome_funcionario = nomeFunc
            then for x in cr_atendimento loop
                if x.cod_funcionario = w.cod_funcionario
                    then for y in cr_paciente loop
                        if y.cod_paciente = x.cod_paciente
                            then for z in cr_tarefa loop
                                if z.cod_tarefa = x.cod_tarefa
                                    then dbms_output.put_line(x.cod_atendimento||' '||x.data_hora||' '||y.nome_paciente||' '||z.nome_tarefa);
                                end if;
                            end loop;
                        end if;
                    end loop;
                end if;
            end loop;
        end if;
    end loop;
end;
/

call PR_ATENDIMENTO('Franjinha');
