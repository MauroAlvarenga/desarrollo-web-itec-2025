/* 
Actividad Práctica: Diseño de la Base de Datos para una Red Social
Objetivo General: Diseñar y crear una base de datos relacional para una red social simplificada, usando
SQL.

Contexto del proyecto: Imaginemos que estamos desarrollando el backend de una red social llamada
"ConectaTaller". La aplicación debe permitir a los usuarios:
- Registrarse y crear un perfil.
- Publicar mensajes (posts).
- Seguir a otros usuarios.
- Dar "me gusta" a las publicaciones.

Necesitamos al menos tres tablas para esta funcionalidad básica:
- usuarios: Para almacenar la información de los perfiles.
- posts: Para guardar las publicaciones de los usuarios.
- relaciones: Para gestionar quién sigue a quién.
*/

-- 1. Crear la base de datos: Conectarse a su servidor MySQL (XAMPP/WAMP) y crear una nueva base de datos llamada conectataller.
CREATE DATABASE IF NOT EXISTS conectataller;
USE conectataller;

-- 2. Crear la tabla usuarios: Esta tabla almacenará la información de cada perfil. Debe tener las siguientes columnas:
/* 
2.1. id: Identificador único (número entero, clave primaria, auto-incrementable).
2.2. nombre_usuario: Nombre de usuario (texto, no nulo, único).
2.3. email: Correo electrónico (texto, no nulo, único).
2.4. contrasena: Contraseña (texto, no nulo).
2.5. fecha_registro: Fecha en la que el usuario se registró (fecha y hora).
*/

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Insertar datos de prueba: Agreguen al menos tres usuarios de ejemplo.
INSERT INTO usuarios (nombre_usuario, email, contrasena) VALUES
('usuario1', 'u1@mail.com', 'pass1'),
('usuario2', 'u2@mail.com', 'pass2'),
('usuario3', 'u3@mail.com', 'pass3');

-- 4. Crear la tabla posts: Esta tabla almacenará las publicaciones de los usuarios. Debe tener las siguientes columnas:
/*
4.1. id: Identificador único del post (número entero, clave primaria, auto-incrementable).
4.2. autor_id: Identificador del usuario que hizo el post (número entero, no nulo). Este es un
Foreign Key que se relaciona con el id de la tabla usuarios.
4.3. contenido: El texto del post (texto, no nulo).
4.4. fecha_publicacion: Fecha y hora del post (fecha y hora).
*/
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    autor_id INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (autor_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- 5. Insertar posts de prueba: Agreguen publicaciones para los usuarios que crearon.
INSERT INTO posts (autor_id, contenido) VALUES
(1, '¡Hola a todos! Este es mi primer post en ConectaTaller.'),
(2, 'Hoy aprendí a crear bases de datos con SQL. ¡Muy interesante!'),
(1, 'Qué opinan del diseño web?');

-- 6. Creación de la tabla de relaciones (seguidores)
-- 7. Crear la tabla relaciones: Esta tabla gestionará quién sigue a quién. La relación es "muchos a muchos": un usuario puede seguir a muchos y ser seguido por muchos.
/* Debe tener las siguientes columnas:
- seguidor_id: ID del usuario que sigue a otro. Foreign Key a usuarios(id).
- seguido_id: ID del usuario que es seguido. Foreign Key a usuarios(id).
- Ambos campos juntos deben formar la clave primaria compuesta para evitar
duplicados.
*/
CREATE TABLE IF NOT EXISTS relaciones (
    seguidor_id INT NOT NULL,
    seguido_id INT NOT NULL,
    PRIMARY KEY (seguidor_id, seguido_id),
    FOREIGN KEY (seguidor_id) REFERENCES usuarios(id),
    FOREIGN KEY (seguido_id) REFERENCES usuarios(id)
);

-- 8. Insertar relaciones de prueba:
-- El usuario con id=1 (usuario1) sigue al usuario con id=2 (usuario2)
INSERT INTO relaciones (seguidor_id, seguido_id) VALUES (1, 2);
-- El usuario con id=3 (usuario3) sigue al usuario con id=1 (usuario1)
INSERT INTO relaciones (seguidor_id, seguido_id) VALUES (3, 1);
-- El usuario con id=2 (usuario2) sigue al usuario con id=3 (usuario3)
INSERT INTO relaciones (seguidor_id, seguido_id) VALUES (2, 3);

-- 9. Consultas de prueba (simulando el uso en PHP)

-- 9.1 Obtener la información de un usuario específico:
SELECT * FROM usuarios WHERE nombre_usuario = 'usuario1';

-- 9.2 Obtener todos los posts de un usuario específico:
SELECT * FROM posts WHERE autor_id = 1 ORDER BY fecha_publicacion DESC;

-- 9.3 Obtener el "feed" de un usuario: Esto requiere una consulta más avanzada, uniendo las tablas posts y relaciones para mostrar los posts de las personas que el usuario sigue.
SELECT 
  p.contenido, 
  p.fecha_publicacion, 
  u.nombre_usuario AS autor_del_post
FROM posts p
INNER JOIN relaciones r ON p.autor_id = r.seguido_id
INNER JOIN usuarios u ON p.autor_id = u.id
WHERE r.seguidor_id = 1
ORDER BY p.fecha_publicacion DESC;

-- 9.4 Contar los seguidores de un usuario:
SELECT COUNT(*) AS total_seguidores
FROM relaciones
WHERE seguido_id = 1;
