
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- dealer_content
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `dealer_content`;

CREATE TABLE `dealer_content`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `dealer_id` INTEGER NOT NULL,
    `content_id` INTEGER NOT NULL,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    `version` INTEGER DEFAULT 0,
    `version_created_at` DATETIME,
    `version_created_by` VARCHAR(100),
    PRIMARY KEY (`id`),
    INDEX `FI_dealer_content_dealer_id` (`dealer_id`),
    INDEX `FI_dealer_content_content_id` (`content_id`),
    CONSTRAINT `fk_dealer_content_dealer_id`
        FOREIGN KEY (`dealer_id`)
        REFERENCES `dealer` (`id`)
        ON UPDATE RESTRICT
        ON DELETE CASCADE,
    CONSTRAINT `fk_dealer_content_content_id`
        FOREIGN KEY (`content_id`)
        REFERENCES `content` (`id`)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- dealer_content_version
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `dealer_content_version`;

CREATE TABLE `dealer_content_version`
(
    `id` INTEGER NOT NULL,
    `dealer_id` INTEGER NOT NULL,
    `content_id` INTEGER NOT NULL,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    `version` INTEGER DEFAULT 0 NOT NULL,
    `version_created_at` DATETIME,
    `version_created_by` VARCHAR(100),
    `dealer_id_version` INTEGER DEFAULT 0,
    `content_id_version` INTEGER DEFAULT 0,
    PRIMARY KEY (`id`,`version`),
    CONSTRAINT `dealer_content_version_FK_1`
        FOREIGN KEY (`id`)
        REFERENCES `dealer_content` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;
