-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 30, 2017 at 03:40 PM
-- Server version: 10.0.29-MariaDB-0ubuntu0.16.04.1
-- PHP Version: 7.0.13-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mbottaro`
--

DELIMITER $$
--
-- Procedures
--
CREATE  PROCEDURE `eventistudiatigruppo` (IN `nogr` VARCHAR(40), IN `cigr` VARCHAR(40))  IF nogr='TUTTI' THEN

SELECT gruppo.nome,gruppo.citta,studia.evento,studia.inizio, studia.fine
FROM studia NATURAL JOIN parte NATURAL JOIN gruppo
GROUP BY studia.evento,parte.idgr;

ELSE

SELECT DISTINCT studia.evento, coinvolto.corpo, studia.inizio,studia.fine
FROM studia JOIN parte ON studia.astrofilo=parte.astrofilo JOIN coinvolto ON studia.idstudio=coinvolto.id JOIN gruppo ON gruppo.idgr=parte.idgr
WHERE gruppo.nome=nogr AND gruppo.citta=cigr;
END IF$$

CREATE  PROCEDURE `locrankmin` (IN `minimo` INT)  NO SQL
SELECT nomeloc, provloc,AVG(voto) AS rank
FROM giudica
GROUP BY nomeloc,provloc
HAVING rank>=minimo$$

--
-- Functions
--
CREATE  FUNCTION `migliorgruppo` () RETURNS VARCHAR(83) CHARSET latin1 BEGIN

    DECLARE x varchar(40);
    DECLARE y varchar(40);
    DECLARE z varchar(83);

    SELECT gruppo INTO x
    FROM gruppistudi
    WHERE numero = (SELECT MAX(numero)
                    FROM gruppistudi)
    LIMIT 1;

    SELECT citta INTO y
    FROM gruppistudi
    WHERE numero = (SELECT MAX(numero)
                    FROM gruppistudi)
    LIMIT 1;

    SET z=CONCAT(x,' - ', y);
    RETURN z;

END$$

CREATE  FUNCTION `numstudiastr` (`usr` VARCHAR(20)) RETURNS INT(4) BEGIN
    DECLARE num int;
    SELECT COUNT(username)
    INTO num
    FROM astrofilo JOIN studia
    ON astrofilo.mail=studia.astrofilo
    WHERE username=usr;
    RETURN num;
END$$

CREATE  FUNCTION `primostudio` (`ev` VARCHAR(40), `cor` VARCHAR(40)) RETURNS VARCHAR(40) CHARSET latin1 BEGIN
    DECLARE t DATETIME;
    CREATE TEMPORARY TABLE supp(
        corpo varchar(40),
        evento varchar(40),
        inizio datetime
    );

    INSERT INTO supp(corpo,evento,inizio)
    SELECT coinvolto.corpo,studia.evento,inizio
    FROM coinvolto JOIN studia ON coinvolto.id=studia.idstudio
    ORDER BY inizio ASC;

    SELECT inizio
    INTO t
    FROM supp
    WHERE evento=ev
    AND corpo=cor
    LIMIT 1;
    RETURN t;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `altro`
--

CREATE TABLE `altro` (
  `nome` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `analizzato`
--

CREATE TABLE `analizzato` (
  `telescopio` varchar(20) NOT NULL,
  `corpo` varchar(40) NOT NULL,
  `evento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `analizzato`
--

INSERT INTO `analizzato` (`telescopio`, `corpo`, `evento`) VALUES
('132-ffdxe', 'Giove', 1),
('4f3f3', 'Luna', 5),
('4f3f3', 'Sole', 5);

-- --------------------------------------------------------

--
-- Table structure for table `asteroide`
--

CREATE TABLE `asteroide` (
  `nome` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `astrofilo`
--

CREATE TABLE `astrofilo` (
  `mail` varchar(40) NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `cognome` varchar(20) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `imgprofilo` mediumblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `astrofilo`
--

INSERT INTO `astrofilo` (`mail`, `nome`, `cognome`, `username`, `password`, `imgprofilo`) VALUES
('alfmeg@mail.it', 'Alfredo', 'Stobene', 'StAl', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('andr@mag.com', 'Andrea', 'Magnan', 'Scramasax447', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('astrosam@mail.com', 'Samantha', 'Cristoforetti', 'astrosamantha', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('fabe@gmail.com', 'Fabrizio', 'Italiano', 'fabrio', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('gigione@gigio.it', 'Luigi', 'Datome', 'gigigante', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('giova@gmail.com', 'Giovanni', 'Verde', 'greengiò', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('kobe@mail.com', 'Kobe', 'Bryant', 'Mamba24', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('lucver@mail.com', 'Luca', 'Verdi', 'VerdLu', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('luigibianchi@mail.com', 'Luigi', 'Bianchi', 'gigiTHEwhite', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('marrosi@mail.ti', 'Mario', 'Rossi', 'RommA', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('matbo@mail.it', 'Mattia', 'Bottaro', 'MattBott', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('mattslanz@mail.it', 'Matteo', 'Slanzi', 'matnan', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('riccsagg@mail.it', 'Riccardo', 'Saggese', 'Saggg', 'c6820f1a07b1c44badcede218454bd2c', NULL),
('user', 'user', 'user', 'user', 'user', NULL);

--
-- Triggers `astrofilo`
--
DELIMITER $$
CREATE TRIGGER `eliminagruppo` BEFORE DELETE ON `astrofilo` FOR EACH ROW BEGIN

    CREATE TEMPORARY TABLE supdel(
        idgr INT
    );

    INSERT supdel(idgr)
    SELECT parte.idgr
    FROM parte
    WHERE astrofilo=OLD.mail;

    CREATE TEMPORARY TABLE supdel2(         idgr INT
    );

    INSERT supdel2(idgr)
    SELECT supdel.idgr
    FROM supdel JOIN parte ON supdel.idgr=parte.idgr
    GROUP BY supdel.idgr
    HAVING COUNT(*)<2;

    DELETE FROM gruppo
    WHERE idgr IN (SELECT idgr
                   FROM supdel2) ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `avvenimenti`
--

CREATE TABLE `avvenimenti` (
  `idavvenimento` int(11) NOT NULL,
  `tipo` varchar(40) NOT NULL,
  `inizio` datetime NOT NULL,
  `fine` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `avvenimenti`
--

INSERT INTO `avvenimenti` (`idavvenimento`, `tipo`, `inizio`, `fine`) VALUES
(1, 'Eclissi lunare parziale', '2017-08-07 15:48:00', '2017-08-07 20:53:00'),
(2, 'Eclissi lunare totale', '2018-01-31 10:50:00', '2018-01-31 16:10:00'),
(3, 'Eclissi solare parziale', '2018-08-11 09:48:28', '2018-08-11 09:54:08'),
(4, 'Eclissi solare parziale', '2009-12-31 19:20:02', '2009-12-31 19:29:25'),
(5, 'Eclissi solare parziale', '2015-09-28 14:44:01', '2015-09-28 14:53:49'),
(6, 'Eclissi lunare totale', '2019-06-21 05:09:30', '2019-06-21 05:16:11'),
(7, 'Eclissi lunare totale', '2000-01-21 04:38:45', '2000-01-21 04:49:31'),
(8, 'Eclissi lunare totale', '2001-01-09 20:13:46', '2001-01-09 20:29:46'),
(9, 'Eclissi lunare parziale', '2023-10-23 20:08:06', '2023-10-23 20:18:06'),
(10, 'Eclissi lunare parziale', '2010-06-26 08:55:00', '2010-06-26 10:16:00'),
(11, 'Eclissi lunare parziale', '2010-12-21 05:28:00', '2010-12-21 06:32:00'),
(12, 'Eclissi lunare totale', '2022-05-16 01:36:00', '2022-05-16 03:29:00'),
(13, 'Eclissi lunare totale', '2025-03-14 07:01:00', '2025-03-14 07:01:00'),
(14, 'Eclissi lunare totale', '2011-06-15 17:23:00', '2011-06-15 19:23:00'),
(15, 'Eclissi lunare parziale', '2017-01-30 02:26:17', '2017-01-30 03:00:00'),
(16, 'Eclissi lunare parziale', '2017-04-19 00:00:00', '2017-04-14 01:09:16'),
(17, 'Eclissi solare totale', '2017-08-01 11:00:00', '2017-08-01 11:30:00'),
(18, 'Osservazione', '2016-11-15 02:00:00', '2016-11-15 02:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `coinvolto`
--

CREATE TABLE `coinvolto` (
  `id` int(11) NOT NULL,
  `corpo` varchar(40) NOT NULL,
  `evento` varchar(40) NOT NULL,
  `magnitudo` int(11) DEFAULT NULL,
  `altezza` decimal(7,4) DEFAULT NULL,
  `azimut` decimal(7,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `coinvolto`
--

INSERT INTO `coinvolto` (`id`, `corpo`, `evento`, `magnitudo`, `altezza`, `azimut`) VALUES
(1, 'Giove', 'Osservazione', 4, '54.2233', '102.0989'),
(2, 'Saturno', 'Osservazione', 3, '45.0000', '45.0000'),
(3, 'Luna', 'Eclissi solare parziale', -2, '43.0000', '89.0000'),
(3, 'Sole', 'Eclissi solare parziale', 16, '44.0200', '89.2516'),
(4, 'Luna', 'Eclissi solare parziale', -2, '43.0000', '89.0000'),
(4, 'Sole', 'Eclissi solare parziale', 16, '44.0200', '89.2516'),
(5, 'Luna', 'Eclissi solare parziale', -2, '45.2431', '120.0389'),
(5, 'Sole', 'Eclissi solare parziale', 20, '43.2431', '110.2754'),
(7, 'Marte', 'Osservazione', 5, '45.0000', '45.0000'),
(8, 'Cassiopea', 'Osservazione', NULL, '12.2100', '70.0000');

-- --------------------------------------------------------

--
-- Table structure for table `cometa`
--

CREATE TABLE `cometa` (
  `nome` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `commentafoto`
--

CREATE TABLE `commentafoto` (
  `idcommento` int(11) NOT NULL,
  `astrofilo` varchar(40) NOT NULL,
  `idfoto` int(11) NOT NULL,
  `commento` text NOT NULL,
  `datainserimento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `commentafoto`
--

INSERT INTO `commentafoto` (`idcommento`, `astrofilo`, `idfoto`, `commento`, `datainserimento`) VALUES
(1, 'matbo@mail.it', 9, 'Bellissima! Che fotocamera hai usato?', '2017-01-14 01:11:10'),
(2, 'marrosi@mail.ti', 9, 'Grazie :) Una reflex', '2017-01-14 09:12:00'),
(4, 'alfmeg@mail.it', 8, 'Vista pure io... stupenda', '2016-12-15 04:19:16'),
(5, 'andr@mag.com', 10, 'Pazzesco! Pure le lune di giove!!', '2017-01-06 00:23:35'),
(8, 'matbo@mail.it', 7, 'E` una foto fantastica!', '2017-01-13 23:51:47'),
(9, 'matbo@mail.it', 10, 'Questa foto e` carina! c\'e` da dirlo...', '2017-01-20 10:45:14'),
(12, 'andr@mag.com', 9, 'siamo cosi` piccoli...', '2017-01-24 16:16:45'),
(13, 'andr@mag.com', 8, 'E` stato un evento imperdibile!!', '2017-01-24 16:17:24'),
(14, 'andr@mag.com', 7, 'Ci dovro` andare.', '2017-01-24 16:17:44'),
(19, 'user', 10, '&egrave; bellissima!!', '2017-01-30 11:40:50'),
(22, 'mattslanz@mail.it', 10, 'Che ottica hai usato per fare questa foto?', '2017-01-30 12:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `commentastudio`
--

CREATE TABLE `commentastudio` (
  `id` int(11) NOT NULL,
  `astrofilo` varchar(40) NOT NULL,
  `commento` text NOT NULL,
  `studio` int(11) NOT NULL,
  `datainserimento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `commentastudio`
--

INSERT INTO `commentastudio` (`id`, `astrofilo`, `commento`, `studio`, `datainserimento`) VALUES
(1, 'kobe@mail.com', 'Bello, grazie a voi imparo sempre qualcosa. Vi auguro tante belle osservazioni!', 1, '2017-01-14 15:04:09'),
(2, 'gigione@gigio.it', 'Nelle mie zone il tempo ultimamente e` perfetto e io ne sto approfittando. Passo le nottate a fare studi e a scrutare il cielo ;)', 1, '2017-01-14 16:00:00'),
(3, 'fabe@gmail.com', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at elit bibendum, semper felis a, rutrum augue. Mauris at ante tellus. Quisque in sem pulvinar, condimentum nulla fringilla, porttitor purus. Aenean mollis sem quis consectetur suscipit. Nulla non tortor sed urna vestibulum posuere in a lorem. Pellentesque nulla quam, sagittis vitae imperdiet vitae, vehicula a ex. Sed vel nibh nec metus accumsan varius. Suspendisse congue eleifend diam, a pharetra lorem facilisis in. Morbi volutpat ac tortor ac tempor. Quisque eget dolor quam. Quisque et tortor eu purus vehicula mattis sed eget quam. Aliquam viverra lorem nec orci gravida, ut dictum mi imperdiet. Curabitur lorem lectus, ullamcorper et mattis ultricies, consectetur at felis. ', 5, '2016-12-29 08:09:40'),
(4, 'luigibianchi@mail.com', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at elit bibendum, semper felis a, rutrum augue. Mauris at ante tellus. Quisque in sem pulvinar, condimentum nulla fringilla, porttitor purus. Aenean mollis sem quis consectetur suscipit. Nulla non tortor sed urna vestibulum posuere in a lorem. Pellentesque nulla quam, sagittis vitae imperdiet vitae, vehicula a ex. Sed vel nibh nec metus accumsan varius. Suspendisse congue eleifend diam, a pharetra lorem facilisis in. Morbi volutpat ac tortor ac tempor. Quisque eget dolor quam. Quisque et tortor eu purus vehicula mattis sed eget quam. Aliquam viverra lorem nec orci gravida, ut dictum mi imperdiet. Curabitur lorem lectus, ullamcorper et mattis ultricies, consectetur at felis. ', 5, '2016-12-29 00:00:16'),
(36, 'lucver@mail.com', 'Non finiva mai!', 3, '2017-01-13 20:40:57'),
(37, 'kobe@mail.com', 'La osservo molto spesso...sar&agrave; perche` la uso per trovare la stella polare', 8, '2017-01-14 00:02:13'),
(38, 'kobe@mail.com', 'Se mi avessere dato un centesimo per tutte le volte che mi son messo ad osservarlo al telescopio ...', 2, '2017-01-14 00:04:53'),
(39, 'kobe@mail.com', 'Me la ricordo, pazzesca!!!', 3, '2017-01-14 00:05:14'),
(40, 'kobe@mail.com', 'andare su marte sarebbe un sogno', 7, '2017-01-14 00:07:11'),
(43, 'andr@mag.com', 'Un giorno, chissa`...', 7, '2017-01-24 16:18:11'),
(44, 'andr@mag.com', 'Ne ho viste di piu` entusiasmanti', 4, '2017-01-24 16:18:53'),
(45, 'andr@mag.com', 'La ricordo...bella', 3, '2017-01-24 16:19:12'),
(47, 'andr@mag.com', 'Non lo sapevo, molto interessante!', 8, '2017-01-30 13:37:16'),
(48, 'andr@mag.com', 'Stupendo!', 2, '2017-01-30 13:41:10');

-- --------------------------------------------------------

--
-- Table structure for table `corpo`
--

CREATE TABLE `corpo` (
  `nome` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `corpo`
--

INSERT INTO `corpo` (`nome`) VALUES
('Cassiopea'),
('Giove'),
('Luna'),
('Marte'),
('NESSUNA COSTELLAZIONE'),
('Saturno'),
('Sole');

--
-- Triggers `corpo`
--
DELIMITER $$
CREATE TRIGGER `eliminaeventodacorpo` BEFORE DELETE ON `corpo` FOR EACH ROW BEGIN
    DECLARE c varchar(40);
    SET c=OLD.nome;

    CREATE TEMPORARY TABLE supp(
        ID INT
    );

    INSERT supp(ID)
    SELECT id
    FROM coinvolto
    WHERE corpo=c;

    DELETE FROM coinvolto
    WHERE id IN (SELECT ID
                 FROM supp);

    DELETE FROM analizzato
    WHERE evento IN (
                     SELECT ID
                 FROM supp);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `costellazione`
--

CREATE TABLE `costellazione` (
  `nome` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `costellazione`
--

INSERT INTO `costellazione` (`nome`) VALUES
('Cassiopea'),
('NESSUNA COSTELLAZIONE');

-- --------------------------------------------------------

--
-- Stand-in structure for view `counteveastr`
--
CREATE TABLE `counteveastr` (
`astrofilo` varchar(20)
,`evento` varchar(40)
,`num` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `eveastr`
--
CREATE TABLE `eveastr` (
`astrofilo` varchar(20)
,`evento` varchar(40)
);

-- --------------------------------------------------------

--
-- Table structure for table `evento`
--

CREATE TABLE `evento` (
  `nome` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `evento`
--

INSERT INTO `evento` (`nome`) VALUES
('Eclissi lunare parziale'),
('Eclissi lunare totale'),
('Eclissi solare parziale'),
('Eclissi solare totale'),
('Osservazione'),
('Transito');

-- --------------------------------------------------------

--
-- Table structure for table `foto`
--

CREATE TABLE `foto` (
  `immagine` varchar(200) NOT NULL,
  `titolo` varchar(120) DEFAULT NULL,
  `idfoto` int(11) NOT NULL,
  `didascalia` text,
  `idstudio` int(11) DEFAULT NULL,
  `idastrofilo` varchar(40) DEFAULT NULL,
  `datainserimento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `foto`
--

INSERT INTO `foto` (`immagine`, `titolo`, `idfoto`, `didascalia`, `idstudio`, `idastrofilo`, `datainserimento`) VALUES
('parti/immagini/patagonia.jpg', 'Cielo della Patagonia', 7, 'Il cielo notturno della Patagonia.', NULL, 'kobe@mail.com', '2015-08-13 11:29:31'),
('parti/immagini/Superluna.jpg', 'Super luna di Novembre 2016', 8, 'La super luna di novembre 2016. Foto scattata dal Monte Gemola, Colli Euganei.', NULL, 'matbo@mail.it', '2016-11-30 09:11:20'),
('parti/immagini/vialattea.jpg', 'La nostra galassia', 9, 'La via lattea.', NULL, 'marrosi@mail.ti', '2016-12-11 10:00:00'),
('parti/immagini/lunagiovevenere.jpeg', 'Che trio!', 10, 'La luna, Venere, Giove con i suoi satelliti.', NULL, 'matbo@mail.it', '2016-12-22 22:25:06');

-- --------------------------------------------------------

--
-- Stand-in structure for view `fotobyrank`
--
CREATE TABLE `fotobyrank` (
`idfoto` int(11)
,`rank` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `galassia`
--

CREATE TABLE `galassia` (
  `nome` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `general_log`
--

CREATE TABLE `general_log` (
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_host` mediumtext NOT NULL,
  `thread_id` bigint(21) UNSIGNED NOT NULL,
  `server_id` int(10) UNSIGNED NOT NULL,
  `command_type` varchar(64) NOT NULL,
  `argument` mediumtext NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='General log';

-- --------------------------------------------------------

--
-- Table structure for table `giudica`
--

CREATE TABLE `giudica` (
  `nomeloc` varchar(40) NOT NULL,
  `provloc` char(2) NOT NULL,
  `astrofilo` varchar(40) NOT NULL,
  `voto` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `giudica`
--

INSERT INTO `giudica` (`nomeloc`, `provloc`, `astrofilo`, `voto`) VALUES
('Lago di Fimon', 'VI', 'alfmeg@mail.it', 5),
('Lago di Fimon', 'VI', 'gigione@gigio.it', 4),
('Lago di Fimon', 'VI', 'marrosi@mail.ti', 1),
('Monte Gemola - Baone', 'PD', 'kobe@mail.com', 5),
('Monte Gemola - Baone', 'PD', 'matbo@mail.it', 4),
('Monte Ricco - Monselice', 'PD', 'alfmeg@mail.it', 1),
('Monte Ricco - Monselice', 'PD', 'gigione@gigio.it', 5),
('Monte Ricco - Monselice', 'PD', 'kobe@mail.com', 4);

--
-- Triggers `giudica`
--
DELIMITER $$
CREATE TRIGGER `ControlloVotoI` BEFORE INSERT ON `giudica` FOR EACH ROW BEGIN
	IF NEW.voto < 1 THEN
		SET NEW.voto = 1;
	ELSEIF NEW.voto > 5 THEN
		SET NEW.voto = 5;
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ControlloVotoU` BEFORE UPDATE ON `giudica` FOR EACH ROW BEGIN
	IF NEW.voto < 1 OR NEW.voto > 5 THEN
		SET NEW.voto = OLD.voto;
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `giudicafoto`
--

CREATE TABLE `giudicafoto` (
  `votante` varchar(40) NOT NULL,
  `idfoto` int(11) NOT NULL,
  `voto` int(11) NOT NULL,
  `datainserimento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `giudicafoto`
--

INSERT INTO `giudicafoto` (`votante`, `idfoto`, `voto`, `datainserimento`) VALUES
('andr@mag.com', 7, 1, '2017-01-24 16:43:27'),
('andr@mag.com', 8, -1, '2017-01-30 13:39:17'),
('andr@mag.com', 9, 1, '2017-01-24 16:22:43'),
('astrosam@mail.com', 9, 1, '0000-00-00 00:00:00'),
('fabe@gmail.com', 10, 1, '2017-01-09 16:11:37'),
('kobe@mail.com', 7, 1, '2017-01-14 00:06:06'),
('kobe@mail.com', 8, 1, '2017-01-14 00:06:17'),
('kobe@mail.com', 9, 1, '2017-01-14 00:06:02'),
('marrosi@mail.ti', 7, 1, '0000-00-00 00:00:00'),
('marrosi@mail.ti', 8, 1, '0000-00-00 00:00:00'),
('matbo@mail.it', 7, 1, '2017-01-13 23:51:24'),
('matbo@mail.it', 8, 1, '2017-01-13 23:50:30'),
('matbo@mail.it', 9, 1, '2017-01-20 10:42:05'),
('matbo@mail.it', 10, 1, '2017-01-20 10:49:13'),
('mattslanz@mail.it', 10, -1, '2017-01-30 12:25:17'),
('user', 10, 1, '2017-01-30 11:31:49');

-- --------------------------------------------------------

--
-- Table structure for table `giudicastudio`
--

CREATE TABLE `giudicastudio` (
  `votante` varchar(40) NOT NULL,
  `studio` int(11) NOT NULL,
  `voto` int(11) NOT NULL,
  `datainserimento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `giudicastudio`
--

INSERT INTO `giudicastudio` (`votante`, `studio`, `voto`, `datainserimento`) VALUES
('andr@mag.com', 2, 1, '2017-01-30 13:41:13'),
('andr@mag.com', 3, 1, '2017-01-24 16:19:01'),
('andr@mag.com', 4, 1, '2017-01-24 16:18:22'),
('andr@mag.com', 8, 1, '2017-01-30 13:37:25'),
('astrosam@mail.com', 1, 1, '0000-00-00 00:00:00'),
('fabe@gmail.com', 1, 1, '0000-00-00 00:00:00'),
('gigione@gigio.it', 1, 1, '2016-12-13 03:00:00'),
('kobe@mail.com', 1, 1, '0000-00-00 00:00:00'),
('kobe@mail.com', 2, 1, '2017-01-14 00:04:25'),
('kobe@mail.com', 5, 1, '2016-12-23 08:46:20'),
('kobe@mail.com', 7, 1, '2017-01-14 00:06:29'),
('matbo@mail.it', 2, 1, '2017-01-13 20:40:04'),
('matbo@mail.it', 3, 1, '2017-01-13 20:40:22'),
('matbo@mail.it', 4, 1, '2017-01-09 15:26:49'),
('matbo@mail.it', 5, 1, '2017-01-24 16:08:36'),
('matbo@mail.it', 7, 1, '2017-01-11 19:13:58'),
('matbo@mail.it', 8, 1, '2017-01-20 10:54:58'),
('mattslanz@mail.it', 5, 1, '2017-01-30 12:27:38');

-- --------------------------------------------------------

--
-- Stand-in structure for view `gruppistudi`
--
CREATE TABLE `gruppistudi` (
`gruppo` varchar(40)
,`citta` varchar(40)
,`numero` decimal(42,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `gruppo`
--

CREATE TABLE `gruppo` (
  `idgr` int(11) NOT NULL,
  `nome` varchar(40) NOT NULL,
  `citta` varchar(40) NOT NULL,
  `prov` char(2) NOT NULL,
  `immagine` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gruppo`
--

INSERT INTO `gruppo` (`idgr`, `nome`, `citta`, `prov`, `immagine`) VALUES
(1, 'Astrofili del Veneto', 'Mestre', 'VE', NULL),
(2, 'Astrofili Veneziani', 'Mestre', 'VE', NULL),
(3, 'GAP - Giovani astrofili di Padova', 'Padova', 'PD', NULL),
(4, 'Astrofili di Vicenza', 'Vicenza', 'VI', NULL),
(5, 'APA - Astrofili Padovani', 'Vigonza', 'PD', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `localita`
--

CREATE TABLE `localita` (
  `nome` varchar(40) NOT NULL,
  `prov` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `localita`
--

INSERT INTO `localita` (`nome`, `prov`) VALUES
('Lago di Fimon', 'VI'),
('Mestre', 'VE'),
('Monte Gemola - Baone', 'PD'),
('Monte Ricco - Monselice', 'PD'),
('Padova', 'PD'),
('Vicenza', 'VI'),
('Vigonza', 'PD');

-- --------------------------------------------------------

--
-- Stand-in structure for view `locoss`
--
CREATE TABLE `locoss` (
`prov` char(2)
,`loc` varchar(40)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `locoss2`
--
CREATE TABLE `locoss2` (
`prov` char(2)
,`tot` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `mediagiudizi`
--
CREATE TABLE `mediagiudizi` (
`astrofilo` varchar(40)
,`media` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `nebulosa`
--

CREATE TABLE `nebulosa` (
  `nome` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `numcor`
--
CREATE TABLE `numcor` (
`ev` varchar(40)
,`ini` datetime
,`fin` datetime
,`studio` int(11)
,`num` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `numstudi`
--
CREATE TABLE `numstudi` (
`astrofilo` varchar(40)
,`gruppo` varchar(40)
,`citta` varchar(40)
,`num` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `numtelescopi`
--
CREATE TABLE `numtelescopi` (
`modello` varchar(20)
,`num` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `parte`
--

CREATE TABLE `parte` (
  `idgr` int(11) NOT NULL,
  `astrofilo` varchar(40) NOT NULL,
  `admin` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parte`
--

INSERT INTO `parte` (`idgr`, `astrofilo`, `admin`) VALUES
(1, 'alfmeg@mail.it', b'1'),
(1, 'astrosam@mail.com', b'0'),
(1, 'fabe@gmail.com', b'0'),
(1, 'kobe@mail.com', b'0'),
(2, 'astrosam@mail.com', b'1'),
(2, 'fabe@gmail.com', b'0'),
(2, 'giova@gmail.com', b'0'),
(3, 'lucver@mail.com', b'0'),
(3, 'matbo@mail.it', b'1'),
(4, 'alfmeg@mail.it', b'0'),
(4, 'gigione@gigio.it', b'1'),
(5, 'alfmeg@mail.it', b'0'),
(5, 'lucver@mail.com', b'0'),
(5, 'marrosi@mail.ti', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `pianeta`
--

CREATE TABLE `pianeta` (
  `nome` varchar(40) NOT NULL,
  `stella` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pianeta`
--

INSERT INTO `pianeta` (`nome`, `stella`) VALUES
('Giove', 'Sole'),
('Marte', 'Sole'),
('Saturno', 'Sole');

-- --------------------------------------------------------

--
-- Table structure for table `provincia`
--

CREATE TABLE `provincia` (
  `sigla` char(2) NOT NULL,
  `nome` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `provincia`
--

INSERT INTO `provincia` (`sigla`, `nome`) VALUES
('PD', 'Padova'),
('RO', 'Rovigo'),
('VE', 'Venezia'),
('VI', 'Vicenza');

-- --------------------------------------------------------

--
-- Stand-in structure for view `relazioni`
--
CREATE TABLE `relazioni` (
`astro1` varchar(40)
,`astro2` varchar(40)
);

-- --------------------------------------------------------

--
-- Table structure for table `satellite`
--

CREATE TABLE `satellite` (
  `nome` varchar(40) NOT NULL,
  `pianeta` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `satellite`
--

INSERT INTO `satellite` (`nome`, `pianeta`) VALUES
('Luna', 'Terra');

-- --------------------------------------------------------

--
-- Table structure for table `slow_log`
--

CREATE TABLE `slow_log` (
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_host` mediumtext NOT NULL,
  `query_time` time NOT NULL,
  `lock_time` time NOT NULL,
  `rows_sent` int(11) NOT NULL,
  `rows_examined` int(11) NOT NULL,
  `db` varchar(512) NOT NULL,
  `last_insert_id` int(11) NOT NULL,
  `insert_id` int(11) NOT NULL,
  `server_id` int(10) UNSIGNED NOT NULL,
  `sql_text` mediumtext NOT NULL,
  `thread_id` bigint(21) UNSIGNED NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='Slow log';

-- --------------------------------------------------------

--
-- Stand-in structure for view `sommagiudizi`
--
CREATE TABLE `sommagiudizi` (
`astrofilo` varchar(40)
,`tot` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `stella`
--

CREATE TABLE `stella` (
  `nome` varchar(40) NOT NULL,
  `costellazione` varchar(40) DEFAULT 'NESSUNA COSTELLAZIONE'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stella`
--

INSERT INTO `stella` (`nome`, `costellazione`) VALUES
('Sole', 'NESSUNA COSTELLAZIONE');

-- --------------------------------------------------------

--
-- Table structure for table `studia`
--

CREATE TABLE `studia` (
  `idstudio` int(11) NOT NULL,
  `astrofilo` varchar(40) NOT NULL,
  `titolo` varchar(120) DEFAULT NULL,
  `evento` varchar(40) NOT NULL,
  `appunti` varchar(10000) DEFAULT NULL,
  `inizio` datetime NOT NULL,
  `fine` datetime NOT NULL,
  `datainserimento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `studia`
--

INSERT INTO `studia` (`idstudio`, `astrofilo`, `titolo`, `evento`, `appunti`, `inizio`, `fine`, `datainserimento`) VALUES
(1, 'gigione@gigio.it', 'Giove e la sua macchia', 'Osservazione', 'Sto osservando Giove. Rispetto all\'anno scorso, pare che la grande macchia rossa si sia rimpicciolita leggermente. &amp;eacute il quinto pianeta del sistema solare in ordine di distanza dal Sole ed il pi&amp;uacute grande di tutto il sistema planetario: la sua massa corrisponde a 2,468 volte la somma di quelle di tutti gli altri pianeti messi insieme. &amp;Eacute; classificato, al pari di Saturno, Urano e Nettuno, come gigante gassoso. Giove ha una composizione simile a quella del Sole: infatti &amp;eacute costituito principalmente da idrogeno ed elio con piccole quantit&amp;aacute di altri composti, quali ammoniaca, metano ed acqua. Si ritiene che il pianeta possegga una struttura pluristratificata, con un nucleo solido, presumibilmente di natura rocciosa e costituito da carbonio e silicati di ferro, sopra il quale gravano un mantello di idrogeno metallico ed una vasta copertura atmosferica che esercitano su di esso altissime pressioni.', '2015-08-04 22:32:00', '2015-08-04 22:38:11', '2015-08-13 11:30:00'),
(2, 'gigione@gigio.it', 'Ammirando saturno', 'Osservazione', 'Saturno e` il sesto pianeta del Sistema solare in ordine di distanza dal Sole ed il secondo pianeta pi&uacute; massiccio dopo Giove. Saturno, con Giove, Urano e Nettuno, &eacute; classificato come gigante gassoso, con un raggio medio 9,5 volte quello della Terra e una massa 95 volte superiore a quella terrestre. Il nome deriva dall\'omonimo dio della mitologia romana, omologo del titano greco Crono. Il suo simbolo astronomico &eacute; una rappresentazione stilizzata della falce del dio dell\'agricoltura e dello scorrere del tempo (in greco, Kronos).\n\nSaturno &eacute; composto per il 95% da idrogeno e per il 3% da elio a cui seguono gli altri elementi. Il nucleo, consistente in silicati e ghiacci, &eacute; circondato da uno spesso strato di idrogeno metallico e quindi di uno strato esterno gassoso.\n\nI venti nell\'atmosfera di Saturno possono raggiungere i 1800 km/h, risultando significativamente pi&uacute; veloci di quelli su Giove e leggermente meno veloci di quelli che spirano nell\'atmosfera di Nettuno.\n\nSaturno ha un esteso e vistoso sistema di anelli che consiste principalmente in particelle di ghiacci e polveri di silicati. Della sessantina di lune conosciute che orbitano intorno al pianeta, Titano &eacute; la maggiore e l\'unica luna del sistema solare ad avere un\'atmosfera significativa.\n\n\n', '2015-08-12 20:32:00', '2015-08-12 21:15:47', '2015-08-13 11:29:00'),
(3, 'lucver@mail.com', 'Eclissi del luglio 2009, la pi&uacute; lunga di sempre.', 'Eclissi solare parziale', 'Ancora una volta il Sole si &eacute; spento per una manciata di minuti lungo una fascia che ha attraversato parte dell\'Asia sud-orientale, una delle aree pi&uacute; popolose della terra. La luna, interpostasi tra la Terra e il Sole, ha oscurato la luce di quest\'ultimo per un tratto lungo circa 10.000 chilometri. Lungo questo percorso il Sole &eacute; stato via via oscurato per tempi sempre pi&uacute; lunghi per arrivare ad una duranta massima di totale buio di 6 minuti e 39 secondi. &Eacute; l\'eclissi pi&uacute; lunga del secolo. Ci&oacute; &eacute; conseguenza del fatto che il Sole si trova a meno di 3 settimane dall\'afelio (il punto pi&uacute; distante tra la Terra e il Sole) e quindi ha le dimensioni pi&uacute; piccole dell\'intero anno, mentre la Luna &eacute; abbastanza vicina al perigeo (il punto di minore distanza dalla Terra) e quindi ha le maggiori dimensioni apparenti. ', '2009-07-22 19:20:02', '2009-07-22 19:29:25', '2015-09-11 00:00:00'),
(4, 'lucver@mail.com', 'Eclissi del marzo 2015', 'Eclissi solare parziale', 'L\'eclissi solare del 20 marzo 2015, conosciuta anche come eclissi solare dell\'equinozio 2015, &eacute; un evento astronomico che ha avuto luogo il suddetto giorno dalle 7:40 alle 11:50, con il massimo intorno alle ore 9:46.  Questa &eacute; la nona eclissi totale del ventunesimo secolo e complessivamente l\'undicesimo passaggio dell\'ombra della Luna sulla Terra (in questo secolo).  La precedente eclissi solare visibile in Europa fu quella dell\'11 agosto 1999, mentre la prossima avverr&aacute; il 21 agosto 2017.', '2015-03-20 07:40:01', '2015-03-20 11:50:49', '2015-09-29 00:00:00'),
(5, 'matbo@mail.it', 'Eclissi Solare di Settembre 2015', 'Eclissi solare parziale', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at elit bibendum, semper felis a, rutrum augue. Mauris at ante tellus. Quisque in sem pulvinar, condimentum nulla fringilla, porttitor purus. Aenean mollis sem quis consectetur suscipit. Nulla non tortor sed urna vestibulum posuere in a lorem. Pellentesque nulla quam, sagittis vitae imperdiet vitae, vehicula a ex. Sed vel nibh nec metus accumsan varius. Suspendisse congue eleifend diam, a pharetra lorem facilisis in. Morbi volutpat ac tortor ac tempor. Quisque eget dolor quam. Quisque et tortor eu purus vehicula mattis sed eget quam. Aliquam viverra lorem nec orci gravida, ut dictum mi imperdiet. Curabitur lorem lectus, ullamcorper et mattis ultricies, consectetur at felis. ', '2015-09-28 14:43:23', '2015-09-28 14:52:31', '2015-09-28 20:30:31'),
(7, 'matbo@mail.it', 'Dopo Saturno, ecco Marte!', 'Osservazione', 'Marte &eacute; il quarto pianeta del sistema solare in ordine di distanza dal Sole e l\'ultimo dei pianeti di tipo terrestre dopo Mercurio, Venere e la Terra. Viene chiamato il Pianeta rosso a causa del suo colore caratteristico dovuto alle grandi quantit&aacute; di ossido di ferro che lo ricoprono.\n\nPur presentando un\'atmosfera molto rarefatta e temperature medie superficiali piuttosto basse, il pianeta &eacute; il pi&uacute; simile alla Terra tra quelli del sistema solare. Nonostante le sue dimensioni siano intermedie fra quelle del nostro pianeta e della Luna (il raggio equatoriale &eacute; di 3397 km, circa la met&aacute di quello della Terra e la massa poco pi&uacute; di un decimo), presenta inclinazione dell\'asse di rotazione e durata del giorno simili a quelle terrestri. Inoltre, la sua superficie presenta formazioni vulcaniche, valli, calotte polari e deserti sabbiosi, oltre a formazioni geologiche che suggeriscono la presenza, in un lontano passato, di un\'idrosfera. Tuttavia, la presenza di acqua, anche nel lontano passato, &eacute; stata recentemente messa in discussione a causa della formazione lavica della Valles Marineris. Tra l\'altro, la superficie del pianeta appare fortemente craterizzata a causa della quasi totale assenza di agenti erosivi (soprattutto attivit&aacute; geologica, atmosferica e idrosferica) e dalla totale assenza di tettonica delle placche in grado di formare e poi modellare le strutture tettoniche. Infine, la bassissima densit&aacute; dell\'atmosfera non &eacute; in grado di consumare buona parte delle meteoriti, che quindi raggiungono il suolo con maggior frequenza che non sulla Terra.\n', '2015-08-12 21:23:00', '2015-08-12 21:50:47', '2015-08-12 23:40:00'),
(8, 'matbo@mail.it', 'Cassiopea, cos&iacute; lontana...', 'Osservazione', 'Cassiopea (in latino Cassiopeia) &eacute; una costellazione settentrionale, raffigurante Cassiopea, la leggendaria regina di Etiopia. &Eacute; una delle 88 costellazioni moderne, ed era anche una delle 48 costellazioni elencate da Tolomeo.\n\nDi facile riconoscimento grazie alla sua figura a zig-zag, &eacute; caratteristica specialmente delle notti stellate autunnali, sebbene dall\'emisfero nord sia ben osservabile per quasi tutto l\'anno; &eacute; attraversata dalla Via Lattea ed &eacute; quindi molto ricca di ammassi stellari e fitti campi stellari.\n\nSe osservassimo il Sole da Alfa Centauri, la stella pi&uacute; vicina, esso apparirebbe in Cassiopea.\nCassiopea &eacute; una delle costellazioni pi&uacute; caratteristiche e pi&uacute; riconoscibili del cielo settentrionale. Poich&egrave; &eacute; molto vicina al polo nord celeste, rimane visibile nel cielo per tutta la notte in tutta la fascia temperata dell\'emisfero boreale (una tale costellazione viene detta circumpolare); nell\'emisfero australe &eacute; visibile solo dalle zone tropicali. Rispetto al polo nord celeste, si trova opposta al Grande Carro: nell\'emisfero boreale, quando Cassiopea &eacute; alta nel cielo, il Grande Carro &eacute; basso sull\'orizzonte.', '2016-07-01 00:00:00', '2016-07-01 00:34:00', '2016-07-01 18:43:00');

--
-- Triggers `studia`
--
DELIMITER $$
CREATE TRIGGER `checkdatastudia1` BEFORE INSERT ON `studia` FOR EACH ROW BEGIN
    IF NEW.inizio > NEW.fine THEN
        SET NEW.fine=ADDTIME(NEW.inizio,'0:1:1');
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `checkdatastudia2` BEFORE UPDATE ON `studia` FOR EACH ROW BEGIN
    IF NEW.inizio > NEW.fine THEN
        SET NEW.fine=ADDTIME(NEW.inizio,'0:1:1');
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `telescopio`
--

CREATE TABLE `telescopio` (
  `modello` varchar(20) NOT NULL,
  `marca` varchar(20) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `telescopio`
--

INSERT INTO `telescopio` (`modello`, `marca`, `tipo`) VALUES
('132-ffdxe', 'glasscope', 'Newtoniano'),
('4f3f3', 'watchuniverse', 'Newtoniano');

-- --------------------------------------------------------

--
-- Structure for view `counteveastr`
--
DROP TABLE IF EXISTS `counteveastr`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `counteveastr`  AS  select `eveastr`.`astrofilo` AS `astrofilo`,`eveastr`.`evento` AS `evento`,count(0) AS `num` from `eveastr` group by `eveastr`.`astrofilo`,`eveastr`.`evento` ;

-- --------------------------------------------------------

--
-- Structure for view `eveastr`
--
DROP TABLE IF EXISTS `eveastr`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `eveastr`  AS  select `astrofilo`.`username` AS `astrofilo`,`studia`.`evento` AS `evento` from (`studia` join `astrofilo` on((`studia`.`astrofilo` = `astrofilo`.`mail`))) group by `studia`.`astrofilo`,`studia`.`evento`,`studia`.`inizio`,`studia`.`fine` ;

-- --------------------------------------------------------

--
-- Structure for view `fotobyrank`
--
DROP TABLE IF EXISTS `fotobyrank`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `fotobyrank`  AS  select `giudicafoto`.`idfoto` AS `idfoto`,avg(`giudicafoto`.`voto`) AS `rank` from `giudicafoto` group by `giudicafoto`.`idfoto` order by avg(`giudicafoto`.`voto`) desc ;

-- --------------------------------------------------------

--
-- Structure for view `gruppistudi`
--
DROP TABLE IF EXISTS `gruppistudi`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `gruppistudi`  AS  select `numstudi`.`gruppo` AS `gruppo`,`numstudi`.`citta` AS `citta`,sum(`numstudi`.`num`) AS `numero` from `numstudi` group by `numstudi`.`gruppo`,`numstudi`.`citta` ;

-- --------------------------------------------------------

--
-- Structure for view `locoss`
--
DROP TABLE IF EXISTS `locoss`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `locoss`  AS  select distinct `giudica`.`provloc` AS `prov`,`giudica`.`nomeloc` AS `loc` from (`giudica` left join `localita` on((`localita`.`nome` = `giudica`.`nomeloc`))) where (`localita`.`prov` = `giudica`.`provloc`) ;

-- --------------------------------------------------------

--
-- Structure for view `locoss2`
--
DROP TABLE IF EXISTS `locoss2`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `locoss2`  AS  select `locoss`.`prov` AS `prov`,count(0) AS `tot` from `locoss` group by `locoss`.`prov` ;

-- --------------------------------------------------------

--
-- Structure for view `mediagiudizi`
--
DROP TABLE IF EXISTS `mediagiudizi`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `mediagiudizi`  AS  select `giudica`.`astrofilo` AS `astrofilo`,avg(`giudica`.`voto`) AS `media` from `giudica` group by `giudica`.`astrofilo` ;

-- --------------------------------------------------------

--
-- Structure for view `numcor`
--
DROP TABLE IF EXISTS `numcor`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `numcor`  AS  select `coinvolto`.`evento` AS `ev`,`studia`.`inizio` AS `ini`,`studia`.`fine` AS `fin`,`studia`.`idstudio` AS `studio`,count(0) AS `num` from (`coinvolto` join `studia` on((`coinvolto`.`id` = `studia`.`idstudio`))) group by `coinvolto`.`evento`,`studia`.`inizio`,`studia`.`fine` ;

-- --------------------------------------------------------

--
-- Structure for view `numstudi`
--
DROP TABLE IF EXISTS `numstudi`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `numstudi`  AS  select `studia`.`astrofilo` AS `astrofilo`,`gruppo`.`nome` AS `gruppo`,`gruppo`.`citta` AS `citta`,count(0) AS `num` from ((`studia` join `parte` on((`studia`.`astrofilo` = `parte`.`astrofilo`))) join `gruppo` on((`parte`.`idgr` = `gruppo`.`idgr`))) group by `studia`.`astrofilo`,`gruppo`.`nome`,`gruppo`.`citta` ;

-- --------------------------------------------------------

--
-- Structure for view `numtelescopi`
--
DROP TABLE IF EXISTS `numtelescopi`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `numtelescopi`  AS  select `analizzato`.`telescopio` AS `modello`,count(`analizzato`.`telescopio`) AS `num` from `analizzato` group by `analizzato`.`telescopio` ;

-- --------------------------------------------------------

--
-- Structure for view `relazioni`
--
DROP TABLE IF EXISTS `relazioni`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `relazioni`  AS  select `parte`.`astrofilo` AS `astro1`,`p`.`astrofilo` AS `astro2` from (`parte` join `parte` `p` on((`parte`.`idgr` = `p`.`idgr`))) where (`parte`.`astrofilo` <> `p`.`astrofilo`) ;

-- --------------------------------------------------------

--
-- Structure for view `sommagiudizi`
--
DROP TABLE IF EXISTS `sommagiudizi`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `sommagiudizi`  AS  select `giudica`.`astrofilo` AS `astrofilo`,avg(`giudica`.`voto`) AS `tot` from `giudica` group by `giudica`.`astrofilo` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `altro`
--
ALTER TABLE `altro`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `analizzato`
--
ALTER TABLE `analizzato`
  ADD PRIMARY KEY (`telescopio`,`corpo`,`evento`),
  ADD KEY `corpo` (`telescopio`),
  ADD KEY `evento` (`telescopio`),
  ADD KEY `analizzato_ibfk_2` (`corpo`),
  ADD KEY `analizzato_ibfk_3` (`evento`);

--
-- Indexes for table `asteroide`
--
ALTER TABLE `asteroide`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `astrofilo`
--
ALTER TABLE `astrofilo`
  ADD PRIMARY KEY (`mail`);

--
-- Indexes for table `avvenimenti`
--
ALTER TABLE `avvenimenti`
  ADD PRIMARY KEY (`idavvenimento`),
  ADD KEY `tipo` (`tipo`);

--
-- Indexes for table `coinvolto`
--
ALTER TABLE `coinvolto`
  ADD PRIMARY KEY (`id`,`corpo`),
  ADD KEY `evento` (`evento`),
  ADD KEY `coinvolto_ibfk_1` (`corpo`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `cometa`
--
ALTER TABLE `cometa`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `commentafoto`
--
ALTER TABLE `commentafoto`
  ADD PRIMARY KEY (`idcommento`),
  ADD KEY `astrofilo` (`astrofilo`,`idfoto`),
  ADD KEY `idfoto` (`idfoto`);

--
-- Indexes for table `commentastudio`
--
ALTER TABLE `commentastudio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `astrofilo` (`astrofilo`),
  ADD KEY `studio` (`studio`);

--
-- Indexes for table `corpo`
--
ALTER TABLE `corpo`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `costellazione`
--
ALTER TABLE `costellazione`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `foto`
--
ALTER TABLE `foto`
  ADD PRIMARY KEY (`idfoto`),
  ADD KEY `idstudio` (`idstudio`),
  ADD KEY `idastrofilo` (`idastrofilo`);

--
-- Indexes for table `galassia`
--
ALTER TABLE `galassia`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `giudica`
--
ALTER TABLE `giudica`
  ADD PRIMARY KEY (`nomeloc`,`provloc`,`astrofilo`),
  ADD KEY `astrofilo` (`astrofilo`);

--
-- Indexes for table `giudicafoto`
--
ALTER TABLE `giudicafoto`
  ADD PRIMARY KEY (`votante`,`idfoto`),
  ADD KEY `votante` (`votante`,`idfoto`),
  ADD KEY `idfoto` (`idfoto`);

--
-- Indexes for table `giudicastudio`
--
ALTER TABLE `giudicastudio`
  ADD PRIMARY KEY (`votante`,`studio`),
  ADD KEY `studio` (`studio`),
  ADD KEY `votante` (`votante`);

--
-- Indexes for table `gruppo`
--
ALTER TABLE `gruppo`
  ADD PRIMARY KEY (`idgr`,`nome`,`citta`),
  ADD KEY `idgr` (`idgr`),
  ADD KEY `citta` (`citta`,`prov`);

--
-- Indexes for table `localita`
--
ALTER TABLE `localita`
  ADD PRIMARY KEY (`nome`,`prov`),
  ADD KEY `prov` (`prov`);

--
-- Indexes for table `nebulosa`
--
ALTER TABLE `nebulosa`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `parte`
--
ALTER TABLE `parte`
  ADD PRIMARY KEY (`idgr`,`astrofilo`),
  ADD KEY `astrofilo` (`astrofilo`);

--
-- Indexes for table `pianeta`
--
ALTER TABLE `pianeta`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `provincia`
--
ALTER TABLE `provincia`
  ADD PRIMARY KEY (`sigla`);

--
-- Indexes for table `satellite`
--
ALTER TABLE `satellite`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `stella`
--
ALTER TABLE `stella`
  ADD PRIMARY KEY (`nome`),
  ADD KEY `costellazione` (`costellazione`);

--
-- Indexes for table `studia`
--
ALTER TABLE `studia`
  ADD PRIMARY KEY (`idstudio`),
  ADD KEY `idstudio` (`idstudio`),
  ADD KEY `studia_ibfk_1` (`astrofilo`),
  ADD KEY `studia_ibfk_2` (`evento`);

--
-- Indexes for table `telescopio`
--
ALTER TABLE `telescopio`
  ADD PRIMARY KEY (`modello`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `avvenimenti`
--
ALTER TABLE `avvenimenti`
  MODIFY `idavvenimento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `commentafoto`
--
ALTER TABLE `commentafoto`
  MODIFY `idcommento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `commentastudio`
--
ALTER TABLE `commentastudio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `foto`
--
ALTER TABLE `foto`
  MODIFY `idfoto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `gruppo`
--
ALTER TABLE `gruppo`
  MODIFY `idgr` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `studia`
--
ALTER TABLE `studia`
  MODIFY `idstudio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `altro`
--
ALTER TABLE `altro`
  ADD CONSTRAINT `altro_ibfk_1` FOREIGN KEY (`nome`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `analizzato`
--
ALTER TABLE `analizzato`
  ADD CONSTRAINT `analizzato_ibfk_1` FOREIGN KEY (`telescopio`) REFERENCES `telescopio` (`modello`) ON UPDATE CASCADE,
  ADD CONSTRAINT `analizzato_ibfk_2` FOREIGN KEY (`corpo`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `analizzato_ibfk_3` FOREIGN KEY (`evento`) REFERENCES `coinvolto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `asteroide`
--
ALTER TABLE `asteroide`
  ADD CONSTRAINT `asteroide_ibfk_1` FOREIGN KEY (`nome`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `avvenimenti`
--
ALTER TABLE `avvenimenti`
  ADD CONSTRAINT `avvenimenti_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `evento` (`nome`);

--
-- Constraints for table `coinvolto`
--
ALTER TABLE `coinvolto`
  ADD CONSTRAINT `coinvolto_ibfk_1` FOREIGN KEY (`corpo`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `coinvolto_ibfk_2` FOREIGN KEY (`evento`) REFERENCES `evento` (`nome`) ON UPDATE CASCADE,
  ADD CONSTRAINT `coinvolto_ibfk_3` FOREIGN KEY (`id`) REFERENCES `studia` (`idstudio`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cometa`
--
ALTER TABLE `cometa`
  ADD CONSTRAINT `cometa_ibfk_1` FOREIGN KEY (`nome`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commentafoto`
--
ALTER TABLE `commentafoto`
  ADD CONSTRAINT `commentafoto_ibfk_1` FOREIGN KEY (`astrofilo`) REFERENCES `astrofilo` (`mail`),
  ADD CONSTRAINT `commentafoto_ibfk_2` FOREIGN KEY (`idfoto`) REFERENCES `foto` (`idfoto`);

--
-- Constraints for table `commentastudio`
--
ALTER TABLE `commentastudio`
  ADD CONSTRAINT `commentastudio_ibfk_1` FOREIGN KEY (`astrofilo`) REFERENCES `astrofilo` (`mail`),
  ADD CONSTRAINT `commentastudio_ibfk_2` FOREIGN KEY (`studio`) REFERENCES `studia` (`idstudio`);

--
-- Constraints for table `costellazione`
--
ALTER TABLE `costellazione`
  ADD CONSTRAINT `costellazione_ibfk_1` FOREIGN KEY (`nome`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `foto`
--
ALTER TABLE `foto`
  ADD CONSTRAINT `foto_ibfk_1` FOREIGN KEY (`idstudio`) REFERENCES `studia` (`idstudio`),
  ADD CONSTRAINT `foto_ibfk_2` FOREIGN KEY (`idastrofilo`) REFERENCES `astrofilo` (`mail`);

--
-- Constraints for table `galassia`
--
ALTER TABLE `galassia`
  ADD CONSTRAINT `galassia_ibfk_1` FOREIGN KEY (`nome`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `giudica`
--
ALTER TABLE `giudica`
  ADD CONSTRAINT `giudica_ibfk_1` FOREIGN KEY (`nomeloc`,`provloc`) REFERENCES `localita` (`nome`, `prov`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `giudica_ibfk_2` FOREIGN KEY (`astrofilo`) REFERENCES `astrofilo` (`mail`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `giudicafoto`
--
ALTER TABLE `giudicafoto`
  ADD CONSTRAINT `giudicafoto_ibfk_1` FOREIGN KEY (`votante`) REFERENCES `astrofilo` (`mail`),
  ADD CONSTRAINT `giudicafoto_ibfk_2` FOREIGN KEY (`idfoto`) REFERENCES `foto` (`idfoto`);

--
-- Constraints for table `giudicastudio`
--
ALTER TABLE `giudicastudio`
  ADD CONSTRAINT `giudicastudio_ibfk_1` FOREIGN KEY (`studio`) REFERENCES `studia` (`idstudio`),
  ADD CONSTRAINT `giudicastudio_ibfk_2` FOREIGN KEY (`votante`) REFERENCES `astrofilo` (`mail`);

--
-- Constraints for table `gruppo`
--
ALTER TABLE `gruppo`
  ADD CONSTRAINT `gruppo_ibfk_1` FOREIGN KEY (`citta`,`prov`) REFERENCES `localita` (`nome`, `prov`);

--
-- Constraints for table `localita`
--
ALTER TABLE `localita`
  ADD CONSTRAINT `localita_ibfk_1` FOREIGN KEY (`prov`) REFERENCES `provincia` (`sigla`);

--
-- Constraints for table `nebulosa`
--
ALTER TABLE `nebulosa`
  ADD CONSTRAINT `nebulosa_ibfk_1` FOREIGN KEY (`nome`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `parte`
--
ALTER TABLE `parte`
  ADD CONSTRAINT `parte_ibfk_1` FOREIGN KEY (`idgr`) REFERENCES `gruppo` (`idgr`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `parte_ibfk_2` FOREIGN KEY (`astrofilo`) REFERENCES `astrofilo` (`mail`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pianeta`
--
ALTER TABLE `pianeta`
  ADD CONSTRAINT `pianeta_ibfk_1` FOREIGN KEY (`nome`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `satellite`
--
ALTER TABLE `satellite`
  ADD CONSTRAINT `satellite_ibfk_1` FOREIGN KEY (`nome`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stella`
--
ALTER TABLE `stella`
  ADD CONSTRAINT `stella_ibfk_1` FOREIGN KEY (`nome`) REFERENCES `corpo` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stella_ibfk_2` FOREIGN KEY (`costellazione`) REFERENCES `costellazione` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `studia`
--
ALTER TABLE `studia`
  ADD CONSTRAINT `studia_ibfk_1` FOREIGN KEY (`astrofilo`) REFERENCES `astrofilo` (`mail`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `studia_ibfk_2` FOREIGN KEY (`evento`) REFERENCES `evento` (`nome`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
