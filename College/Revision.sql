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
references professor(cod_professor)
);

--3.
--d

--4.
--a)
select login_usuario
from usuario, conexao
where usuario.cod_usuario = conexao.cod_usuario
group by usuario.login_usuario
having count(conexao.cod_cnx) =
(
    select max(count(cod_cnx))
    from conexao
    group by cod_usuario
);

--b)
select to_char(data_cnx, 'DD/MM/YYYY')
from conexao
group by to_char(data_cnx, 'DD/MM/YYYY')
having count(cod_cnx) =
(
    select min(count(cod_cnx))
    from conexao
    group by to_char(data_cnx, 'DD/MM/YYYY')
);

--c)
select conexao.cod_cnx
from conexao, comandos
where conexao.cod_cnx = comandos.cod_cnx
group by conexao.cod_cnx
having count(cod_cmd) =
(
    select max(count(cod_cnx))
    from comandos
    group by cod_cnx
);

--d)
select to_char(data_cmd, 'HH24')
from comandos
group by to_char(data_cmd, 'HH24')
having count(cod_cmd) =
(
    select max(count(cod_cmd))
    from comandos
    group by to_char(data_cmd, 'HH24')
);

--e)
select login_usuario
from usuario left join conexao
on usuario.cod_usuario = conexao.cod_usuario
left join comandos
on conexao.cod_cnx = comandos.cod_cnx
group by login_usuario
having count(cod_cmd) =
(
    select min(count(cod_cmd))
    from usuario left join conexao
    on usuario.cod_usuario = conexao.cod_usuario
    left join comandos
    on conexao.cod_cnx = comandos.cod_cnx
    group by login_usuario
);

--6
--e
