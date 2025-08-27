-- Crear una estructura para un blog simple, que relaciona a los autores con sus articulos. Esto introduce el concepto de relaciones entre tablas.
CREATE DATABASE IF NOT EXISTS blog_simple;

USE blog_simple;

-- Crear las tablas autores y articulos, con una relación de clave foránea entre ellas.
CREATE TABLE IF NOT EXISTS autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    biografia TEXT,
    fecha_registro DATETIME
);
CREATE TABLE IF NOT EXISTS articulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion DATETIME,
    autor_id INT,
    FOREIGN KEY (autor_id) REFERENCES autores(id) ON DELETE CASCADE
);

-- Insertar datos.
INSERT INTO autores (nombre, email, biografia, fecha_registro) VALUES
('Ana Gomez', 'ana@gomez.com', 'Escritora y bloguera.', NOW()),
('Luis Martinez', 'luis@martinez.com', 'Apasionado por la tecnología.', NOW());
INSERT INTO articulos (titulo, contenido, fecha_publicacion, autor_id) VALUES
('Primer artículo de Ana', 'Contenido del primer artículo de Ana.', NOW(), 1),
('Tecnología en 2024', 'Contenido sobre tecnología en 2024.', NOW(), 2),
('Segundo artículo de Ana', 'Contenido del segundo artículo de Ana.', NOW(), 1);

-- Consultar el titulo de cada articulo junto con el nombre de su autor.
SELECT art.titulo AS 'nombre del articulo', au.nombre AS autor
FROM articulos art
JOIN autores au ON art.autor_id = au.id;
