###################################################################################################
#	Primer paso: Creamos la base de datos del proyecto final

CREATE DATABASE proyecto_final_comercio;

###################################################################################################
-- Segundo paso: La ponemos en uso

USE proyecto_final_comercio;

###################################################################################################
-- Tercer paso: Comenzamos con la creación de las tablas detallas en el modelo de entidad relación

CREATE TABLE provincias(
	id_provincia INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_provincia)
);

CREATE TABLE vendedores (
	id_vendedor INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(13) NOT NULL,
    PRIMARY KEY (id_vendedor)
);

CREATE TABLE categorias_clientes (
	id_categoria_cliente INT NOT NULL AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_categoria_cliente)
);

CREATE TABLE clientes (
	id_cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    domicilio VARCHAR(50) NOT NULL,
    provincia INT NOT NULL,
    telefono VARCHAR(13) NOT NULL,
    categoria_cliente INT NOT NULL,
    vendedor_asignado INT NOT NULL,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (provincia) REFERENCES provincias(id_provincia),
    FOREIGN KEY (categoria_cliente) REFERENCES categorias_clientes(id_categoria_cliente),
    FOREIGN KEY (vendedor_asignado) REFERENCES vendedores(id_vendedor)
);

CREATE TABLE proveedores(
	id_proveedor INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    domicilio VARCHAR(50) NOT NULL,
    provincia INT NOT NULL,
    PRIMARY KEY (id_proveedor),
    FOREIGN KEY (provincia) REFERENCES provincias(id_provincia)
);

CREATE TABLE productos(
	id_producto INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    proveedor INT NOT NULL,
    precio NUMERIC(9,2) NOT NULL,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (proveedor) REFERENCES proveedores(id_proveedor)
    );

CREATE TABLE pedidos(
	id_pedido INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE stock(
	id_producto INT NOT NULL,
    unidades_disponibles INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE formas_de_pago(
	id_forma_de_pago INT NOT NULL AUTO_INCREMENT,
    descripcion VARCHAR(30),
    PRIMARY KEY (id_forma_de_pago)
);

CREATE TABLE facturas(
	fecha_factura DATE NOT NULL,
	id_factura INT NOT NULL AUTO_INCREMENT,
    id_pedido INT NOT NULL, 
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario NUMERIC(9,2) NOT NULL,
    precio_total_sin_iva NUMERIC(65,2) NOT NULL,
    precio_final NUMERIC(65,2) NOT NULL,
    forma_de_pago INT NOT NULL,
    PRIMARY KEY (id_factura),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (forma_de_pago) REFERENCES formas_de_pago(id_forma_de_pago)
);

CREATE TABLE compras(
	id_compra INT NOT NULL AUTO_INCREMENT,
    proveedor INT NOT NULL,
    producto INT NOT NULL,
    cantidad INT NOT NULL,
    costo_unitario NUMERIC(65,2) NOT NULL,
    costo_total_sin_iva NUMERIC(65,2) NOT NULL,
    costo_final NUMERIC (65,2) NOT NULL,
    PRIMARY KEY (id_compra),
    FOREIGN KEY(proveedor) REFERENCES proveedores(id_proveedor),
    FOREIGN KEY(producto) REFERENCES productos(id_producto)
);

###################################################################################################
# Inserción de datos iniciales por script en las distintas tablas

INSERT INTO provincias (nombre)
VALUES
	("Buenos Aires"),
	("Catamarca"),
	("Chaco"),
	("Chubut"),
	("Córdoba"),
	("Corrientes"),
	("Entre Ríos"),
	("Formosa"),
	("Jujuy"),
	("La Pampa"),
	("La Rioja"),
	("Mendoza"),
	("Misiones"),
	("Neuquén"),
	("Río Negro"),
	("Salta"),
	("San Juan"),
	("San Luis"),
	("Santa Cruz"),
	("Santa Fe"),
	("Santiago del Estero"),
	("Tierra del Fuego"),
	("Tucumán")
;

INSERT INTO vendedores (nombre, apellido, telefono)
VALUES
	("Angelina", "Saudita", 123456780),
    ("Brian", "Rumanos", 123456781),
    ("Carlos", "Madera", 123456782),
    ("Daniel", "Escandinava", 123456783),
    ("Esteban", "Calabresa", 123456784)
;
    
INSERT INTO categorias_clientes (descripcion)
VALUES
	("Pequeñas Empresas"),
    ("Cuenta Propistas"),
    ("Grandes Empresas")
;

INSERT INTO clientes (nombre, apellido, domicilio, provincia, telefono, categoria_cliente, vendedor_asignado)
VALUES
	("Armenio", "Gimenez", "Reconquista 282", 1, 9876543210, 1, 1),
    ("Bolacio", "Giraudo", "Alvear 1982", 2, 9876543211, 2, 2),
    ("Pablo", "Ferrara", "Arredondo 2284", 1, 9876543212, 3, 3),
    ("Maxi", "Doce", "Italia 1027", 3, 9876543213, 1, 4),
    ("Gustavo", "Rodriguez", "Sarmiento 1581", 3, 9876543214, 2, 5)
;

INSERT INTO proveedores (nombre, telefono, domicilio, provincia)
VALUES
	("Jorgito",54911123456,"Espronceda 123",1),
    ("Guaymallen",54911987654,"Montes de Oca 321",2),
    ("Havanna",54911654321,"Pompeya 282",3),
    ("Milka",54911958585,"Arias 192",4),
    ("Cofler",54911215475,"Avellaneda 5968",5)
;

INSERT INTO productos (nombre, marca, descripcion, proveedor, precio)
VALUES
	("Alfajor x 30 gramos", "Jorgito", "Alfajor doble de 30 gramos", 1, 30.15),
    ("Alfajor Triple x 60 gramos", "Guaymallen", "Alfajor triple de 60 gramos", 2, 50.35),
    ("Copos de dulce de leche x 60 gramos", "Havanna", "Copos de dulce de leche bañados en chocolate", 3, 10.00),
    ("Alfajor con Mousse x 50 gramos", "Milka", "Alfajor relleno de mouse de chocolate", 4, 23.78),
    ("Alfajor Blend de Chocolates x 50 gramos", "Cofler", "Alfajor con relleno de distintos chocolates de 50 gramos", 5, 98.13)
;

INSERT INTO stock(id_producto, unidades_disponibles)
VALUES
	(1, 100),
    (2, 200),
    (3, 300),
    (4, 400),
    (5, 500)
;

INSERT INTO formas_de_pago (descripcion)
VALUES
	("Efectivo"),
	("Transferencia"),
	("Mercado Pago"),
	("Cheque"),
	("Débito Automático")
;

INSERT INTO pedidos (id_cliente, id_producto, cantidad)
VALUES
	(1,1,10),
    (2,2,20),
    (3,3,30),
    (1,5,60),
    (2,4,70),
    (3,3,80)
  
;

INSERT INTO facturas (fecha_factura,id_pedido, id_cliente, id_producto, cantidad, precio_unitario, precio_total_sin_iva, precio_final, forma_de_pago)
VALUES
	("2022-01-01",1,1,1,10,10,10,10,1),
    ("2022-02-01",2,2,2,20,20,20,20,2),
    ("2022-03-01",3,3,3,30,30,30,30,3),
    ("2022-04-01",4,1,4,40,40,40,40,4),
    ("2022-05-01",5,2,5,50,50,50,50,5)
;

INSERT INTO compras (proveedor, producto, cantidad, costo_unitario, costo_total_sin_iva, costo_final)
VALUES
	(1,1,10,10,10,10),
    (2,2,20,20,20,20),
    (3,3,30,30,30,30),
    (4,4,40,40,40,40),
    (5,5,50,50,50,50)
;


###################################################################################################
# STORED PROCEDURES

#1° El primer S.P. debe permitir indicar a través de un parámetro el campo de ordenamiento de una tabla y
# mediante un segundo parámetro, si el orden es descendente o ascendente.

SELECT * FROM facturas;

DELIMITER //

CREATE PROCEDURE `sp_orden_facturas`(IN campo VARCHAR(50), IN orden VARCHAR(4))
BEGIN
	
    SET @campo_elegido = campo;
    
    SET @orden_elegido = orden;
	
    SET @consulta = CONCAT('SELECT * FROM proyecto_final_comercio.facturas ORDER BY ',@campo_elegido,' ',@orden_elegido);
    
	PREPARE mi_select FROM @consulta;
    EXECUTE mi_select;
    DEALLOCATE PREPARE mi_select;

END//

DELIMITER ;

CALL sp_orden_facturas("cantidad","desc");

#2° El otro S.P. qué crearás puede:
#A: insertar registros en una tabla de tu proyecto.
#B: eliminar algún registro específico de una tabla de tu proyecto.
#Este stored procedure servirá para depurar la tabla de clientes, eliminando de la misma todos los datos de clientes que no tuvieran
#facturación emitida al momento de la depuración.

SELECT * FROM clientes; #Hay 5 clientes
SELECT * FROM facturas; #Solo los ID 1, 2 y 3 tienen facturas emitidas. Luego de ejecutar el SP deberían quedar solo 3 clientes.

DELIMITER //

CREATE PROCEDURE `sp_depura_clientes`()
BEGIN
	
	DELETE FROM proyecto_final_comercio.clientes
    WHERE clientes.id_cliente NOT IN (SELECT DISTINCT id_cliente FROM proyecto_final_comercio.facturas);
        
END//

DELIMITER ;

CALL sp_depura_clientes;

SELECT * FROM clientes; #Luego de ejecutar el SP se valida que solo quedan los 3 clientes que tienen pedidos en la tabla "Clientes"
###################################################################################################
