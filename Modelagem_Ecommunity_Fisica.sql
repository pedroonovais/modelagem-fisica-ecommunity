DROP TABLE tb_contato_usuario CASCADE CONSTRAINTS;
DROP TABLE tb_local CASCADE CONSTRAINTS;
DROP TABLE tb_login_usuario CASCADE CONSTRAINTS;
DROP TABLE tb_materia CASCADE CONSTRAINTS;
DROP TABLE tb_usuario CASCADE CONSTRAINTS;

CREATE TABLE tb_usuario (
    id_usuario    NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    nome_usuario  VARCHAR2(180) NOT NULL,
    email_usuario VARCHAR2(150) NOT NULL,
    qtd_pontos    INTEGER,
    admin         CHAR(1) NOT NULL CHECK (admin IN ('S', 'N'))
);

CREATE TABLE tb_contato_usuario (
    id_usuario       NUMBER NOT NULL,
    telefone_usuario VARCHAR2(20),
    PRIMARY KEY (id_usuario, telefone_usuario),
    CONSTRAINT tb_contato_usuario_fk FOREIGN KEY (id_usuario)
        REFERENCES tb_usuario (id_usuario)
);

CREATE TABLE tb_local (
    id_local                NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    nome_local              VARCHAR2(50),
    categoria               VARCHAR2(50),
    logradouro_numero_local VARCHAR2(200),
    cep_local               VARCHAR2(9),
    cidade_local            VARCHAR2(50),
    estado_local            VARCHAR2(50),
    latitude_local          VARCHAR(50),
    longitude_local         VARCHAR(50)
);

CREATE TABLE tb_login_usuario (
    id_usuario    NUMBER NOT NULL,
    login_usuario VARCHAR2(20) NOT NULL,
    senha    VARCHAR2(255) NOT NULL,
    PRIMARY KEY (id_usuario),
    CONSTRAINT tb_login_usuario_fk FOREIGN KEY (id_usuario)
        REFERENCES tb_usuario (id_usuario)
);

CREATE TABLE tb_materia (
    id_materia  NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    id_usuario  NUMBER NOT NULL,
    titulo_materia VARCHAR2(100),
    texto_materia  VARCHAR2(4000),
    img_capa    VARCHAR2(4000),
    ativo       CHAR(1) CHECK (ativo IN ('S', 'N')),
    dt_criacao  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dt_update   TIMESTAMP,
    CONSTRAINT tb_materia_fk FOREIGN KEY (id_usuario)
        REFERENCES tb_usuario (id_usuario)
);

CREATE OR REPLACE TRIGGER before_update_tb_materia
BEFORE UPDATE ON tb_materia
FOR EACH ROW
BEGIN
    IF :OLD.texto_materia != :NEW.texto_materia THEN
        :NEW.dt_update := CURRENT_TIMESTAMP;
    END IF;
END;
/

-- Inserts para a tabela tb_usuario
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Alice Santos', 'alice.santos@email.com', 100, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Bruno Silva', 'bruno.silva@email.com', 50, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Carla Souza', 'carla.souza@email.com', 200, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Daniel Costa', 'daniel.costa@email.com', 150, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Eduarda Dias', 'eduarda.dias@email.com', 80, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Felipe Martins', 'felipe.martins@email.com', 300, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Gabriela Alves', 'gabriela.alves@email.com', 120, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Hugo Mendes', 'hugo.mendes@email.com', 75, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Isabela Teixeira', 'isabela.teixeira@email.com', 130, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Jo�o Pinto', 'joao.pinto@email.com', 110, 'N');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Pedro Novais', 'pedro.novais@gmail.com', 110, 'S');
INSERT INTO tb_usuario (nome_usuario, email_usuario, qtd_pontos, admin) VALUES ('Rodrigo Rios', 'rodrigo.rios@gmail.com', 110, 'S');

-- Inserts para a tabela tb_contato_usuario
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (1, '11987654321');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (2, '11987651234');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (3, '11987657890');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (4, '11987655678');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (5, '11987653456');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (6, '11987652345');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (7, '11987659876');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (8, '11987658765');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (9, '11987657654');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (10, '11987656543');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (11, '11987656545');
INSERT INTO tb_contato_usuario (id_usuario, telefone_usuario) VALUES (12, '11987656546');

-- Inserts para a tabela tb_locais
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('Eco Loja', 'Loja Sustent�vel', 'Rua Verde, 45', '12345000', 'S�o Paulo', 'SP', '-23.5505', '-46.6333');
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('Bike Park', 'Biciclet�rio', 'Avenida Azul, 300', '67890000', 'Rio de Janeiro', 'RJ', '-22.9068', '-43.1729');
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('Recicla Center', 'Ponto de Reciclagem', 'Rua Amarela, 100', '12345678', 'Belo Horizonte', 'MG', '-19.9167', '-43.9345');
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('Green Spot', 'Centro de Sustentabilidade', 'Rua dos L�rios, 500', '23456000', 'Curitiba', 'PR', '-25.4296', '-49.2714');
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('EcoPoint', 'Ponto de Coleta', 'Avenida Flores, 150', '34567000', 'Porto Alegre', 'RS', '-30.0346', '-51.2177');
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('Loja Verde', 'Loja Sustent�vel', 'Rua das Palmeiras, 200', '45678000', 'Fortaleza', 'CE', '-3.7172', '-38.5433');
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('Sustentabilidade em A��o', 'Centro de Reciclagem', 'Rua do Meio Ambiente, 50', '56789000', 'Salvador', 'BA', '-12.9714', '-38.5014');
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('Ponto Eco', 'Biciclet�rio', 'Avenida do Sol, 800', '67890100', 'Natal', 'RN', '-5.7945', '-35.2110');
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('Verde Vida', 'Loja Sustent�vel', 'Rua das �rvores, 90', '78901200', 'Recife', 'PE', '-8.0476', '-34.8770');
INSERT INTO tb_local (nome_local, categoria, logradouro_numero_local, cep_local, cidade_local, estado_local, latitude_local, longitude_local) 
VALUES ('Natureza Preservada', 'Ponto de Reciclagem', 'Rua do Verde, 320', '89012300', 'Macei�', 'AL', '-9.6650', '-35.7351');

-- Inserts para a tabela tb_login_usuario
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (1, 'alice.s', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (2, 'bruno.s', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (3, 'carla.s', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (4, 'daniel.c', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (5, 'eduarda.d', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (6, 'felipe.m', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (7, 'gabriela.a', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (8, 'hugo.m', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (9, 'isabela.t', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (10, 'joao.p', '$2a$10$yvpHLTc92BIX9ZT4XOaRleP4Ve2EZkFw79erIr5LsDX7Bm9/Y6nB2');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (11, 'pedro.novais', 'Pedro.novais@12');
INSERT INTO tb_login_usuario (id_usuario, login_usuario, senha) VALUES (12, 'rodrigo.rios', 'Rodrigo.rios@12');

-- Inser��es na tabela `tb_materia`
INSERT INTO tb_materia 
(ID_USUARIO, TITULO_MATERIA, TEXTO_MATERIA, IMG_CAPA, ATIVO, DT_CRIACAO, DT_UPDATE) 
VALUES
(
    1, 
    'A Import�ncia da Sustentabilidade', 
    'Este artigo discute a import�ncia de pr�ticas sustent�veis no dia a dia, abordando desde o consumo consciente at� o impacto ambiental.', 
    '1.jpg', 
    'S', 
    TO_TIMESTAMP('2024-11-16 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    TO_TIMESTAMP('2024-11-16 08:00:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_materia 
(ID_USUARIO, TITULO_MATERIA, TEXTO_MATERIA, IMG_CAPA, ATIVO, DT_CRIACAO, DT_UPDATE) 
VALUES
( 
    2, 
    'Tecnologia Verde', 
    'A revolu��o tecnol�gica est� ajudando a reduzir a pegada ecol�gica. Empresas est�o investindo em inova��es que permitem a produ��o mais eficiente e menos poluente.', 
    '2.jpg', 
    'S', 
    TO_TIMESTAMP('2024-11-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    TO_TIMESTAMP('2024-11-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_materia 
(ID_USUARIO, TITULO_MATERIA, TEXTO_MATERIA, IMG_CAPA, ATIVO, DT_CRIACAO, DT_UPDATE) 
VALUES
(
    1, 
    'Energias Renov�veis: O Futuro da Energia', 
    'Com o aumento da demanda por energia, as fontes renov�veis se tornam cada vez mais essenciais para garantir um futuro sustent�vel para o planeta.', 
    '3.jpg', 
    'S', 
    TO_TIMESTAMP('2024-11-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    TO_TIMESTAMP('2024-11-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_materia 
(ID_USUARIO, TITULO_MATERIA, TEXTO_MATERIA, IMG_CAPA, ATIVO, DT_CRIACAO, DT_UPDATE) 
VALUES
( 
    1, 
    'Educa��o Ambiental para as Novas Gera��es', 
    'A educa��o ambiental � essencial para criar uma nova gera��o de cidad�os conscientes e dispostos a agir em favor da preserva��o ambiental.', 
    '4.jpg', 
    'S', 
    TO_TIMESTAMP('2024-11-16 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    TO_TIMESTAMP('2024-11-16 11:00:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_materia 
(ID_USUARIO, TITULO_MATERIA, TEXTO_MATERIA, IMG_CAPA, ATIVO, DT_CRIACAO, DT_UPDATE) 
VALUES
(
    1, 
    'Reciclagem e Reutiliza��o: Salvando o Planeta', 
    'A reciclagem � uma das solu��es mais simples e eficazes para reduzir o desperd�cio e salvar recursos naturais. Este artigo explora a import�ncia da reciclagem em nossas vidas.', 
    '5.jpg', 
    'S', 
    TO_TIMESTAMP('2024-11-16 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    TO_TIMESTAMP('2024-11-16 12:00:00', 'YYYY-MM-DD HH24:MI:SS')
);


COMMIT;
