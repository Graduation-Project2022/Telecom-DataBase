-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema telecom
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema telecom
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `telecom` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `telecom` ;

-- -----------------------------------------------------
-- Table `telecom`.`billing_conditions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`billing_conditions` (
  `billingConditionID` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `conditionName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`billingConditionID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`companies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`companies` (
  `companyCode` VARCHAR(45) NOT NULL,
  `companyName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`companyCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`general_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`general_plans` (
  `generalPlanID` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `generalPlanName` VARCHAR(45) NOT NULL,
  `companyCode` VARCHAR(45) NOT NULL,
  `generationTime` DATETIME NOT NULL,
  `terminationTime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`generalPlanID`),
  INDEX `fk_general_plans_companies_idx` (`companyCode` ASC) VISIBLE,
  CONSTRAINT `fk_general_plans_companies`
    FOREIGN KEY (`companyCode`)
    REFERENCES `telecom`.`companies` (`companyCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`plans` (
  `planID` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `planName` VARCHAR(45) NOT NULL,
  `generalPlanID` SMALLINT(6) NOT NULL,
  `initialPrice` DECIMAL(8,2) NOT NULL,
  `periodicity` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`planID`),
  INDEX `fk_plans_general_plans1_idx` (`generalPlanID` ASC) VISIBLE,
  CONSTRAINT `fk_plans_general_plans1`
    FOREIGN KEY (`generalPlanID`)
    REFERENCES `telecom`.`general_plans` (`generalPlanID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 30
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`company_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`company_plans` (
  `companyCode` VARCHAR(45) NOT NULL,
  `planID` SMALLINT(6) NOT NULL,
  PRIMARY KEY (`companyCode`, `planID`),
  INDEX `fk_company_plans_companies1_idx` (`companyCode` ASC) VISIBLE,
  INDEX `fk_company_plans_plans1_idx` (`planID` ASC) VISIBLE,
  CONSTRAINT `fk_company_plans_companies1`
    FOREIGN KEY (`companyCode`)
    REFERENCES `telecom`.`companies` (`companyCode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_company_plans_plans1`
    FOREIGN KEY (`planID`)
    REFERENCES `telecom`.`plans` (`planID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`customers` (
  `customerID` INT(11) NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `nationalID` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3004470
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`mobilenumbers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`mobilenumbers` (
  `MSISDN` VARCHAR(45) NOT NULL,
  `companyCode` VARCHAR(45) NOT NULL,
  `customerID` INT(11) NULL DEFAULT NULL,
  `planID` SMALLINT(6) NOT NULL,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MSISDN`),
  INDEX `fk_mobileNumbers_companies1_idx` (`companyCode` ASC) VISIBLE,
  INDEX `fk_mobileNumbers_customers1_idx` (`customerID` ASC) VISIBLE,
  INDEX `fk_mobileNumbers_plans1_idx` (`planID` ASC) VISIBLE,
  CONSTRAINT `fk_mobileNumbers_companies1`
    FOREIGN KEY (`companyCode`)
    REFERENCES `telecom`.`company_plans` (`companyCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_mobileNumbers_customers1`
    FOREIGN KEY (`customerID`)
    REFERENCES `telecom`.`customers` (`customerID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_mobileNumbers_plans1`
    FOREIGN KEY (`planID`)
    REFERENCES `telecom`.`company_plans` (`planID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`quantity_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`quantity_types` (
  `quantityTypeID` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `quantityTypeName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`quantityTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`products` (
  `productID` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`productID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`services` (
  `serviceName` VARCHAR(45) NOT NULL,
  `productID` SMALLINT(6) NOT NULL,
  PRIMARY KEY (`serviceName`),
  INDEX `fk_services_products1_idx` (`productID` ASC) VISIBLE,
  CONSTRAINT `fk_services_products1`
    FOREIGN KEY (`productID`)
    REFERENCES `telecom`.`products` (`productID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`cdrs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`cdrs` (
  `cdrID` INT(11) NOT NULL AUTO_INCREMENT,
  `MSISDN_A` VARCHAR(45) NOT NULL,
  `MSISDN_B` VARCHAR(45) NOT NULL,
  `serviceName` VARCHAR(45) NOT NULL,
  `callTime` DATETIME NOT NULL,
  `durationInSeconds` SMALLINT(6) NOT NULL,
  `rate` DECIMAL(10,3) NULL DEFAULT NULL,
  `quantityTypeID` SMALLINT(6) NULL DEFAULT NULL,
  `isBilled` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`cdrID`),
  INDEX `fk_recent_cdrs_mobileNumbers1_idx` (`MSISDN_A` ASC) VISIBLE,
  INDEX `fk_recent_cdrs_mobileNumbers2_idx` (`MSISDN_B` ASC) VISIBLE,
  INDEX `fk_recent_cdrs_services1_idx` (`serviceName` ASC) VISIBLE,
  INDEX `fk_recent_cdrs_quantity_types1_idx` (`quantityTypeID` ASC) VISIBLE,
  CONSTRAINT `fk_recent_cdrs_mobileNumbers1`
    FOREIGN KEY (`MSISDN_A`)
    REFERENCES `telecom`.`mobilenumbers` (`MSISDN`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_recent_cdrs_mobileNumbers2`
    FOREIGN KEY (`MSISDN_B`)
    REFERENCES `telecom`.`mobilenumbers` (`MSISDN`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_recent_cdrs_quantity_types1`
    FOREIGN KEY (`quantityTypeID`)
    REFERENCES `telecom`.`quantity_types` (`quantityTypeID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_recent_cdrs_services1`
    FOREIGN KEY (`serviceName`)
    REFERENCES `telecom`.`services` (`serviceName`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 14504
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`current_billing_condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`current_billing_condition` (
  `MSISDN` VARCHAR(45) NOT NULL,
  `serviceName` VARCHAR(45) NOT NULL,
  `billingConditionID` SMALLINT(6) NOT NULL,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MSISDN`, `serviceName`),
  INDEX `fk_current_billing_condition_mobilenumbers1_idx` (`MSISDN` ASC) VISIBLE,
  INDEX `fk_current_billing_condition_services1_idx` (`serviceName` ASC) VISIBLE,
  INDEX `fk_current_billing_condition_billing_conditions1` (`billingConditionID` ASC) VISIBLE,
  CONSTRAINT `fk_current_billing_condition_billing_conditions1`
    FOREIGN KEY (`billingConditionID`)
    REFERENCES `telecom`.`billing_conditions` (`billingConditionID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_current_billing_condition_mobilenumbers1`
    FOREIGN KEY (`MSISDN`)
    REFERENCES `telecom`.`mobilenumbers` (`MSISDN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_current_billing_condition_services1`
    FOREIGN KEY (`serviceName`)
    REFERENCES `telecom`.`services` (`serviceName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`current_quantity_balance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`current_quantity_balance` (
  `MSISDN` VARCHAR(45) NOT NULL,
  `quantityTypeID` SMALLINT(6) NOT NULL,
  `currentBalance` VARCHAR(45) NULL DEFAULT NULL,
  `expirationDate` VARCHAR(45) NULL DEFAULT NULL,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MSISDN`, `quantityTypeID`),
  INDEX `fk_current_quantity_balance_mobileNumbers1_idx` (`MSISDN` ASC) VISIBLE,
  INDEX `fk_current_quantity_balance_quantity_types1_idx` (`quantityTypeID` ASC) VISIBLE,
  CONSTRAINT `fk_current_quantity_balance_mobileNumbers1`
    FOREIGN KEY (`MSISDN`)
    REFERENCES `telecom`.`mobilenumbers` (`MSISDN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_current_quantity_balance_quantity_types1`
    FOREIGN KEY (`quantityTypeID`)
    REFERENCES `telecom`.`quantity_types` (`quantityTypeID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`invoices` (
  `invoiceID` INT(11) NOT NULL AUTO_INCREMENT,
  `MSISDN` VARCHAR(45) NOT NULL,
  `releaseDate` DATE NOT NULL,
  `price` DECIMAL(8,2) NULL DEFAULT NULL,
  `currency` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`invoiceID`),
  INDEX `fk_invoice_mobilenumbers1_idx` (`MSISDN` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_mobilenumbers1`
    FOREIGN KEY (`MSISDN`)
    REFERENCES `telecom`.`mobilenumbers` (`MSISDN`))
ENGINE = InnoDB
AUTO_INCREMENT = 4040037
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`plan_service_default_billing_condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`plan_service_default_billing_condition` (
  `planID` SMALLINT(6) NOT NULL,
  `serviceName` VARCHAR(45) NOT NULL,
  `billingConditionID` SMALLINT(6) NOT NULL,
  PRIMARY KEY (`planID`, `serviceName`),
  INDEX `fk_plans_services_default_billing_condition_plans1_idx` (`planID` ASC) VISIBLE,
  INDEX `fk_plans_services_default_billing_condition_services1_idx` (`serviceName` ASC) VISIBLE,
  INDEX `fk_plans_services_default_billing_condition_billing_conditi_idx` (`billingConditionID` ASC) VISIBLE,
  CONSTRAINT `fk_plans_services_default_billing_condition_billing_conditions1`
    FOREIGN KEY (`billingConditionID`)
    REFERENCES `telecom`.`billing_conditions` (`billingConditionID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plans_services_default_billing_condition_plans1`
    FOREIGN KEY (`planID`)
    REFERENCES `telecom`.`plans` (`planID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plans_services_default_billing_condition_services1`
    FOREIGN KEY (`serviceName`)
    REFERENCES `telecom`.`services` (`serviceName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`plans_quantities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`plans_quantities` (
  `planID` SMALLINT(6) NOT NULL,
  `quantityTypeID` SMALLINT(6) NOT NULL,
  `quantity` DECIMAL(11,2) NOT NULL,
  PRIMARY KEY (`planID`, `quantityTypeID`),
  INDEX `fk_plans_quantities_plans1_idx` (`planID` ASC) VISIBLE,
  INDEX `fk_plans_quantities_quantity_types1_idx` (`quantityTypeID` ASC) VISIBLE,
  CONSTRAINT `fk_plans_quantities_plans1`
    FOREIGN KEY (`planID`)
    REFERENCES `telecom`.`plans` (`planID`),
  CONSTRAINT `fk_plans_quantities_quantity_types1`
    FOREIGN KEY (`quantityTypeID`)
    REFERENCES `telecom`.`quantity_types` (`quantityTypeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`plans_services_prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`plans_services_prices` (
  `planID` SMALLINT(6) NOT NULL,
  `serviceName` VARCHAR(45) NOT NULL,
  `billingConditionID` SMALLINT(6) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `quantityTypeID` SMALLINT(6) NOT NULL,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`planID`, `serviceName`, `billingConditionID`),
  INDEX `fk_plans_service_prices_plans1_idx` (`planID` ASC) VISIBLE,
  INDEX `fk_plans_service_prices_services1_idx` (`serviceName` ASC) VISIBLE,
  INDEX `fk_plans_service_prices_billing_conditions1_idx` (`billingConditionID` ASC) VISIBLE,
  INDEX `fk_plans_service_prices_quantity_types1_idx` (`quantityTypeID` ASC) VISIBLE,
  CONSTRAINT `fk_plans_service_prices_billing_conditions1`
    FOREIGN KEY (`billingConditionID`)
    REFERENCES `telecom`.`billing_conditions` (`billingConditionID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plans_service_prices_plans1`
    FOREIGN KEY (`planID`)
    REFERENCES `telecom`.`plans` (`planID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plans_service_prices_quantity_types1`
    FOREIGN KEY (`quantityTypeID`)
    REFERENCES `telecom`.`quantity_types` (`quantityTypeID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plans_service_prices_services1`
    FOREIGN KEY (`serviceName`)
    REFERENCES `telecom`.`services` (`serviceName`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telecom`.`service_quantity_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`service_quantity_types` (
  `serviceName` VARCHAR(45) NOT NULL,
  `quantityTypeID` SMALLINT(6) NOT NULL,
  PRIMARY KEY (`quantityTypeID`, `serviceName`),
  INDEX `fk_service_quantity_types_services1_idx` (`serviceName` ASC) VISIBLE,
  INDEX `fk_service_quantity_types_quantity_types1_idx` (`quantityTypeID` ASC) VISIBLE,
  CONSTRAINT `fk_service_quantity_types_quantity_types1`
    FOREIGN KEY (`quantityTypeID`)
    REFERENCES `telecom`.`quantity_types` (`quantityTypeID`),
  CONSTRAINT `fk_service_quantity_types_services1`
    FOREIGN KEY (`serviceName`)
    REFERENCES `telecom`.`services` (`serviceName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `telecom` ;

-- -----------------------------------------------------
-- Placeholder table for view `telecom`.`current_invoice_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`current_invoice_view` (`MSISDN` INT, `currentPrice` INT, `expirationDate` INT, `Currency` INT);

-- -----------------------------------------------------
-- Placeholder table for view `telecom`.`get_today_invoices_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`get_today_invoices_view` (`MSISDN` INT, `releaseDate` INT, `price` INT, `currency` INT);

-- -----------------------------------------------------
-- Placeholder table for view `telecom`.`initialize_balance_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`initialize_balance_view` (`MSISDN` INT, `quantityTypeID` INT, `quantity` INT, `releaseDate` INT);

-- -----------------------------------------------------
-- Placeholder table for view `telecom`.`initialize_billing_condition_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`initialize_billing_condition_view` (`MSISDN` INT, `serviceName` INT, `billingConditionID` INT);

-- -----------------------------------------------------
-- Placeholder table for view `telecom`.`rate_calls_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`rate_calls_view` (`cdrID` INT, `rate` INT, `quantityTypeID` INT);

-- -----------------------------------------------------
-- Placeholder table for view `telecom`.`unrated_cdrs_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telecom`.`unrated_cdrs_view` (`cdrID` INT, `MSISDN_A` INT, `serviceName` INT, `durationInSeconds` INT, `price` INT, `priceQuantityType` INT, `rate` INT, `rateQuantityType` INT, `isBilled` INT);

-- -----------------------------------------------------
-- procedure add_plan_to_company_plans
-- -----------------------------------------------------

DELIMITER $$
USE `telecom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_plan_to_company_plans`(newPlan SMALLINT)
BEGIN
	INSERT INTO company_plans
    SELECT gp.companyCode,p.planID
    FROM plans p
    INNER JOIN general_plans gp
		ON p.generalPlanID = gp.generalPlanID
	WHERE p.planID = newPlan;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure change_billing_condition
-- -----------------------------------------------------

DELIMITER $$
USE `telecom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_billing_condition`(subscriber VARCHAR(45),quantityType INT)
BEGIN
	UPDATE current_billing_condition cbc
	INNER JOIN current_quantity_balance cqb
		ON cbc.MSISDN = cqb.MSISDN 
	INNER JOIN service_quantity_types cqt 
		ON cqb.quantityTypeID = cqt.quantityTypeID AND cbc.serviceName = cqt.serviceName
		SET 
			cbc.billingConditionID = CASE 
				WHEN cbc.billingConditionID = 1 THEN 2 
				WHEN cbc.billingConditionID = 2 THEN 3 
                WHEN cbc.billingConditionID = 4 THEN 2 
			ELSE 3 
		END
WHERE cqb.MSISDN=subscriber AND cqb.quantityTypeId = quantityType ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure initialize_balance
-- -----------------------------------------------------

DELIMITER $$
USE `telecom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `initialize_balance`(subscriber VARCHAR(45))
BEGIN
	INSERT INTO current_quantity_balance (MSISDN,quantityTypeID,currentBalance,expirationDate)
    SELECT *
	FROM initialize_balance_view
    WHERE initialize_balance_view.MSISDN = subscriber;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure initialize_billing_condition
-- -----------------------------------------------------

DELIMITER $$
USE `telecom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `initialize_billing_condition`(subscriber VARCHAR(45))
BEGIN
	INSERT INTO current_billing_condition (MSISDN,serviceName,billingConditionID)
    SELECT *
    FROM initialize_billing_condition_view
    WHERE initialize_billing_condition_view.MSISDN = subscriber;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure initialize_default_plan_billing_condition
-- -----------------------------------------------------

DELIMITER $$
USE `telecom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `initialize_default_plan_billing_condition`(Plan SMALLINT,service VARCHAR(45))
BEGIN
    UPDATE plan_service_default_billing_condition psdbc
		INNER JOIN plans_services_prices psp
			ON psdbc.planID=psp.planID AND psdbc.serviceName = psp.serviceName
	SET 
		psdbc.billingConditionID = 2
	WHERE psdbc.planID=plan AND psdbc.serviceName=service AND psp.quantityTypeID != 2;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure initialize_invoice
-- -----------------------------------------------------

DELIMITER $$
USE `telecom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `initialize_invoice`(subscriber VARCHAR(45))
BEGIN
	DECLARE plan_invoice_periodicity VARCHAR(45);
    
    SELECT p.periodicity
    INTO plan_invoice_periodicity
    FROM mobileNumbers mn
    INNER JOIN plans p
    ON mn.planID = p.planID
    WHERE mn.MSISDN = subscriber;
    
	INSERT INTO invoices (MSISDN , releaseDate) 
    VALUES(
    subscriber,
    CASE 
		WHEN plan_invoice_periodicity = 'weekly'  THEN DATE_ADD(CURRENT_DATE(), INTERVAL 1 week)
		WHEN plan_invoice_periodicity = 'monthly' THEN DATE_ADD(CURRENT_DATE(), INTERVAL 1 month)
        WHEN plan_invoice_periodicity = 'yearly'  THEN DATE_ADD(CURRENT_DATE(), INTERVAL 1 year)
	END);
    
    INSERT INTO current_quantity_balance (MSISDN,quantityTypeID,currentBalance,expirationDate)
    SELECT 
		mn.MSiSDN,2,p.initialPrice,i.releaseDate
	FROM mobilenumbers mn
    INNER JOIN plans p
		ON mn.planID=p.planID
	INNER JOIN invoices i
		ON mn.MSISDN = i.MSISDN
	WHERE mn.MSISDN=subscriber AND i.price IS NULL;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure terminate_old_invoice
-- -----------------------------------------------------

DELIMITER $$
USE `telecom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `terminate_old_invoice`(subscriber VARCHAR(45))
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	UPDATE invoices i 
    INNER JOIN current_invoice_view civ
    ON i.MSISDN=civ.MSISDN
    SET i.releaseDate = current_date(),
		i.price = civ.currentPrice,
        i.currency = civ.currency
    WHERE i.MSISDN = subscriber AND i.price IS NULL;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `telecom`.`current_invoice_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `telecom`.`current_invoice_view`;
USE `telecom`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `telecom`.`current_invoice_view` AS select `cqb`.`MSISDN` AS `MSISDN`,`cqb`.`currentBalance` AS `currentPrice`,`cqb`.`expirationDate` AS `expirationDate`,'EGP' AS `Currency` from `telecom`.`current_quantity_balance` `cqb` where (`cqb`.`quantityTypeID` = 2);

-- -----------------------------------------------------
-- View `telecom`.`get_today_invoices_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `telecom`.`get_today_invoices_view`;
USE `telecom`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `telecom`.`get_today_invoices_view` AS select `i`.`MSISDN` AS `MSISDN`,`i`.`releaseDate` AS `releaseDate`,`i`.`price` AS `price`,`i`.`currency` AS `currency` from `telecom`.`invoices` `i` where ((`i`.`releaseDate` = curdate()) and isnull(`i`.`price`));

-- -----------------------------------------------------
-- View `telecom`.`initialize_balance_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `telecom`.`initialize_balance_view`;
USE `telecom`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `telecom`.`initialize_balance_view` AS select `mn`.`MSISDN` AS `MSISDN`,`pq`.`quantityTypeID` AS `quantityTypeID`,`pq`.`quantity` AS `quantity`,`i`.`releaseDate` AS `releaseDate` from ((`telecom`.`mobilenumbers` `mn` join `telecom`.`plans_quantities` `pq` on((`mn`.`planID` = `pq`.`planID`))) join `telecom`.`invoices` `i` on((`mn`.`MSISDN` = `i`.`MSISDN`))) where isnull(`i`.`price`);

-- -----------------------------------------------------
-- View `telecom`.`initialize_billing_condition_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `telecom`.`initialize_billing_condition_view`;
USE `telecom`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `telecom`.`initialize_billing_condition_view` AS select `mn`.`MSISDN` AS `MSISDN`,`psdbc`.`serviceName` AS `serviceName`,`psdbc`.`billingConditionID` AS `billingConditionID` from (`telecom`.`mobilenumbers` `mn` left join `telecom`.`plan_service_default_billing_condition` `psdbc` on((`mn`.`planID` = `psdbc`.`planID`)));

-- -----------------------------------------------------
-- View `telecom`.`rate_calls_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `telecom`.`rate_calls_view`;
USE `telecom`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `telecom`.`rate_calls_view` AS select `c`.`cdrID` AS `cdrID`,(`psp`.`price` * ceiling((`c`.`durationInSeconds` / 60))) AS `rate`,`psp`.`quantityTypeID` AS `quantityTypeID` from (((`telecom`.`cdrs` `c` join `telecom`.`mobilenumbers` `mn` on((`c`.`MSISDN_A` = `mn`.`MSISDN`))) join `telecom`.`plans_services_prices` `psp` on(((`mn`.`planID` = `psp`.`planID`) and (`c`.`serviceName` = `psp`.`serviceName`)))) join `telecom`.`current_billing_condition` `cbc` on(((`c`.`MSISDN_A` = `cbc`.`MSISDN`) and (`psp`.`serviceName` = `cbc`.`serviceName`) and (`psp`.`billingConditionID` = `cbc`.`billingConditionID`))));

-- -----------------------------------------------------
-- View `telecom`.`unrated_cdrs_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `telecom`.`unrated_cdrs_view`;
USE `telecom`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `telecom`.`unrated_cdrs_view` AS select `c`.`cdrID` AS `cdrID`,`c`.`MSISDN_A` AS `MSISDN_A`,`c`.`serviceName` AS `serviceName`,`c`.`durationInSeconds` AS `durationInSeconds`,`psp`.`price` AS `price`,`psp`.`quantityTypeID` AS `priceQuantityType`,`c`.`rate` AS `rate`,`c`.`quantityTypeID` AS `rateQuantityType`,`c`.`isBilled` AS `isBilled` from (((`telecom`.`cdrs` `c` join `telecom`.`mobilenumbers` `mn` on((`c`.`MSISDN_A` = `mn`.`MSISDN`))) join `telecom`.`plans_services_prices` `psp` on(((`mn`.`planID` = `psp`.`planID`) and (`c`.`serviceName` = `psp`.`serviceName`)))) join `telecom`.`current_billing_condition` `cbc` on(((`c`.`MSISDN_A` = `cbc`.`MSISDN`) and (`c`.`serviceName` = `cbc`.`serviceName`) and (`psp`.`billingConditionID` = `cbc`.`billingConditionID`)))) where isnull(`c`.`rate`) limit 20000;
USE `telecom`;

DELIMITER $$
USE `telecom`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `telecom`.`add_company_plan_trigger`
AFTER INSERT ON `telecom`.`plans`
FOR EACH ROW
BEGIN
	CALL add_plan_to_company_plans(new.planID);
	INSERT INTO plan_service_default_billing_condition(planID,serviceName,billingConditionID) VALUES(new.planID,'InternationalCall',3);
    INSERT INTO plan_service_default_billing_condition(planID,serviceName,billingConditionID) VALUES(new.planID,'localCall',3);
    INSERT INTO plan_service_default_billing_condition(planID,serviceName,billingConditionID) VALUES(new.planID,'sameOperatorCall',3);
    INSERT INTO plan_service_default_billing_condition(planID,serviceName,billingConditionID) VALUES(new.planID,'internet',3);
    INSERT INTO plan_service_default_billing_condition(planID,serviceName,billingConditionID) VALUES(new.planID,'SocialInternet',3);
    INSERT INTO plan_service_default_billing_condition(planID,serviceName,billingConditionID) VALUES(new.planID,'SMS',3);
END$$

USE `telecom`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `telecom`.`initialize_balance_trigger`
AFTER INSERT ON `telecom`.`mobilenumbers`
FOR EACH ROW
BEGIN
	CALL initialize_invoice(new.MSISDN);
    CALL initialize_balance(new.MSISDN);
    CALL initialize_billing_condition(new.MSISDN);
END$$

USE `telecom`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `telecom`.`modify_balance_trigger`
AFTER UPDATE ON `telecom`.`mobilenumbers`
FOR EACH ROW
BEGIN
	IF NEW.planID != OLD.planID THEN 	
		CALL terminate_old_invoice(NEW.MSISDN);
		DELETE FROM current_quantity_balance WHERE current_quantity_balance.MSISDN=new.MSISDN;
		CALL initialize_invoice(NEW.MSISDN);
		CALL initialize_balance(NEW.MSISDN);
		DELETE FROM current_billing_condition WHERE current_billing_condition.MSISDN=new.MSISDN;
		CALL initialize_billing_condition(NEW.MSISDN); 
    END IF;
END$$

USE `telecom`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `telecom`.`check_billing_condition_trigger`
AFTER UPDATE ON `telecom`.`current_quantity_balance`
FOR EACH ROW
BEGIN
	IF new.currentBalance<=0 OR new.expirationDate<now() THEN
		CALL change_billing_condition(NEW.MSISDN,NEW.quantityTypeID);
	END IF;
END$$

USE `telecom`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `telecom`.`initialize_plans_billing_conditions_trigger`
AFTER INSERT ON `telecom`.`plans_services_prices`
FOR EACH ROW
BEGIN
	CALL initialize_default_plan_billing_condition(new.planID,new.serviceName);
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
