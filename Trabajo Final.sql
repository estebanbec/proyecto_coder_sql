DROP SCHEMA proyecto_final_comercio;

###################################################################################################
#	Primer paso: Creamos la base de datos del proyecto final

CREATE DATABASE IF NOT EXISTS proyecto_final_comercio;

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
    descripcion VARCHAR(30) NOT NULL,
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
    ("2022-05-01",4,1,4,40,40,40,40,4),
    ("2022-05-01",5,2,5,50,50,50,50,5),
    ("2022-06-01",5,2,5,50,50,50,50,5),
    ("2022-06-01",5,2,5,50,50,50,50,5)
;

INSERT INTO compras (proveedor, producto, cantidad, costo_unitario, costo_total_sin_iva, costo_final)
VALUES
	(1,1,10,10,10,10),
    (2,2,20,20,20,20),
    (3,3,30,30,30,30),
    (4,4,40,40,40,40),
    (4,4,40,40,40,40),
    (5,5,50,50,50,50),
    (5,5,50,50,50,50),
    (5,5,50,50,50,50)
;


###################################################################################################
# Vistas

# 1° Vista: Nos permitirá conocer la cantidad de clientes que se encuentran distribuidos en cada una de las provincias
# sin brindar información adicional de ellos a quienes hagan uso de esta información
# con fines estadísticos y, por ejemplo, identificar en que provincias hay poca presencia, o nula,
# a fin de realizar alguna gestión de Marketing que promueva el desarrollo de la entidad en esas área geográficas

CREATE OR REPLACE VIEW demografiaclientes_view AS
	SELECT DISTINCT provincia, count(*) as cantidad
	FROM clientes
	GROUP BY provincia
	ORDER BY cantidad DESC;

SELECT * FROM demografiaclientes_view;

# 2° Vista
# Permitirá conocer al equipo de Marketing los primeros 3 clientes con mayor suma facturada sin dar a conocer el detalle de los productos comprados
# con el fin de poder premiarlos anualmente según la cantidad de compras que hayan realizado

CREATE OR REPLACE VIEW top3clientes_view AS
SELECT clientes.id_cliente, clientes.nombre, clientes.apellido, SUM(facturas.precio_final) as total_facturado
FROM clientes
INNER JOIN facturas ON facturas.id_cliente = clientes.id_cliente
GROUP BY clientes.id_cliente
ORDER BY total_facturado DESC;
    
SELECT * FROM top3clientes_view;

# 3° Vista
# Permitirá conocer los 3 productos menos vendidos a los clientes, a fin de entender sobre que productos
# habría que ejecutar acciones para impulsar sus ventas

CREATE OR REPLACE VIEW menosvendidos_view AS
	SELECT facturas.id_producto, productos.nombre, SUM(facturas.cantidad) as total_cantidad
    FROM facturas
    INNER JOIN productos ON productos.id_producto = facturas.id_producto
    GROUP BY facturas.id_producto
    ORDER BY total_cantidad ASC
    LIMIT 3;
	
SELECT * FROM menosvendidos_view;

# 4° Vista
# Nos permitirá conocer cuales son los 3 proveedores a los cuales se le realizan más compras, cantidades y el importe operado
# a fin de poder usar esa información como respaldo para solicitar condiciones comerciales más convenientes

CREATE OR REPLACE VIEW mayoresproveedores_view AS
SELECT DISTINCT proveedor, count(proveedor) as compras, sum(cantidad) as volumen, sum(costo_final) as costo_total
FROM compras
GROUP BY proveedor
ORDER BY compras DESC
LIMIT 3;

SELECT * FROM mayoresproveedores_view;



# 5° Vista
# Permitirá conocer a los clientes que eligen como modalidad de pago el cheque, a fin de identificarlos y poder
# proporcionarles alguna condición que provoque su cambio en la modalidad de pago visto que los cheques recibidos son diferidos y
# se intentará poder contar con el dinero con un plazo menor.

CREATE OR REPLACE VIEW clientesconcheques_view AS
	SELECT facturas.id_cliente, clientes.nombre, clientes.apellido, facturas.forma_de_pago
	FROM facturas
	INNER JOIN clientes ON facturas.id_cliente = clientes.id_cliente
    WHERE facturas.forma_de_pago = (SELECT id_forma_de_pago FROM formas_de_pago WHERE descripcion = "Cheque")
    GROUP BY id_cliente
;

SELECT * FROM clientesconcheques_view;


###################################################################################################
# Funciones

#Primera Función: Teniendo en cuenta que puede darse en este tipo de organizaciones que por momentos existan
#saldos ociosos que pudieran invertirse en distintos instrumentos como ser plazos fijos
#esta función le permitirá al usuario conocer rapidamente cuáles serán los intereses mensuales
#que percibirá por invertir el monto ingresado a la tasa ingresada.

DELIMITER $$
CREATE FUNCTION `calculo_intereses`(tasa INT, capital INT) RETURNS double
    DETERMINISTIC
BEGIN
	DECLARE nuevos_intereses DOUBLE;
    SET nuevos_intereses = (capital * (tasa / 12 / 100));
RETURN nuevos_intereses;
END$$
DELIMITER ;

#Por ejemplo, si la tasa nominal anual (TNA) es de 75%, y la organización invierte $100.000, recibirá al cabo de un mes
#una compensación por la suma de $6.250

SELECT calculo_intereses (75,100000) AS total_intereses;

#Función 2: Capital necesario a partir de intereses esperado, nos permitirá conocer cuál es la suma
# de capital que debería inverstirse que al aplicar determinada tasa, pueda arribarse
# a los intereses esperados, también ingresados como parámetro.
#Esta función también colabora en la administración de fondos ociosos

DELIMITER $$
CREATE FUNCTION `calculo_capital_necesario`(tasa INT, intereses DOUBLE) RETURNS double
    DETERMINISTIC
BEGIN
	DECLARE capital_esperado DOUBLE;
    SET capital_esperado = (intereses / (tasa / 12 /100) );
	RETURN capital_esperado;
END$$
DELIMITER ;

SELECT calculo_capital_necesario (90, 100000) as Capital_Necesario;

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
	
    SET @consulta = CONCAT(
							'SELECT * FROM proyecto_final_comercio.facturas ORDER BY ',
                            @campo_elegido,
                            ' ',
                            @orden_elegido
							);
    
	PREPARE mi_select FROM @consulta;
    EXECUTE mi_select;
    DEALLOCATE PREPARE mi_select;

END//

DELIMITER ;

CALL sp_orden_facturas("cantidad","desc");


#2° El otro S.P. qué crearás puede:
#A: insertar registros en una tabla de tu proyecto.
#B: eliminar algún registro específico de una tabla de tu proyecto.
#Este Stored Procedure permitirá el alta de nuevos vendedores, ingresando la información de cada uno de los campos de dicha tabla

SELECT * FROM vendedores; #Verificamos que hay 5 vendedores

DELIMITER //

CREATE PROCEDURE `sp_alta_vendedor`(IN nom VARCHAR(50),IN surname VARCHAR(50),IN phone VARCHAR(13))
BEGIN

	SET @inputnombre = nom;
    SET @inputapellido = surname;
    SET @inputtelefono = phone;
	INSERT INTO proyecto_final_comercio.vendedores(nombre, apellido, telefono) VALUES (@inputnombre, @inputapellido, @inputtelefono);
	        
END//

DELIMITER ;

SELECT * FROM vendedores where id_vendedor = 6; #Verificamos que hay 5 vendedores

CALL sp_alta_vendedor('jorge','remanso','1123458789');

SELECT * FROM vendedores; #Luego de ejecutar el SP verificamos que hay 65 vendedores


###################################################################################################
###### TRIGGERS #####
###################################################################################################

###### TRIGGERS SOBRE TABLA PRODUCTOS #####


#Primer Trigger para tabla productos - AFTER UPDATE
#Teniendo en cuenta el contexto inflacionario, es muy habitual que los precios de los productos se actualicen constantemente
#Es por ello que esta tabla de log nos permitirá conocer la variacion de precios, el usuario que la actualizó, y la fecha en que lo hizo

#Paso 1 - Creamos la primera tabla log, dónde ante cualquier modificacion de precio que se realice sobre la tabla de productos, quedará 
#resguardada la información histórica de sus movimientos

CREATE TABLE log_modificacion_productos (
	id_producto INT NOT NULL, #ID del producto para identificarlo
    precio_old NUMERIC(9,2) NOT NULL, #Precio asignado previo a la actualización del mismo
    precio_new NUMERIC(9,2) NOT NULL, #Precio nuevo asignado al momento de la actualización
    usuario VARCHAR(50), #Usuario que cursó la actualización
    fecha DATE #Fecha en que se cursó la actualización.
);


#Paso 2 - A modo de validación, ejecutamos un SELECT sobre la nueva tabla creada para corroborar que previo a realizar cualquier
#actualización, la misma se encuentra vacía y solo se actualizará por el trigger diseñado.

SELECT * FROM log_modificacion_productos;

#Paso 3 - Creación del trigger
#El mismo, ante cualquier actualización de precios, dejará asentado el historial que permitirá además visualizar rapidamente
#el precio previo a la actualización (precio_old), y el nuevo valor asignado (precio_new)

DELIMITER $$

CREATE TRIGGER `tr_modificacion_productos`
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
	INSERT INTO log_modificacion_productos (id_producto, precio_old, precio_new, usuario, fecha)
	VALUES (OLD.id_producto, OLD.precio, NEW.precio, USER(),current_date());
END $$

DELIMITER ;

#Paso 4 - Para validar el funcionamiento del trigger, modificaremos el precio del producto con id = 1
#Para ello verificaremos primero que valor tiene asignado al momento de crear la tabla

SELECT * FROM productos WHERE id_producto = 1;

#Se verifica que al momento de la inserción original, el precio era de $30.15

#Paso 5 - Vamos a forzar la actualización del precio con distintos valores para llenar la bitácora con algunos movimientos
#y validar el correcto funcionamiento de la misma

UPDATE productos SET precio = 1 WHERE id_producto = 1;

UPDATE productos SET precio = 999 WHERE id_producto = 1;

UPDATE productos SET precio = 333.45 WHERE id_producto = 1;

#Paso 6 - Validamos que el precio del producto haya quedado asignado según el último update cursado ($333.45)
SELECT * FROM productos WHERE id_producto = 1;

#Paso 7 - Consultamos la bitácora para validar que hayan sido registrados todos los updates cursados sobre los precios
SELECT * FROM log_modificacion_productos;

#Segundo Trigger para tabla productos - BEFORE UPDATE
#Este trigger nos permitirá identificar cuáles fueron los productos creados en la base de datos de manera posterior a la inserción original
#De manera que podremos saber así que productos fueron incorporándose a medida que pasa el tiempo, y el usuario que lo incorporó.

#Paso 1 - Creamos la primera tabla log, dónde ante cualquier inserción de nuevos productos se dejará el log

CREATE TABLE log_alta_productos (
	id_producto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    proveedor INT NOT NULL,
    precio NUMERIC(9,2) NOT NULL,
    usuario VARCHAR(50), #Usuario que cursó la actualización
    fecha DATE #Fecha en que se cursó la actualización.
);

#Paso 2 - A modo de validación, ejecutamos un SELECT sobre la nueva tabla creada para corroborar que previo a realizar cualquier
#actualización, la misma se encuentra vacía y solo se actualizará por el trigger diseñado.

SELECT * FROM log_alta_productos;

#Paso 3 - Creación del trigger
#El mismo, ante cualquier inserción de nuevos productos dejará asentado el movimiento en la bitácora, adicionando el usuario y su fecha de creación

DELIMITER $$

CREATE TRIGGER `tr_alta_productos`
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
	INSERT INTO log_alta_productos (id_producto, nombre, marca, descripcion, proveedor, precio, usuario, fecha)
	VALUES (NEW.id_producto, NEW.nombre, NEW.marca, NEW.descripcion, NEW.proveedor, NEW.precio, USER(),current_date());
END $$

DELIMITER ;

#Paso 4 - Para validar el funcionamiento del trigger, insertaremos dos productos nuevos
#Para ello verificaremos primero que la tabla log sigue vacía

SELECT * FROM log_alta_productos;

SELECT * FROM productos;

#Se verifica que el log está vacío, y en la inserción original se dieron de alta 5 productos

#Paso 5 - Vamos a incorporar dos nuevos productospara llenar la bitácora con algunos movimientos

INSERT INTO productos (nombre, marca, descripcion, proveedor, precio)
VALUES
	("Valida Trigger 1", "Prueba 1", "Es la primera insercion para validar este trigger", 3, "39.85"),
    ("Valida Trigger 2", "Prueba 2", "Es la segunda insercion para validar este trigger", 2, "99.99")
;

#Paso 6 - Validamos que la inserción haya sido cursada correctamente

SELECT * FROM productos WHERE nombre LIKE "Valida%";

#Se observa que fueron creados los dos productos, asignando por auto incremental los id 6 y 7

#Paso 7 - Consultamos la bitácora para validar que hayan sido registradas estas altas
SELECT * FROM log_alta_productos;

###### TRIGGERS SOBRE TABLA CLIENTES #####

#Primer Trigger: Log de alta de nuevos clientes
#Nos permitirá tener rastro de cuáles son los clientes que fueron incorporándose a la BD
#de manera posterior a la inserción original, y el usuario/fecha de su creación

#Paso 1: Creamos la tabla bitácora, que ademas de tener los datos del cliente, nos permite conocer usuario que lo creó y su fecha de alta

CREATE TABLE log_alta_clientes(
	id_cliente INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    domicilio VARCHAR(50) NOT NULL,
    provincia INT NOT NULL,
    telefono VARCHAR(13) NOT NULL,
    categoria_cliente INT NOT NULL,
    vendedor_asignado INT NOT NULL,
    usuario VARCHAR(50),
    fecha_alta DATE
);

#Paso 2 - A modo de validación, ejecutamos un SELECT sobre la nueva tabla creada para corroborar que previo a realizar cualquier
#actualización, la misma se encuentra vacía y solo se actualizará por el trigger diseñado.

SELECT * FROM log_alta_clientes;

#Paso 3 - Creación del trigger
#El mismo, ante cualquier inserción de nuevos clientes dejará asentado el movimiento en la bitácora, adicionando el usuario y su fecha de creación

DELIMITER $$

CREATE TRIGGER `tr_alta_clientes`
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
	INSERT INTO log_alta_clientes (id_cliente, nombre, apellido, domicilio, provincia, telefono, categoria_cliente, vendedor_asignado, usuario, fecha_alta)
	VALUES (NEW.id_cliente, NEW.nombre, NEW.apellido, NEW.domicilio, NEW.provincia, NEW.telefono, NEW.categoria_cliente, NEW.vendedor_asignado, USER(),current_date());
END $$

DELIMITER ;

#Paso 4 - Para validar el funcionamiento del trigger, insertaremos dos clientes nuevos
#Para ello verificaremos primero que la tabla log sigue vacía

SELECT * FROM log_alta_clientes;

SELECT * FROM clientes;

#Se verifica que existen solo 3 clientes en la tabla (Esto porque en la inserción original había 5, pero en el medio se llamó al SP
#que depura clientes sin actividad).

#Paso 5 - Vamos a incorporar dos nuevos clientes para llenar la bitácora con algunos movimientos

INSERT INTO clientes (nombre, apellido, domicilio, provincia, telefono, categoria_cliente, vendedor_asignado)
VALUES
	("Prueba 1", "Trigger 1", "Benavidez 123", 1, 0303456, 3, 2),
    ("Prueba 2", "Trigger 2", "Alcorta 456", 3, 99115487, 3, 2)
;

#Paso 6 - Validamos que la inserción haya sido cursada correctamente

SELECT * FROM clientes WHERE nombre LIKE "Prueba%";

#Se observa que fueron creados los dos clientes, asignando por auto incremental los id 8 y 9 (Recordar que previamente se ejecutó el SP de depuración por eso no sigue consecutivo)

#Paso 7 - Consultamos la bitácora para validar que hayan sido registradas estas altas
SELECT * FROM log_alta_clientes;

#Segundo Trigger: Log de cambio de vendedor asignado
#Nos permitirá conocer el registro de los cambios de vendedores asignados a cada cliente
#Por ejemplo, si un cliente pide que se le cambie el vendedor asignado porque tal vez considera que no está
#siendo atendido como corresponde, puede pedir su reemplazo

#Paso 1 - Creamos la nueva tabla bitácora

CREATE TABLE log_cambios_vendedores(
	id_cliente INT NOT NULL,
    vendedor_anterior INT NOT NULL,
    vendedor_nuevo INT NOT NULL,
    usuario_modifico VARCHAR(50),
    fecha_modifico DATE
);

#Paso 2 - Validamos que haya sido creada correctamente y este vacía

SELECT * FROM log_cambios_vendedores;

#Paso 3 - Creación del trigger
#El mismo, ante cualquier modificación de vendedor asignado dejará asentado el movimiento en la bitácora, adicionando el usuario y su fecha de intervención

DELIMITER $$

CREATE TRIGGER `tr_modifica_vendedor`
BEFORE UPDATE ON clientes
FOR EACH ROW
BEGIN
	INSERT INTO log_cambios_vendedores (id_cliente, vendedor_anterior, vendedor_nuevo, usuario_modifico, fecha_modifico)
	VALUES (NEW.id_cliente, OLD.vendedor_asignado, NEW.vendedor_asignado, USER(),current_date());
END $$

DELIMITER ;

#Paso 4 - Para validar el funcionamiento del trigger, modificaremos dos vendedores asignados
#Para ello verificaremos primero que la tabla log sigue vacía

SELECT * FROM log_cambios_vendedores;

SELECT * FROM clientes;

#Se verifica que, por ejemplo, los clientes 2,6 y 7 tienen asignado el vendedor 2, el cual no viene teniendo buen desempeño y es por ello que la compañia decide
#darle una oportunidad al vendedor 5, que tiene solo 1 cliente asignado
#Para ello ejecutamos el update correspondiente

UPDATE clientes
SET vendedor_asignado = 5
WHERE vendedor_asignado = 2;

#Producto de ello, la bitácora debería incorporar estas 3 modificaciones

#Paso 5 - Validamos primero que la actualización haya sido cursada correctamente (los clientes 2, 5, 6 y 7 deberían tener asignado el vendedor 5)
#Los clientes 2 6 y 7 por el update, y el cliente 5 ya tenía asignado a dicho vendedor.

SELECT * FROM clientes WHERE vendedor_asignado = 5;

#Se observa que fue correctamente modificado el vendedor para estos 3 casos.

#Paso 7 - Consultamos la bitácora para validar que hayan sido registradas estas altas
SELECT * FROM log_cambios_vendedores;

#Se observa que se detalla para cada id_cliente involucrado, cuál era el vendedor asignado previamente, cuál es el nuevo, la fecha
# y usuario que ejecutó la modificación