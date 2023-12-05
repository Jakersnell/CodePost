DROP SCHEMA IF EXISTS `codepostdb`;

CREATE SCHEMA IF NOT EXISTS `codepostdb` DEFAULT CHARACTER SET utf8;


USE `codepostdb`;

DROP TABLE IF EXISTS `codepostdb` . `user`;
CREATE TABLE IF NOT EXISTS `codepostdb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(128) DEFAULT NULL,
)

DROP TABLE IF EXISTS `codepostdb`.`post`;
CREATE TABLE IF NOT EXISTS `codepostdb`.`post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(30) NOT NULL,
  `title` varchar(60) NOT NULL,
  `description` varchar(350) DEFAULT NULL,
  `code_snippet` text,
  `language`
  set
('RUST', 'JAVA', 'PYTHON') NOT NULL,
    `created_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8;

SET SQL_MODE = '';
DROP USER IF EXISTS application;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'application' IDENTIFIED BY 'application';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'application';

