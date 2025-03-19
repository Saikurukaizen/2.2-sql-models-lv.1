-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`direccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(4) NULL,
  `piso` VARCHAR(2) NULL,
  `puerta` VARCHAR(2) NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  `cp` VARCHAR(5) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(12) NULL,
  `fax` VARCHAR(15) NULL,
  `nif` VARCHAR(20) NOT NULL,
  `id_direccion` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `nombre` (`nombre` ASC) VISIBLE,
  INDEX `fk_proveedor_direccion1_idx` (`id_direccion` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_direccion1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `mydb`.`direccion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gafas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(50) NOT NULL,
  `graduación_lente_izq` DECIMAL NULL,
  `graduacion_lente_der` DECIMAL NULL,
  `montura` ENUM('flotante', 'pasta', 'metálica') NOT NULL,
  `color_montura` VARCHAR(45) NULL,
  `color_lente_izq` VARCHAR(45) NULL,
  `color_lente_der` VARCHAR(45) NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `id_proveedor` INT NOT NULL,
  PRIMARY KEY (`id`, `id_proveedor`),
  INDEX `fk_gafas_proveedor1_idx` (`id_proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `mydb`.`proveedor` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(12) NULL,
  `mail` VARCHAR(45) NULL,
  `fecha_registro` DATE NOT NULL,
  `recomendado_por` INT NULL,
  `id_cliente` INT NOT NULL,
  `id_direccion` INT NOT NULL,
  PRIMARY KEY (`id`, `id_cliente`),
  INDEX `idx_nombre` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_cliente_direccion1_idx` (`id_direccion` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mydb`.`cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cliente_direccion1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `mydb`.`direccion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `nif` VARCHAR(10) NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `puesto` ENUM('cocinero', 'repartidor') NOT NULL,
  `id_tienda` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  INDEX `fk_empleado_tienda1_idx` (`id_tienda` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_tienda1`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `mydb`.`tienda` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATE NOT NULL,
  `fecha_periodo_inicio` DATE NOT NULL,
  `fecha_periodo_fin` DATE NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_empleado` INT NOT NULL,
  `id_gafas` INT NOT NULL,
  PRIMARY KEY (`id`, `id_cliente`, `id_empleado`, `id_gafas`),
  INDEX `fk_venta_cliente1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_venta_empleado1_idx` (`id_empleado` ASC) VISIBLE,
  INDEX `fk_venta_gafas1_idx` (`id_gafas` ASC) VISIBLE,
  CONSTRAINT `fk_venta_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mydb`.`cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `mydb`.`empleado` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_gafas1`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `mydb`.`gafas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `cp` VARCHAR(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(12) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tienda` (
  `id` INT NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `cp` VARCHAR(5) NOT NULL,
  `localidad` VARCHAR(50) NULL,
  `provincia` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `nif` VARCHAR(10) NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `puesto` ENUM('cocinero', 'repartidor') NOT NULL,
  `id_tienda` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  INDEX `fk_empleado_tienda1_idx` (`id_tienda` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_tienda1`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `mydb`.`tienda` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha/hora` DATETIME NOT NULL,
  `tipo_pedido` ENUM('domicilio', 'recogida') NOT NULL,
  `precio_total` DECIMAL(10,2) NOT NULL,
  `hora_entrega` DATETIME NOT NULL,
  `id_clientes` INT NOT NULL,
  `id_tienda` INT NOT NULL,
  `id_empleado` INT NOT NULL,
  `id_tienda` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedidos_clientes1_idx` (`id_clientes` ASC) VISIBLE,
  INDEX `fk_pedidos_tienda1_idx` (`id_tienda` ASC) VISIBLE,
  INDEX `fk_pedidos_empleado1_idx` (`id_empleado` ASC, `id_tienda` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`id_clientes`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_tienda1`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `mydb`.`tienda` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_empleado1`
    FOREIGN KEY (`id_empleado` , `id_tienda`)
    REFERENCES `mydb`.`empleado` (`id` , `id_tienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` MEDIUMTEXT NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `tipo` ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedido_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido_producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `id_pedido` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `id_clientes` INT NOT NULL,
  `id_tienda` INT NOT NULL,
  `id_empleado` INT NOT NULL,
  `id_tienda` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedido_producto_pedidos1_idx` (`id_pedido` ASC, `id_clientes` ASC, `id_tienda` ASC, `id_empleado` ASC, `id_tienda` ASC) VISIBLE,
  INDEX `fk_pedido_producto_producto1_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_producto_pedidos1`
    FOREIGN KEY (`id_pedido` , `id_clientes` , `id_tienda` , `id_empleado` , `id_tienda`)
    REFERENCES `mydb`.`pedidos` (`id` , `id_clientes` , `id_tienda` , `id_empleado` , `id_tienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_producto_producto1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `mydb`.`producto` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `id_categorias` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pizza_producto1_idx` (`id_producto` ASC) VISIBLE,
  INDEX `fk_pizza_categorias1_idx` (`id_categorias` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_producto1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `mydb`.`producto` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pizza_categorias1`
    FOREIGN KEY (`id_categorias`)
    REFERENCES `mydb`.`categorias` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
