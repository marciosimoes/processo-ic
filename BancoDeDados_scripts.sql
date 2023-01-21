-- Criando o Banco de Dados
CREATE DATABASE psintutivecare;

-- Selecionando o DB
USE psintutivecare;

-- Criando tabela de cadastro de operadoras
CREATE TABLE operadoras_ativas (
    registro_ans int NOT NULL,
    cnpj bigint NOT NULL,
    razao_social varchar(255) NOT NULL,
    nome_fantasia varchar(100) NOT NULL,
    modalidade varchar(100) NOT NULL,
    logradouro varchar(255) NOT NULL,
    numero varchar(50) NOT NULL,
    complemento varchar(50) NOT NULL,
    bairro varchar(100) NOT NULL,   
    cidade varchar(100) NOT NULL,
    uf varchar(50) NOT NULL,
    cep varchar(50) NOT NULL,
    ddd varchar(10) NOT NULL,
    telefone varchar(50) NOT NULL,
    fax varchar(50) NOT NULL,
    email varchar(255) NOT NULL,
    representante varchar(255) NOT NULL,
    cargo_representante varchar(100) NOT NULL,
    data_registro_ans varchar(50) NOT NULL,
    PRIMARY KEY (registro_ans)
);

-- Carregando os cadastros das operadoras
LOAD DATA INFILE 'Relatorio_cadop(1) (2) (1).csv' INTO TABLE operadoras_ativas
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 3 ROWS;

-- Criando tabela de demonstração contábil
CREATE TABLE demonstracoes_contabeis (
    data date,
    reg_ans int NOT NULL,
    cd_conta_contabil varchar(50) NOT NULL,
    descricao varchar(255) NOT NULL,
    vl_saldo_inicial decimal(25,2),
    vl_saldo_final decimal(25,2)
);

-- Carregando os cadastros das operadoras
LOAD DATA INFILE 'demonstracoes_contabeis/all_data.csv' 
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS

-- Query resposta da primeira pergunta
SELECT 
    o.razao_social,
    d.reg_ans,
    sum(d.vl_saldo_final - d.vl_saldo_inicial) as df_total
FROM demonstracoes_contabeis d
INNER JOIN operadoras_ativas o
ON d.reg_ans = o.registro_ans
WHERE d.data = "2022-07-01"
AND d.descricao = "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR"
GROUP BY d.reg_ans
ORDER BY df_total DESC
LIMIT 10;

-- Query resposta da segunda pergunta
SELECT 
    o.razao_social,
    d.reg_ans,
    sum(d.vl_saldo_final - d.vl_saldo_inicial) as df_total
FROM demonstracoes_contabeis d
INNER JOIN operadoras_ativas o
ON d.reg_ans = o.registro_ans
WHERE d.data IN ("2022-07-01","2022-04-01","2022-01-01","2021-10-01")
AND d.descricao = "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR"
GROUP BY d.reg_ans
ORDER BY df_total DESC
LIMIT 10;
