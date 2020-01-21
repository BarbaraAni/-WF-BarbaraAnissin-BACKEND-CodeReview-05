-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 21. Jan 2020 um 15:03
-- Server-Version: 10.4.10-MariaDB
-- PHP-Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `cr05_barbara_anissin_carrental`
--
CREATE DATABASE IF NOT EXISTS `cr05_barbara_anissin_carrental` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cr05_barbara_anissin_carrental`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `car`
--

CREATE TABLE IF NOT EXISTS `car` (
  `car_id` int(11) NOT NULL AUTO_INCREMENT,
  `seats` int(11) NOT NULL,
  `available` tinyint(1) NOT NULL,
  PRIMARY KEY (`car_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `charges`
--

CREATE TABLE IF NOT EXISTS `charges` (
  `charge_id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_amount` int(11) NOT NULL,
  PRIMARY KEY (`charge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `invoice`
--

CREATE TABLE IF NOT EXISTS `invoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` int(11) NOT NULL,
  `fk_charges_id` int(11) NOT NULL,
  `fk_user_id` int(11) NOT NULL,
  `fk_return_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `fk_charges_id` (`fk_charges_id`),
  KEY `fk_user_id` (`fk_user_id`),
  KEY `fk_return_id` (`fk_return_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pickup`
--

CREATE TABLE IF NOT EXISTS `pickup` (
  `pickup_id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `location` varchar(5) NOT NULL,
  `fk_car_id` int(11) NOT NULL,
  PRIMARY KEY (`pickup_id`),
  KEY `fk_car_id` (`fk_car_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reservation`
--

CREATE TABLE IF NOT EXISTS `reservation` (
  `reservation_id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user_id` int(11) NOT NULL,
  `fk_pickup_id` int(11) NOT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `fk_user_id` (`fk_user_id`),
  KEY `fk_pickup_id` (`fk_pickup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `returning`
--

CREATE TABLE IF NOT EXISTS `returning` (
  `return_id` int(11) NOT NULL AUTO_INCREMENT,
  `end_date` date NOT NULL,
  `fk_car_id` int(11) NOT NULL,
  PRIMARY KEY (`return_id`),
  KEY `fk_car_id` (`fk_car_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(55) NOT NULL,
  `last_name` varchar(55) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`fk_charges_id`) REFERENCES `charges` (`charge_id`),
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `invoice_ibfk_3` FOREIGN KEY (`fk_return_id`) REFERENCES `returning` (`return_id`);

--
-- Constraints der Tabelle `pickup`
--
ALTER TABLE `pickup`
  ADD CONSTRAINT `pickup_ibfk_1` FOREIGN KEY (`fk_car_id`) REFERENCES `car` (`car_id`);

--
-- Constraints der Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`fk_pickup_id`) REFERENCES `pickup` (`pickup_id`);

--
-- Constraints der Tabelle `returning`
--
ALTER TABLE `returning`
  ADD CONSTRAINT `returning_ibfk_1` FOREIGN KEY (`fk_car_id`) REFERENCES `car` (`car_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
