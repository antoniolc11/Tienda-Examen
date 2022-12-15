DROP TABLE IF EXISTS articulos CASCADE;

CREATE TABLE articulos (
    id          bigserial     PRIMARY KEY,
    codigo      varchar(13)   NOT NULL UNIQUE,
    descripcion varchar(255)  NOT NULL,
    precio      numeric(7, 2) NOT NULL,
    unidades    INTEGER       NOT NULL
);

DROP TABLE IF EXISTS usuarios CASCADE;

CREATE TABLE usuarios (
    id       bigserial    PRIMARY KEY,
    usuario  varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL
);

DROP TABLE IF EXISTS validados CASCADE;

CREATE TABLE validados (
    id       bigserial    PRIMARY KEY,
    usuario_id  BIGINT NOT  NULL REFERENCES usuarios (id),
    validado    BOOLEAN NOT NULL,
    UNIQUE(usuario_id, validado)
);

DROP TABLE IF EXISTS facturas CASCADE;

CREATE TABLE facturas (
    id         bigserial  PRIMARY KEY,
    created_at timestamp  NOT NULL DEFAULT localtimestamp(0),
    usuario_id bigint NOT NULL REFERENCES usuarios (id)
);

DROP TABLE IF EXISTS articulos_facturas CASCADE;

CREATE TABLE articulos_facturas (
    articulo_id bigint NOT NULL REFERENCES articulos (id),
    factura_id  bigint NOT NULL REFERENCES facturas (id),
    cantidad    int    NOT NULL,
    PRIMARY KEY (articulo_id, factura_id)
);

-- Carga inicial de datos de prueba:

INSERT INTO articulos (codigo, descripcion, precio, unidades)
    VALUES ('18273892389', 'Yogur piña', 200.50, 10),
           ('83745828273', 'Tigretón', 50.10, 15),
           ('51736128495', 'Disco duro SSD 500 GB', 150.30, 25),
           ('83746828273', 'Tigretón', 50.10, 0),
           ('51786128435', 'Disco duro SSD 500 GB', 150.30, 3),
           ('83745228673', 'Tigretón', 50.10, 4),
           ('51786198495', 'Disco duro SSD 500 GB', 150.30, 10);

INSERT INTO usuarios (usuario, password)
    VALUES ('admin', crypt('admin', gen_salt('bf', 10))),
           ('pepe', crypt('pepe', gen_salt('bf', 10)));


INSERT INTO validados (usuario_id, validado)
    VALUES (1, true),
           (2, false);