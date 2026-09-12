-- BIBLIOTECA COMBARRANQUILLA
-- Instalación SEGURA de la estructura.
-- IMPORTANTE: este archivo NO hace DROP DATABASE y NO elimina registros existentes.
-- Si la base ya existe, conserva sus datos.

CREATE DATABASE IF NOT EXISTS biblioteca_laoc1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE biblioteca_laoc1;

CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    documento VARCHAR(30) NOT NULL UNIQUE,
    telefono VARCHAR(20), correo VARCHAR(150) UNIQUE,
    direccion VARCHAR(200), fecha_registro DATE NOT NULL DEFAULT (CURRENT_DATE)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL, nacionalidad VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS editoriales (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL, ciudad VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(30) UNIQUE,
    anio_publicacion YEAR,
    id_autor INT NOT NULL, id_editorial INT NOT NULL, id_categoria INT NOT NULL,
    CONSTRAINT fk_libro_autor FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    CONSTRAINT fk_libro_editorial FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial),
    CONSTRAINT fk_libro_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_prestamo DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_limite DATE NULL,
    fecha_devolucion DATE NULL,
    estado ENUM('PRESTADO','DEVUELTO','ATRASADO') NOT NULL DEFAULT 'PRESTADO',
    CONSTRAINT fk_prestamo_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS detalle_prestamo (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_prestamo INT NOT NULL, id_libro INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_detalle_prestamo FOREIGN KEY (id_prestamo) REFERENCES prestamos(id_prestamo) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_libro FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS usuarios_sistema (
    id_usuario_sistema INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(80) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    password_hash CHAR(64) NOT NULL,
    rol ENUM('ADMINISTRADOR','BIBLIOTECARIO') NOT NULL DEFAULT 'BIBLIOTECARIO',
    activo TINYINT(1) NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS auditoria (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    tabla_afectada VARCHAR(100) NOT NULL,
    operacion VARCHAR(20) NOT NULL,
    id_registro INT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(255)
) ENGINE=InnoDB;

CREATE INDEX idx_libros_titulo ON libros(titulo);
CREATE INDEX idx_prestamos_usuario ON prestamos(id_usuario);
CREATE INDEX idx_prestamos_estado ON prestamos(estado);

CREATE OR REPLACE VIEW vista_libros AS
SELECT l.id_libro,l.titulo,l.isbn,l.anio_publicacion,
       a.nombre AS autor,e.nombre AS editorial,c.nombre AS categoria
FROM libros l
JOIN autores a ON a.id_autor=l.id_autor
JOIN editoriales e ON e.id_editorial=l.id_editorial
JOIN categorias c ON c.id_categoria=l.id_categoria;

CREATE OR REPLACE VIEW vista_usuarios_prestamos AS
SELECT u.id_usuario,CONCAT(u.nombres,' ',u.apellidos) AS usuario,
       u.documento,p.id_prestamo,p.fecha_prestamo,p.fecha_devolucion,p.estado
FROM usuarios u JOIN prestamos p ON p.id_usuario=u.id_usuario;

CREATE OR REPLACE VIEW cons_usuarios AS SELECT * FROM usuarios;
CREATE OR REPLACE VIEW cons_autores AS SELECT * FROM autores;
CREATE OR REPLACE VIEW cons_libros AS SELECT * FROM libros;
CREATE OR REPLACE VIEW cons_libro_autor AS
SELECT l.id_libro,l.titulo,l.isbn,l.anio_publicacion,a.nombre AS autor
FROM libros l INNER JOIN autores a ON a.id_autor=l.id_autor;
CREATE OR REPLACE VIEW cons_catalogo AS SELECT * FROM vista_libros;
CREATE OR REPLACE VIEW cons_usuarios_prestamos AS SELECT * FROM vista_usuarios_prestamos;
CREATE OR REPLACE VIEW cons_libros_2020 AS SELECT * FROM vista_libros WHERE anio_publicacion > 2020;
CREATE OR REPLACE VIEW cons_categoria AS
SELECT c.id_categoria,c.nombre,COUNT(l.id_libro) AS total_libros
FROM categorias c LEFT JOIN libros l ON l.id_categoria=c.id_categoria
GROUP BY c.id_categoria,c.nombre;
CREATE OR REPLACE VIEW cons_top_libros AS
SELECT l.id_libro,l.titulo,SUM(dp.cantidad) AS veces_prestado
FROM libros l JOIN detalle_prestamo dp ON dp.id_libro=l.id_libro
GROUP BY l.id_libro,l.titulo ORDER BY veces_prestado DESC LIMIT 10;

-- Este archivo NO inserta datos de demostración. La aplicación debe mostrar
-- exactamente los registros que ya existan en la base de datos.
