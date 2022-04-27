select distinct tarefa.nome_tarefa
from tarefa, atendimento, funcionario
where tarefa.cod_tarefa = atendimento.cod_tarefa
    and funcionario.cod_funcionario = atendimento.cod_funcionario
    and lower(funcionario.nome_funcionario) = 'charlene silvassauro'
    and to_char(atendimento.data_atendimento, 'dd/mm/yyyy') = '02/10/2010';

select count(atendimento.cod_atendimento)
from atendimento, tarefa
where tarefa.cod_tarefa = atendimento.cod_tarefa
    and lower(tarefa.nome_tarefa) = 'coletar sangue';

select count(funcionario.cod_funcionario)
from funcionario, departamento
where funcionario.cod_departamento = departamento.cod_departamento
    and lower(departamento.nome_departamento) = 'enfermagem';

select paciente.nome_paciente
from paciente
where lower(paciente.nome_paciente) like '%u%o%'
    or lower(paciente.nome_paciente) like '%o%u%';

select funcionario.nome_funcionario
from funcionario, departamento
where funcionario.cod_departamento = departamento.cod_departamento
    and lower(departamento.nome_departamento) = 'enfermagem'
    and funcionario.nome_funcionario like '%P%';

select distinct funcionario.nome_funcionario
from funcionario, atendimento, tarefa
where tarefa.cod_tarefa = atendimento.cod_tarefa
    and funcionario.cod_funcionario = atendimento.cod_funcionario
    and to_char(atendimento.data_atendimento, 'dd/mm/yyyy') = '02/10/2010'
    and funcionario.cod_funcionario not in (
        select funcionario.cod_funcionario
        from funcionario, atendimento, tarefa
        where tarefa.cod_tarefa = atendimento.cod_tarefa
            and funcionario.cod_funcionario = atendimento.cod_funcionario
            and to_char(atendimento.data_atendimento, 'dd/mm/yyyy') = '03/10/2010'
    )
;

select distinct funcionario.nome_funcionario
from atendimento, funcionario, paciente
where funcionario.cod_funcionario = atendimento.cod_funcionario
    and paciente.cod_paciente = atendimento.cod_paciente
    and lower(paciente.nome_paciente) = 'chiquinha'
    and funcionario.nome_funcionario not in (
        select funcionario.nome_funcionario
        from atendimento, funcionario, paciente
        where funcionario.cod_funcionario = atendimento.cod_funcionario
            and paciente.cod_paciente = atendimento.cod_paciente
            and lower(paciente.nome_paciente) <> 'chiquinha'
    )
;

select paciente.nome_paciente
from atendimento, tarefa, paciente
where tarefa.cod_tarefa = atendimento.cod_tarefa
    and paciente.cod_paciente = atendimento.cod_paciente
    and lower(tarefa.nome_tarefa) = 'coletar urina'
    and paciente.cod_paciente not in (
        select paciente.cod_paciente
        from atendimento, tarefa, paciente
        where tarefa.cod_tarefa = atendimento.cod_tarefa
            and paciente.cod_paciente = atendimento.cod_paciente
            and lower(tarefa.nome_tarefa) = 'coletar sangue'
    )
;

select count(paciente.cod_paciente)
from atendimento, tarefa, paciente
where tarefa.cod_tarefa = atendimento.cod_tarefa
    and paciente.cod_paciente = atendimento.cod_paciente
    and lower(tarefa.nome_tarefa) = 'realizar ultrassom';

select count(paciente.cod_paciente)
from paciente
where paciente.cod_paciente not in (
        select paciente.cod_paciente
        from atendimento, paciente
        where paciente.cod_paciente = atendimento.cod_paciente
    )
;

-- 2. e)

-- 3. a)
