--1
select candidato.nome_candidato, cargo.nome_cargo
from cargo, candidato
where cargo.cod_cargo = candidato.cod_cargo;

--2
select candidato.nome_candidato
from candidato
where lower(candidato.nome_candidato) like '%p%';

--3
select candidato.nome_candidato, partido.nome_partido
from candidato, partido
where partido.cod_partido = candidato.cod_partido
    and partido.nome_partido = 'PQX';

--4
select distinct cargo.nome_cargo
from cargo, candidato, partido
where cargo.cod_cargo = candidato.cod_cargo
    and  partido.cod_partido = candidato.cod_partido
    and partido.nome_partido = 'PZY';

--5
select count(numero)
from voto;

--6
select count(voto.numero)
from voto, candidato
where candidato.numero = voto.numero
    and candidato.nome_candidato = 'Cebolinha';

--7
select count(voto.numero)
from voto, candidato, partido
where candidato.numero = voto.numero
    and partido.cod_partido = candidato.cod_partido
    and partido.nome_partido = 'PXL';

--8
select count(voto.numero)
from voto, partido, cargo, candidato
where voto.cod_cargo = cargo.cod_cargo
    and voto.numero = candidato.numero
    and partido.cod_partido = candidato.cod_partido
    and cargo.cod_cargo = candidato.cod_cargo
    and partido.nome_partido = 'PQX'
    and cargo.nome_cargo = 'Senador';

select candidato.nome_candidato, count(voto.numero)
from candidato, voto, cargo
where candidato.numero = voto.numero
    and cargo.cod_cargo = voto.cod_cargo
    and cargo.cod_cargo = candidato.cod_cargo
    and cargo.nome_cargo = 'Presidente'
group by candidato.nome_candidato;

--9
select candidato.nome_candidato, cargo.nome_cargo from candidato, cargo where cargo.cod_cargo = candidato.cod_cargo and lower(candidato.nome_candidato) = 'mônica';

--10
select partido.nome_partido from cargo, candidato, partido where cargo.cod_cargo = candidato.cod_cargo and  partido.cod_partido = candidato.cod_partido and cargo.nome_cargo = 'Presidente';

--11
select candidato.nome_candidato, count(voto.numero) as total from voto, candidato where candidato.numero = voto.numero group by candidato.nome_candidato order by total desc;
