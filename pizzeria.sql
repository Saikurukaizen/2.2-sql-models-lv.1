-- MySQL Workbench Synchronization
-- Generated: 2025-03-13 22:39
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: marc sanchez

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER SCHEMA `mydb`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `mydb`.`empleado` (
  `id_empleado` INT() NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `nif` VARCHAR(10) UNIQUE NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `puesto` ENUM('cocinero', 'repartidor') NOT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `fk_empleado_id_tienda_idx` (`pedidos_id_tienda` ASC) VISIBLE,
  FOREIGN KEY (`id_tienda`)
    REFERENCES `mydb`.`pedidos` (`id_tienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `id_clientes` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `cp` VARCHAR(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`id_clientes`)
  REFERENCES `mydb`.`pedidos` (`id_tienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`pedidos` (
  `id_pedido` INT(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` INT(11) NOT NULL,
  `id_tienda` INT(11) NOT NULL,
  `fecha/hora` DATETIME NOT NULL,
  `tipo_pedido` ENUM('domicilio', 'recogida') NOT NULL,
  `precio_total` DECIMAL(10,2) NOT NULL,
  `id_repartidor` INT(11) NOT NULL,
  `hora_entrega` DATETIME NOT NULL,
  `clientes_id_clientes` INT(11) NOT NULL,
  `tienda_id_tienda` INT(11) NOT NULL,
  `empleado_id_empleado` INT(11) NOT NULL,
  `empleado_tienda_id_tienda` INT(11) NOT NULL,
  PRIMARY KEY (`id_pedido`, `clientes_id_clientes`, `tienda_id_tienda`, `empleado_id_empleado`, `empleado_tienda_id_tienda`),
  INDEX `fk_pedidos_clientes1_idx` (`clientes_id_clientes` ASC) VISIBLE,
  INDEX `fk_pedidos_tienda1_idx` (`tienda_id_tienda` ASC) VISIBLE,
  INDEX `fk_pedidos_empleado1_idx` (`empleado_id_empleado` ASC, `empleado_tienda_id_tienda` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_id_clientes`)
    REFERENCES `mydb`.`clientes` (`id_clientes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_tienda1`
    FOREIGN KEY (`tienda_id_tienda`)
    REFERENCES `mydb`.`tienda` (`id_tienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_empleado1`
    FOREIGN KEY (`empleado_id_empleado` , `empleado_tienda_id_tienda`)
    REFERENCES `mydb`.`empleado` (`id_empleado` , `tienda_id_tienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`tienda` (
  `id_tienda` INT(11) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `cp` VARCHAR(5) NOT NULL,
  `localidad` VARCHAR(50) NULL DEFAULT NULL,
  `provincia` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tienda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `id_producto` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` MEDIUMTEXT NULL DEFAULT NULL,
  `imagen` VARCHAR(45) NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `tipo` ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
  PRIMARY KEY (`id_producto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`categorias` (
  `id_categorias` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_categorias`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`pedido_producto` (
  `id_pedido_prod` INT(11) NOT NULL AUTO_INCREMENT,
  `id_producto` INT(11) NOT NULL,
  `cantidad` INT(11) NOT NULL,
  `pedidos_id_pedido` INT(11) NOT NULL,
  `pedidos_clientes_id_clientes` INT(11) NOT NULL,
  `pedidos_tienda_id_tienda` INT(11) NOT NULL,
  `pedidos_empleado_id_empleado` INT(11) NOT NULL,
  `pedidos_empleado_tienda_id_tienda` INT(11) NOT NULL,
  `producto_id_producto` INT(11) NOT NULL,
  PRIMARY KEY (`id_pedido_prod`, `pedidos_id_pedido`, `pedidos_clientes_id_clientes`, `pedidos_tienda_id_tienda`, `pedidos_empleado_id_empleado`, `pedidos_empleado_tienda_id_tienda`, `producto_id_producto`),
  INDEX `fk_pedido_producto_pedidos1_idx` (`pedidos_id_pedido` ASC, `pedidos_clientes_id_clientes` ASC, `pedidos_tienda_id_tienda` ASC, `pedidos_empleado_id_empleado` ASC, `pedidos_empleado_tienda_id_tienda` ASC) VISIBLE,
  INDEX `fk_pedido_producto_producto1_idx` (`producto_id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_producto_pedidos1`
    FOREIGN KEY (`pedidos_id_pedido` , `pedidos_clientes_id_clientes` , `pedidos_tienda_id_tienda` , `pedidos_empleado_id_empleado` , `pedidos_empleado_tienda_id_tienda`)
    REFERENCES `mydb`.`pedidos` (`id_pedido` , `clientes_id_clientes` , `tienda_id_tienda` , `empleado_id_empleado` , `empleado_tienda_id_tienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_producto_producto1`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `mydb`.`producto` (`id_producto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`pizza` (
  `id_pizza` INT(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` INT(11) NOT NULL,
  `producto_id_producto` INT(11) NOT NULL,
  `categorias_id_categorias` INT(11) NOT NULL,
  PRIMARY KEY (`id_pizza`, `id_categoria`, `producto_id_producto`, `categorias_id_categorias`),
  INDEX `fk_pizza_producto1_idx` (`producto_id_producto` ASC) VISIBLE,
  INDEX `fk_pizza_categorias1_idx` (`categorias_id_categorias` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_producto1`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `mydb`.`producto` (`id_producto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pizza_categorias1`
    FOREIGN KEY (`categorias_id_categorias`)
    REFERENCES `mydb`.`categorias` (`id_categorias`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
