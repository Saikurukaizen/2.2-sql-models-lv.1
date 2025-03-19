-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(12) NULL,
  `fax` VARCHAR(45) NULL,
  `NIF` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NULL,
  `graduacion_izq` DECIMAL(4,2) NULL,
  `graduacion_der` DECIMAL(4,2) NULL,
  `montura` ENUM('flotant', 'pasta', 'metálica') NOT NULL,
  `color_montura` VARCHAR(20) NULL,
  `color_vidre_izq` VARCHAR(20) NULL,
  `color_vidre_der` VARCHAR(20) NULL,
  `precio` DECIMAL NOT NULL,
  `id_proveedores` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_gafas_proveedores1_idx` (`id_proveedores` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_proveedores1`
    FOREIGN KEY (`id_proveedores`)
    REFERENCES `optica`.`proveedores` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(12) NULL,
  `email` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`direccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `planta` VARCHAR(45) NULL,
  `piso` VARCHAR(45) NULL,
  `puerta` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `cp` VARCHAR(5) NULL,
  `pais` VARCHAR(45) NULL,
  `id_proveedores` INT NOT NULL,
  `id_empleado` INT NOT NULL,
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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(12) NULL,
  `email` VARCHAR(50) NULL,
  `fecha_registro` DATETIME NOT NULL,
  `recomendado` INT NULL,
  `id_cliente` INT NOT NULL,
  `id_direccion` INT NOT NULL,
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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATE NOT NULL,
  `fecha_inici_venta` DATE NOT NULL,
  `fecha_fi_venta` DATE NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_empleado` INT NOT NULL,
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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`venta_detalles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`venta_detalles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_venta` INT NOT NULL,
  `id_empleado` INT NOT NULL,
  `id_gafas` INT NOT NULL,
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
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SELECT c.id AS id_cliente, c.nombre, COUNT(v.id) AS compras FROM optica.clientes c LEFT JOIN optica.venta v ON c.id = v.id_cliente WHERE c.id = 1 GROUP BY c.id, c.nombre;