
DROP DATABASE IF EXISTS car_repair_shop;
CREATE DATABASE car_repair_shop;
USE car_repair_shop;

DROP TABLE IF EXISTS `tbrands`
CREATE TABLE `tbrands` (
  `id` int(11) NOT NULL,
  `nome` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tvehicles`
CREATE TABLE `tvehicles` (
  `targa` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kmarca` int(11) NOT NULL,
  PRIMARY KEY (`targa`),
  KEY `kmarca` (`kmarca`),
  CONSTRAINT `tvehicles_ibfk_1` FOREIGN KEY (`kmarca`) REFERENCES `tbrands` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tworkshops`
CREATE TABLE `tworkshops` (
  `id` int(11) NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;