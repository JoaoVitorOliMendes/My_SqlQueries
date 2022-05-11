select nome_dependente
from dependente
where dt_nascimento =
(
    select min(dt_nascimento)
    from dependente
);

select nome_empregado
from empregado
where salario <
(
    select avg(salario)
    from empregado
);

select nome_empregado
from empregado
where admissao =
(
    select min(admissao)
    from empregado
);

select nome_empregado
from empregado
where salario =
(
    select min(salario)
    from empregado
);

select count(cod_empregado), setor.nome_setor
from empregado
join setor
on setor.cod_setor = empregado.cod_setor
group by setor.nome_setor;

select count(cod_dependente), empregado.nome_empregado
from dependente
right join empregado
on empregado.cod_empregado = dependente.cod_empregado
group by empregado.nome_empregado;

select empregado.nome_empregado
from empregado
left join dependente
on empregado.cod_empregado = dependente.cod_empregado
group by empregado.nome_empregado
having count(cod_dependente) =
(
    select max(count(cod_dependente))
    from empregado
    left join dependente
    on empregado.cod_empregado = dependente.cod_empregado
    group by empregado.nome_empregado
);

select empregado.nome_empregado
from empregado left join dependente
on empregado.cod_empregado = dependente.cod_empregado
group by empregado.nome_empregado
having count(dependente.cod_dependente) = 1;
