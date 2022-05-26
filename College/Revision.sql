--1.
--a)
select sexo
from karateca
group by sexo
having count(cod_karateca) =
(
    select max(count(cod_karateca))
    from karateca
    group by sexo
);

--b)
select faixa.nome_faixa
from karateca right join faixa
on karateca.cod_faixa = faixa.cod_faixa
group by faixa.nome_faixa
having count(karateca.cod_karateca) =
(
    select min(count(karateca.cod_karateca))
    from karateca right join faixa
    on karateca.cod_faixa = faixa.cod_faixa
    group by faixa.nome_faixa
);

--c)
select academia.nome_academia
from karateca right join academia
on karateca.cod_academia = academia.cod_academia
group by academia.nome_academia
having count(karateca.cod_karateca) =
(
    select min(count(karateca.cod_karateca))
    from karateca right join academia
    on karateca.cod_academia = academia.cod_academia
    group by academia.nome_academia
);

--d)
select count(karateca.cod_karateca)
from 
(
    select *
    from karateca
    where lower(sexo) = 'f'
) karateca right join faixa
on karateca.cod_faixa = faixa.cod_faixa
group by faixa.nome_faixa;

--e)
select to_char(karateca.data_nascimento, 'YYYY')
from karateca
group by to_char(karateca.data_nascimento, 'YYYY')
having count(karateca.cod_karateca) =
(
    select max(count(karateca.cod_karateca))
    from karateca
    group by to_char(karateca.data_nascimento, 'YYYY')
);

--2.

create table professor(
cod_professor number(3) constraint pk_professor primary key,
nome_professor varchar2(30)
);

create table prova(
cod_prova number(3) constraint pk_prova primary key,
data_prova date,
valor_prova number(4,2),
cod_professor number(3) constraint fk_professor
references professor
);

--3.
--b
