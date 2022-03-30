--select * from all_tables
--select * from dependente where nome_dependente like 'M%';
--select * from empregado where nome_empregado like '%son';
--select * from empregado where nome_empregado like 'M%';
--select * from empregado where nome_empregado not like 'Pat%';
--select * from empregado where salario < 1000;
--select * from empregado where salario > 2000 and salario < 3000;
--select * from empregado where salario between 2000 and 3000;
--select * from empregado where (to_char(admissao, 'MM')) = 05
--select * from empregado where (to_char(admissao, 'YYYYMMDD')) between '20120510' and '20120530'
--select * from dependente where (to_char(dt_nascimento, 'YYYY')) = '2004';
--select * from funcionario where nome_funcionario like 'M%c_';
select * 
from funcionario
    join departamento
    on departamento.cod_departamento = funcionario.cod_setor
where nome_funcionario like 'M%c_'
and departamento.nome_departamento = 'Produção';
