SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

USE `oleinych_a`;
-- ---
-- Table 'Person'
-- 
-- ---

DROP TABLE IF EXISTS `Person`;
    
CREATE TABLE `Person` (
  `id_person` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Fname` VARCHAR(64),
  `Mname` VARCHAR(64),
  `Lname` VARCHAR(64),
  `date_of_birth` DATE NULL DEFAULT NULL
)ENGINE = InnoDB;

-- ---
-- Table 'address'
-- 
-- ---

DROP TABLE IF EXISTS `address`;
    
CREATE TABLE `address` (
  `id_address` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `city` VARCHAR(64) NULL DEFAULT NULL,
  `address` VARCHAR(64) NULL DEFAULT NULL
)ENGINE = InnoDB;

-- ---
-- Table 'Work_place'
-- 
-- ---

DROP TABLE IF EXISTS `Work_place`;
    
CREATE TABLE `Work_place` (
  `id_work_place` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `WP_name` VARCHAR(64) NULL DEFAULT NULL,
  `id_address` SMALLINT UNSIGNED NOT NULL,
  `WP_phone` VARCHAR(14) NULL DEFAULT NULL,
  FOREIGN KEY(`id_address`) REFERENCES `address`(`id_address`)
    ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = InnoDB;

-- ---
-- Table 'Education_type'
-- 
-- ---

DROP TABLE IF EXISTS `Education_type`;
    
CREATE TABLE `Education_type` (
  `id_education_type` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Ed_type_name` VARCHAR(64) NULL DEFAULT NULL
)ENGINE = InnoDB;

-- ---
-- Table 'Education'
-- 
-- ---

DROP TABLE IF EXISTS `Education`;
    
CREATE TABLE `Education` (
  `id_education` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Ed_name_place` VARCHAR(64) NULL DEFAULT NULL,
  `id_education_type` SMALLINT UNSIGNED NOT NULL,
  FOREIGN KEY(`id_education_type`) REFERENCES `Education_type`(`id_education_type`)
    ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = InnoDB;

-- ---
-- Table 'Banks'
-- 
-- ---

DROP TABLE IF EXISTS `Banks`;
    
CREATE TABLE `Banks` (
  `id_banks` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Bank_name` VARCHAR(64) NULL DEFAULT NULL,
  `id_address` SMALLINT UNSIGNED NOT NULL,
  `Bank_phone` VARCHAR(14) NULL DEFAULT NULL,
   FOREIGN KEY(`id_address`) REFERENCES `address`(`id_address`)
    ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = InnoDB;

-- ---
-- Table 'Credit_history'
-- 
-- ---

DROP TABLE IF EXISTS `Credit_history`;
    
CREATE TABLE `Credit_history` (
  `id_credit_history` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_banks` SMALLINT UNSIGNED NOT NULL,
  `sum_loan` INT NULL DEFAULT NULL,
  `quality_of_payment` SMALLINT NULL DEFAULT NULL,
  FOREIGN KEY(`id_banks`) REFERENCES `Banks`(`id_banks`)
    ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = InnoDB;

-- ---
-- Table 'Position'
-- 
-- ---

DROP TABLE IF EXISTS `Position`;
    
CREATE TABLE `Position` (
  `id_position` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `position_name` VARCHAR(64) NULL DEFAULT NULL  
)ENGINE = InnoDB;

-- ---
-- Table 'Client'
-- 
-- ---

DROP TABLE IF EXISTS `Client`;
    
CREATE TABLE `Client` (
  `id_client` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_person` SMALLINT UNSIGNED NOT NULL,
  `id_address` SMALLINT UNSIGNED NOT NULL,
  `phone number` VARCHAR(14) NULL DEFAULT NULL,
  `id_education` SMALLINT UNSIGNED NOT NULL,
  `id_work_place` SMALLINT UNSIGNED NOT NULL,
  `average_salary` INT NULL DEFAULT NULL,
  `id_credit_history` SMALLINT UNSIGNED NOT NULL,
  `id_position` SMALLINT UNSIGNED NOT NULL,
  FOREIGN KEY(`id_person`) REFERENCES `Person`(`id_person`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY(`id_address`) REFERENCES `address`(`id_address`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY(`id_education`) REFERENCES `Education`(`id_education`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY(`id_work_place`) REFERENCES `Work_place`(`id_work_place`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY(`id_credit_history`) REFERENCES `Credit_history`(`id_credit_history`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY(`id_position`) REFERENCES `Position`(`id_position`)
    ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = InnoDB;

-- ---
-- Table 'Worker'
-- 
-- ---

DROP TABLE IF EXISTS `Worker`;
    
CREATE TABLE `Worker` (
  `id_worker` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_person` SMALLINT UNSIGNED NOT NULL,
  `id_banks` SMALLINT UNSIGNED NOT NULL,
  `id_position` SMALLINT UNSIGNED NOT NULL,
  FOREIGN KEY (`id_person`) REFERENCES `Person` (`id_person`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (`id_banks`) REFERENCES `Banks` (`id_banks`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY(`id_position`) REFERENCES `Position`(`id_position`)
    ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = InnoDB;

-- ---
-- Table 'date_of_making'
-- 
-- ---

DROP TABLE IF EXISTS `date_of_making`;
    
CREATE TABLE `date_of_making` (
  `id_date_of_making` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `date_begin` DATE NULL DEFAULT NULL,
  `date_end` DATE NULL DEFAULT NULL
)ENGINE = InnoDB;

-- ---
-- Table 'Credit_info'
-- 
-- ---

DROP TABLE IF EXISTS `Credit_info`;
    
CREATE TABLE `Credit_info` (
  `id_credit_info` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `sum` INT NULL DEFAULT NULL,
  `id_date_of_making` SMALLINT UNSIGNED NOT NULL,
  `Credit_num` INT UNSIGNED NULL DEFAULT NULL,
  `id_worker` SMALLINT UNSIGNED NOT NULL,
  `id_client` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`id_date_of_making`) REFERENCES `date_of_making` (`id_date_of_making`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (`id_worker`) REFERENCES `Worker` (`id_worker`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (`id_client`) REFERENCES `Client` (`id_client`)
    ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = InnoDB;

-- ---
-- Table 'Type_operation'
-- 
-- ---

DROP TABLE IF EXISTS `Type_operation`;
    
CREATE TABLE `Type_operation` (
  `id_type_operation` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `operation_type` VARCHAR(64) NULL DEFAULT NULL
)ENGINE = InnoDB;

-- ---
-- Table 'Payments'
-- 
-- ---

DROP TABLE IF EXISTS `Payments`;
    
CREATE TABLE `Payments` (
  `id_payments` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_worker` SMALLINT UNSIGNED NOT NULL,
  `sum_pay` INT NULL DEFAULT NULL,
  `date_pay` DATETIME NULL DEFAULT NULL,
  `Credit_num` INT  UNSIGNED NULL DEFAULT NULL,
  `id_type_operation` SMALLINT UNSIGNED NOT NULL,
  FOREIGN KEY (`id_worker`) REFERENCES `Worker` (`id_worker`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (`id_type_operation`) REFERENCES `Type_operation` (`id_type_operation`)
    ON DELETE RESTRICT ON UPDATE CASCADE 
)ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
