select count(departamento)
from departamento;

select funcionario.nome_funcionario
from departamento join funcionario
on funcionario.cod_departamento = departamento.cod_departamento
where lower(departamento.nome_departamento) = 'produção'
    and funcionario.ramal is not null;

select estado.nome_estado, count(funcionario.nome_funcionario)
from funcionario right join estado
on funcionario.cod_estado = estado.cod_estado
group by estado.nome_estado;

select departamento.nome_departamento, count(funcionario.nome_funcionario), estado.nome_estado
from funcionario join estado
on funcionario.cod_estado = estado.cod_estado
join departamento
on departamento.cod_departamento = funcionario.cod_departamento
group by departamento.nome_departamento, estado.nome_estado
order by departamento.nome_departamento;

select funcionario.nome_funcionario, estado.nome_estado
from funcionario, estado
where funcionario.cod_estado = estado.cod_estado
    and lower(estado.nome_estado) in ('acre', 'amazonas', 'pará', 'rondônia', 'roraima', 'amapá', 'tocantins');

select funcionario.nome_funcionario, estado.nome_estado
from departamento join funcionario
on funcionario.cod_departamento = departamento.cod_departamento
join estado
on funcionario.cod_estado = estado.cod_estado
where lower(departamento.nome_departamento) = 'produção'
    and lower(estado.nome_estado) in ('bahia', 'goiás');


select funcionario.nome_funcionario
from funcionario join estado
on funcionario.cod_estado = estado.cod_estado
where lower(estado.nome_estado) = 'rio de janeiro'
    and funcionario.idade =
    (
        select min(funcionario.idade)
        from funcionario join estado
        on funcionario.cod_estado = estado.cod_estado
        where lower(estado.nome_estado) = 'rio de janeiro'
    );
