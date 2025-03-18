-- MySQL Workbench Synchronization
-- Generated: 2025-03-18 10:26
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: mks4n

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER SCHEMA `optica`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `optica`.`proveedores` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(12) NULL DEFAULT NULL,
  `fax` VARCHAR(45) NULL DEFAULT NULL,
  `NIF` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NULL DEFAULT NULL,
  `graduacion_izq` DECIMAL(4,2) NULL DEFAULT NULL,
  `graduacion_der` DECIMAL(4,2) NULL DEFAULT NULL,
  `montura` ENUM('flotant', 'pasta', 'metálica') NOT NULL,
  `color_montura` VARCHAR(20) NULL DEFAULT NULL,
  `color_vidre_izq` VARCHAR(20) NULL DEFAULT NULL,
  `color_vidre_der` VARCHAR(20) NULL DEFAULT NULL,
  `precio` DECIMAL NOT NULL,
  `id_proveedor` INT(11) NULL DEFAULT NULL,
  `id_proveedores` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_gafas_proveedores1_idx` (`id_proveedores` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_proveedores1`
    FOREIGN KEY (`id_proveedores`)
    REFERENCES `optica`.`proveedores` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(12) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `fecha_registro` DATETIME NOT NULL,
  `recomendado` INT(11) NULL DEFAULT NULL,
  `id_cliente` INT(11) NOT NULL,
  `id_direccion` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clientes_clientes1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_clientes_direccion1_idx` (`id_direccion` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_clientes1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_clientes_direccion1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `optica`.`direccion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`proveedores_has_proveedores` (
  `proveedores_Gafas_id` INT(11) NOT NULL,
  `proveedores_id` INT(11) NOT NULL,
  PRIMARY KEY (`proveedores_Gafas_id`, `proveedores_id`),
  INDEX `fk_proveedores_has_proveedores_proveedores1_idx` (`proveedores_id` ASC) VISIBLE,
  INDEX `fk_proveedores_has_proveedores_proveedores_idx` (`proveedores_Gafas_id` ASC) VISIBLE,
  CONSTRAINT `fk_proveedores_has_proveedores_proveedores`
    FOREIGN KEY (`proveedores_Gafas_id`)
    REFERENCES `optica`.`gafas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_proveedores_has_proveedores_proveedores1`
    FOREIGN KEY (`proveedores_id`)
    REFERENCES `optica`.`proveedores` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`empleado` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(12) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`venta` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATE NOT NULL,
  `fecha_inici_venta` DATE NOT NULL,
  `fecha_fi_venta` DATE NOT NULL,
  `id_cliente` INT(11) NOT NULL,
  `id_empleado` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_venta_clientes1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_venta_empleado1_idx` (`id_empleado` ASC) VISIBLE,
  CONSTRAINT `fk_venta_clientes1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `optica`.`empleado` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`venta_detalles` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_venta` INT(11) NOT NULL,
  `id_empleado` INT(11) NOT NULL,
  `id_gafas` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_venta_detalles_venta1_idx` (`id_venta` ASC) VISIBLE,
  INDEX `fk_venta_detalles_empleado1_idx` (`id_empleado` ASC) VISIBLE,
  INDEX `fk_venta_detalles_gafas1_idx` (`id_gafas` ASC) VISIBLE,
  CONSTRAINT `fk_venta_detalles_venta1`
    FOREIGN KEY (`id_venta`)
    REFERENCES `optica`.`venta` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_detalles_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `optica`.`empleado` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_detalles_gafas1`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `optica`.`gafas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`direccion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NULL DEFAULT NULL,
  `numero` VARCHAR(45) NULL DEFAULT NULL,
  `planta` VARCHAR(45) NULL DEFAULT NULL,
  `piso` VARCHAR(45) NULL DEFAULT NULL,
  `puerta` VARCHAR(45) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `cp` VARCHAR(5) NULL DEFAULT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  `id_proveedores` INT(11) NOT NULL,
  `id_empleado` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_direccion_proveedores1_idx` (`id_proveedores` ASC) VISIBLE,
  INDEX `fk_direccion_empleado1_idx` (`id_empleado` ASC) VISIBLE,
  CONSTRAINT `fk_direccion_proveedores1`
    FOREIGN KEY (`id_proveedores`)
    REFERENCES `optica`.`proveedores` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_direccion_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `optica`.`empleado` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
