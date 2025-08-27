-- Diseñar una base de datos para una tienda en línea. Crear la base de datos y la tabla para el catálogo de productos.
CREATE DATABASE IF NOT EXISTS tienda_online;

USE tienda_online;

CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);

-- Insertar al menos 5 productos de prueba en la tabla de productos.
INSERT INTO productos (nombre, descripcion, precio, stock) VALUES
('Camiseta', 'Camiseta de algodón', 190.99, 50),
('Pantalones', 'Pantalones vaqueros', 490.99, 30),
('Zapatillas', 'Zapatillas deportivas', 890.99, 20),
('Chaqueta', 'Chaqueta impermeable', 79.99, 15),
('Gorra', 'Gorra de béisbol', 14.99, 100);

-- Seleccionar todos los productos con un precio mayor a 100.
SELECT * FROM productos WHERE precio > 100;

-- Actualizar el stock de un producto específico despues de una venta.
UPDATE productos SET stock = stock - 1 WHERE nombre = 'Camiseta';

-- Eliminar un producto que ya no está disponible.
DELETE FROM productos WHERE nombre = 'Gorra';

-- Seleccionar los 3 productos más baratos de la tienda.
SELECT * FROM productos ORDER BY precio ASC LIMIT 3;