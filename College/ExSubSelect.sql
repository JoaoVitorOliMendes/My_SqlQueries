--1
select tb_medico.nome_medico
from tb_consulta
    join tb_lista_exame on tb_lista_exame.cod_consulta = tb_consulta.cod_consulta
    join tb_exame on tb_lista_exame.cod_exame = tb_exame.cod_exame
    join tb_medico on tb_medico.cod_medico = tb_consulta.cod_medico
where tb_exame.valor_exame = (select min(valor_exame) from tb_exame);

--2
select tb_exame.nome_exame
from tb_exame
where tb_exame.valor_exame = (
    select max(tb_exame.valor_exame)
    from tb_exame
    join tb_lista_exame on tb_lista_exame.cod_exame = tb_exame.cod_exame
);

--select max(tb_exame.valor_exame) from tb_exame join tb_lista_exame on tb_lista_exame.cod_exame = tb_exame.cod_exame;

--3
select tb_paciente.nome_paciente
from tb_paciente
where tb_paciente.cod_paciente not in (
    select tb_consulta.cod_paciente
    from tb_consulta
    join tb_paciente on tb_paciente.cod_paciente = tb_consulta.cod_paciente
    join tb_lista_exame on tb_lista_exame.cod_consulta = tb_consulta.cod_consulta
    join tb_exame on tb_exame.cod_exame = tb_lista_exame.cod_exame
);

/*select distinct tb_consulta.cod_paciente
    from tb_consulta
    join tb_paciente on tb_paciente.cod_paciente = tb_consulta.cod_paciente
    order by tb_consulta.cod_paciente;

select distinct tb_paciente.nome_paciente
from tb_paciente
join tb_consulta on tb_paciente.cod_paciente = tb_consulta.cod_paciente
join tb_lista_exame on tb_lista_exame.cod_consulta = tb_consulta.cod_consulta
join tb_exame on tb_exame.cod_exame = tb_lista_exame.cod_exame;
select * from tb_paciente;
*/

--4
SELECT avg(valor_exame) from tb_exame;

--5
select count(valor_exame) from tb_exame where valor_exame > (SELECT avg(valor_exame) from tb_exame);

--6
select tb_exame.nome_exame
from tb_exame
where nome_exame not in (
    select nome_exame
    from tb_exame
    join tb_lista_exame on tb_exame.cod_exame = tb_lista_exame.cod_exame
    join tb_consulta on tb_lista_exame.cod_consulta = tb_consulta.cod_consulta
);

--7
select tb_medico.nome_medico
from tb_medico
where tb_medico.cod_medico in (
    select cod_medico
    from tb_consulta
    join tb_paciente on tb_paciente.cod_paciente = tb_consulta.cod_paciente
    where lower(tb_paciente.sexo) = 'f'
)
and tb_medico.cod_medico not in (
    select cod_medico
    from tb_consulta
    join tb_paciente on tb_paciente.cod_paciente = tb_consulta.cod_paciente
    where lower(tb_paciente.sexo) = 'm'
);
