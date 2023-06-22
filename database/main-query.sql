CREATE DATABASE ClayTrack;
GO;
USE ClayTrack;
GO;
CREATE TABLE unidad_medida (
  id_unidad_medida INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descripcion VARCHAR(255) NOT NULL,
  estatus BOOLEAN DEFAULT TRUE NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW()
);
CREATE TABLE materia_prima (
  id_materia_prima INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  estatus BOOLEAN DEFAULT TRUE NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW(),
  fk_unidad_medida INT NOT NULL
);
CREATE TABLE roles (
  id_rol INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  estatus BOOLEAN DEFAULT TRUE NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW()
);
CREATE TABLE usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  correo VARCHAR(255) NOT NULL,
  contrasenia VARCHAR(255) NOT NULL,
  estatus BOOLEAN DEFAULT TRUE NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW()
);
CREATE TABLE rol_usuario (
  id_rol_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fk_usuario INT NOT NULL,
  fk_rol INT NOT NULL
);
CREATE TABLE persona (
  id_persona INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  apaterno VARCHAR(255) NOT NULL,
  amaterno VARCHAR(255),
  telefono VARCHAR(255) NOT NULL,
  codigo_postal INT NOT NULL,
  numero_exterior VARCHAR(255) NOT NULL,
  numero_interior VARCHAR(255),
  calle VARCHAR(255) NOT NULL,
  colonia VARCHAR(255) NOT NULL,
  estatus BOOLEAN DEFAULT TRUE NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW()
);
CREATE TABLE cliente (
  id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fk_persona INT NOT NULL,
  fk_usuario INT NOT NULL
);
CREATE TABLE proveedor (
  id_proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  correo VARCHAR(255) NOT NULL,
  fk_persona INT NOT NULL
);
CREATE TABLE empleado (
  id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fk_persona INT NOT NULL,
  fk_usuario INT NOT NULL
);
CREATE TABLE compra (
  id_compra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  total FLOAT NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW(),
  fk_proveedor INT NOT NULL,
  fk_empleado INT NOT NULL
);
CREATE TABLE detalle_compra (
  id_detalle_compra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cantidad FLOAT NOT NULL,
  precio FLOAT NOT NULL,
  fk_almacen INT NOT NULL,
  fk_compra INT NOT NULL
);
CREATE TABLE almacen (
  id_almacen INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cantidad INT NOT NULL,
  caducidad DATETIME NOT NULL,
  estatus BOOLEAN DEFAULT TRUE NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW(),
  fk_materia_prima INT NOT NULL
);
CREATE TABLE receta (
  id_receta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  precio FLOAT NOT NULL,
  ruta_imagen VARCHAR(255) NOT NULL,
  estatus BOOLEAN DEFAULT TRUE NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW()
);
CREATE TABLE detalle_materia_prima_receta (
  id_detalle_materia_prima_receta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fk_receta INT NOT NULL,
  cantidad FLOAT NOT NULL,
  fk_materia_prima INT NOT NULL
);
CREATE TABLE detalle_almacen_stock (
  id_detalle_almacen_stock INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cantidad FLOAT NOT NULL,
  fk_almacen INT NOT NULL,
  fk_stock INT NOT NULL
);
CREATE TABLE stock (
  id_stock INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  caducidad VARCHAR(255) NOT NULL,
  cantidad INT NOT NULL,
  precio FLOAT NOT NULL,
  estatus BOOLEAN DEFAULT TRUE NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW(),
  fk_receta INT NOT NULL
);
CREATE TABLE venta (
  id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  total FLOAT NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW(),
  fk_cliente INT NOT NULL
);
CREATE TABLE detalle_venta (
  id_detalle_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cantidad FLOAT NOT NULL,
  precio FLOAT NOT NULL,
  fk_stock INT NOT NULL,
  fk_venta INT NOT NULL
);
CREATE TABLE envio (
  id_envio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  entregado BOOLEAN NOT NULL DEFAULT FALSE,
  fecha_creacion DATETIME NOT NULL DEFAULT NOW(),
  fecha_actualizacion DATETIME NOT NULL DEFAULT NOW(),
  fk_venta INT NOT NULL,
  fk_empleado INT
);
