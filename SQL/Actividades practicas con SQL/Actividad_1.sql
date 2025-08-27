-- Crear la base de datos taller_web
CREATE DATABASE IF NOT EXISTS taller_web;

USE taller_web;

-- Crear la tabla usuarios con columnas para el ID, nombre de usuario, contraseña y correo electrónico
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Insertar usuarios de prueba, al menos 3 usuarios
INSERT INTO usuarios (username, password, email) VALUES
('carlosruiz', 'pass1', 'usuario@test.com'),
('mariajose', 'pass2', 'maria@jose.com'),
('juanperez', 'pass3', 'juan@perez.com');

-- Seleccionar todos los usuarios
SELECT * FROM usuarios;

-- Cambiar la contraseña de un usuario específico
UPDATE usuarios SET password = 'nuevaPass123' WHERE username = 'mariajose';

-- Eliminar el usuario con el nombre 'carlosruiz'
DELETE FROM usuarios WHERE username = 'carlosruiz';