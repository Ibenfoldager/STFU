
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema stfu
-- -----------------------------------------------------

-- sletter databasen (både stfu og døk_social hvis man skulle være kommet til at lave begge) inden koden køres igen - altså for at få en helt frisk DB. 

DROP DATABASE stfu; 
DROP DATABASE døk_social; 


CREATE SCHEMA IF NOT EXISTS `stfu` DEFAULT CHARACTER SET utf8 ;
USE `stfu` ;

-- -----------------------------------------------------
-- Table `døk_social`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stfu`.`event` (
  `idEvent` INT(11) NOT NULL,
  `EventName` VARCHAR(100) NOT NULL,
  `idStudent` INT(11) NOT NULL,
  `Location` VARCHAR(100) NOT NULL,
  `Price` INT(11) NOT NULL,
  `Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Description` LONGTEXT NOT NULL,
  `Pictures` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idEvent`),
  UNIQUE INDEX `idEvent_UNIQUE` (`idEvent` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `døk_social`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stfu`.`student` (
  `idStudent` INT(11) NOT NULL,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idStudent`),
  UNIQUE INDEX `idStudent_UNIQUE` (`idStudent` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `døk_social`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stfu`.`post` (
  `idPost` INT(11) NOT NULL,
  `Student_idStudent` INT(11) NOT NULL,
  `Event_idEvent` INT(11) NOT NULL,
  `Parent_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idPost`),
  UNIQUE INDEX `idPost_UNIQUE` (`idPost` ASC),
  INDEX `fk_Post_Student1_idx` (`Student_idStudent` ASC),
  INDEX `fk_Post_Event1_idx` (`Event_idEvent` ASC),
  CONSTRAINT `fk_Post_Event1`
    FOREIGN KEY (`Event_idEvent`)
    REFERENCES `stfu`.`event` (`idEvent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Student1`
    FOREIGN KEY (`Student_idStudent`)
    REFERENCES `stfu`.`student` (`idStudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `døk_social`.`student_has_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stfu`.`student_has_event` (
  `Student_idStudent` INT(11) NOT NULL,
  `Event_idEvent` INT(11) NOT NULL,
  PRIMARY KEY (`Student_idStudent`, `Event_idEvent`),
  INDEX `fk_Student_has_Event_Event1_idx` (`Event_idEvent` ASC),
  INDEX `fk_Student_has_Event_Student_idx` (`Student_idStudent` ASC),
  CONSTRAINT `fk_Student_has_Event_Event1`
    FOREIGN KEY (`Event_idEvent`)
    REFERENCES `stfu`.`event` (`idEvent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_has_Event_Student`
    FOREIGN KEY (`Student_idStudent`)
    REFERENCES `stfu`.`student` (`idStudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
