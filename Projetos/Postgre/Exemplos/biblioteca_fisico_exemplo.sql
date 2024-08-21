﻿-- DROPS MODO DEV
DROP TABLE IF EXISTS livro_autor;
DROP TABLE IF EXISTS livro;
DROP SEQUENCE IF EXISTS livro_id_seq;
DROP TABLE IF EXISTS categoria;
DROP SEQUENCE IF EXISTS categoria_id_seq;
DROP TABLE IF EXISTS autor;
DROP SEQUENCE IF EXISTS autor_id_seq;

-- TABELA AUTOR
CREATE SEQUENCE IF NOT EXISTS autor_id_seq;

CREATE TABLE IF NOT EXISTS autor (
   id INTEGER NOT NULL DEFAULT NEXTVAL('autor_id_seq'),
   nome CHARACTER VARYING(100) NOT NULL,
   excluido BOOLEAN DEFAULT false,
   CONSTRAINT autor_pk PRIMARY KEY (id)
);

-- TABELA CATEGORIA
CREATE SEQUENCE IF NOT EXISTS categoria_id_seq;

CREATE TABLE IF NOT EXISTS categoria (
   id INTEGER NOT NULL DEFAULT NEXTVAL('categoria_id_seq'),
   nome CHARACTER VARYING(100) NOT NULL,
   excluido BOOLEAN DEFAULT false,
   CONSTRAINT categoria_pk PRIMARY KEY (id)
);

-- TABELA LIVRO
CREATE SEQUENCE IF NOT EXISTS livro_id_seq;

CREATE TABLE IF NOT EXISTS livro (
   id INTEGER NOT NULL DEFAULT NEXTVAL('livro_id_seq'),
   nome CHARACTER VARYING(100) NOT NULL,
   id_categoria INTEGER NOT NULL,
   isbn CHARACTER VARYING(30) NOT NULL,
   excluido BOOLEAN DEFAULT false,
   CONSTRAINT livro_pk PRIMARY KEY (id),
   CONSTRAINT livro_categoria_id_categoria_fk
   FOREIGN KEY (id_categoria) REFERENCES categoria (id) 
   ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA LIVRO_AUTOR

CREATE TABLE IF NOT EXISTS livro_autor (
   id_autor INTEGER NOT NULL,
   id_livro INTEGER NOT NULL,

   CONSTRAINT livro_autor_pk PRIMARY KEY (id_autor, id_livro),

   CONSTRAINT livro_autor_autor_id_autor_fk
   FOREIGN KEY (id_autor) REFERENCES autor (id) 
   ON DELETE NO ACTION ON UPDATE NO ACTION,
   
   CONSTRAINT livro_autor_livro_id_livro_fk
   FOREIGN KEY (id_livro) REFERENCES livro (id) 
   ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO autor (nome) VALUES ('JORGE AMADO');
INSERT INTO autor (nome) VALUES ('JOAO UBAUDO RIBEIRO');

INSERT INTO categoria (nome) VALUES ('FANTASIA');
INSERT INTO categoria (nome) VALUES ('DRAMA');

INSERT INTO livro (nome, isbn, id_categoria) VALUES ('O ANJO DA MORTE', '98498489498', 1);
INSERT INTO livro (nome, isbn, id_categoria) VALUES ('JOAZINHO E MARIA', '654654654564', 2);

INSERT INTO livro_autor (id_autor, id_livro) VALUES (1, 1);
INSERT INTO livro_autor (id_autor, id_livro) VALUES (1, 2);
INSERT INTO livro_autor (id_autor, id_livro) VALUES (2, 2);