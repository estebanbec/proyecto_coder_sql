-- Primer paso: Creamos la base de datos
CREATE DATABASE proyecto_final;

-- Segundo Paso: La ponemos en uso
USE proyecto_final;

-- Tercer Paso: Comenzamos con la creación de las tablas detalladas en el diagrama de entidad relación

CREATE TABLE clientes (
	dni INT NOT NULL,
    nombre TEXT(50),
    apellido TEXT(50),
    fecha_nacimiento DATE,
    edad INT,
    domicilio_calle TEXT(30),
    domicilio_altura INT,
    domicilio_piso INT,
    domicilio_depto VARCHAR(3),
    domicilio_localidad TEXT(20),
    domicilio_provincia TEXT(19),
	PRIMARY KEY (dni)
    );
    
CREATE TABLE plazos_fijos (
	id_plazo_fijo INT NOT NULL AUTO_INCREMENT,
    dni INT NOT NULL,
    capital DOUBLE NOT NULL,
    intereses DOUBLE NOT NULL,
    tasa DOUBLE NOT NULL,
    vigencia_desde DATE NOT NULL,
    vigencia_hasta DATE NOT NULL,
    id_caja_ahorro INT NOT NULL,
	PRIMARY KEY (id_plazo_fijo)
    );

CREATE TABLE cajas_ahorro (
	id_caja_ahorro INT NOT NULL AUTO_INCREMENT,
    alias VARCHAR(20) NOT NULL,
    cbu VARCHAR(22) NOT NULL,
    dni INT NOT NULL,
    saldo DOUBLE NOT NULL,
    id_moneda INT NOT NULL,
    PRIMARY KEY (id_caja_ahorro)
    );
    
CREATE TABLE monedas (
	id_moneda INT AUTO_INCREMENT NOT NULL,
    descripcion VARCHAR(10),
    PRIMARY KEY (id_moneda)
    );
    
CREATE TABLE tarjetas_credito (
	id_tarjeta_credito INT NOT NULL AUTO_INCREMENT,
    dni INT NOT NULL,
    saldo_tc DOUBLE NOT NULL,
    cuenta_corriente INT NOT NULL,
    PRIMARY KEY (id_tarjeta_credito)
    );
    
CREATE TABLE cuentas_corrientes (
	cuenta_corriente INT NOT NULL AUTO_INCREMENT,
    alias VARCHAR(20) NOT NULL,
    cbu VARCHAR(22) NOT NULL,
    dni INT NOT NULL,
    saldo DOUBLE NOT NULL,
    id_moneda INT NOT NULL,
    PRIMARY KEY (cuenta_corriente)
    );
    
-- Cuarto Paso: Una vez creadas las tablas, definimos las relaciones entre ellas

ALTER TABLE plazos_fijos
ADD FOREIGN KEY (dni) REFERENCES clientes(dni),
ADD FOREIGN KEY (id_caja_ahorro) REFERENCES cajas_ahorro(id_caja_ahorro) ;

ALTER TABLE cajas_ahorro
ADD FOREIGN KEY (dni) REFERENCES clientes(dni),
ADD FOREIGN KEY (id_moneda) REFERENCES monedas(id_moneda) ;

ALTER TABLE tarjetas_credito
ADD FOREIGN KEY (dni) REFERENCES clientes(dni),
ADD FOREIGN KEY (cuenta_corriente) REFERENCES cuentas_corrientes(cuenta_corriente);

ALTER TABLE cuentas_corrientes
ADD FOREIGN KEY (dni) REFERENCES clientes(dni),
ADD FOREIGN KEY (id_moneda) REFERENCES monedas(id_moneda) ;
