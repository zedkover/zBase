-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 10 avr. 2022 à 15:28
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `zbase`
--

-- --------------------------------------------------------

--
-- Structure de la table `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_ambulance', 'Pillbox Hill Medical Center', 1),
('society_barber', 'Herr Kutz', 1),
('society_burgershot', 'BurgerShot', 1),
('society_lscustom', 'LS Customs', 1),
('society_police', 'Los Santos Police Department', 1),
('society_realestateagent', 'Dynasty 8', 1),
('society_restaurant', 'Irish Pub', 1),
('society_tattoo', 'Blazing Tattoo', 1),
('society_unicorn', 'Unicorn', 1);

-- --------------------------------------------------------

--
-- Structure de la table `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(1, 'society_ambulance', 0, NULL),
(2, 'society_barber', 0, NULL),
(3, 'society_burgershot', 0, NULL),
(4, 'society_lscustom', 0, NULL),
(5, 'society_police', 0, NULL),
(6, 'society_realestateagent', 0, NULL),
(7, 'society_restaurant', 0, NULL),
(8, 'society_tattoo', 0, NULL),
(9, 'society_unicorn', 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_ambulance', 'Pillbox Hill Medical Center', 1),
('society_barber', 'Herr Kutz', 1),
('society_burgershot', 'BurgerShot', 1),
('society_lscustom', 'LS Customs', 1),
('society_police', 'Los Santos Police Department', 1),
('society_realestateagent', 'Dynasty 8', 1),
('society_restaurant', 'Irish Pub', 1),
('society_tattoo', 'Blazing Tattoo', 1),
('society_unicorn', 'Unicorn', 1);

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `baninfo`
--

CREATE TABLE `baninfo` (
  `id` int(11) NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `playername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `Token` longtext COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `blacklist`
--

CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL,
  `Steam` varchar(255) CHARACTER SET latin1 NOT NULL,
  `SteamLink` text CHARACTER SET latin1 DEFAULT NULL,
  `SteamName` text CHARACTER SET latin1 DEFAULT NULL,
  `DiscordUID` text CHARACTER SET latin1 DEFAULT NULL,
  `DiscordTag` text CHARACTER SET latin1 DEFAULT NULL,
  `GameLicense` text CHARACTER SET latin1 DEFAULT NULL,
  `ip` text CHARACTER SET latin1 DEFAULT NULL,
  `xbl` text CHARACTER SET latin1 DEFAULT NULL,
  `live` text CHARACTER SET latin1 DEFAULT NULL,
  `BanType` text CHARACTER SET latin1 DEFAULT NULL,
  `Other` text CHARACTER SET latin1 DEFAULT NULL,
  `Date` text CHARACTER SET latin1 DEFAULT NULL,
  `Banner` text CHARACTER SET latin1 DEFAULT NULL,
  `Token` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `blacklist`
--

INSERT INTO `blacklist` (`id`, `Steam`, `SteamLink`, `SteamName`, `DiscordUID`, `DiscordTag`, `GameLicense`, `ip`, `xbl`, `live`, `BanType`, `Other`, `Date`, `Banner`, `Token`) VALUES
(1, 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', '[\"4:400423cff244c62ba608afcd\",\"4:a602bf2a8924fb0a0aa2bbf8\",\"1:88ac322ede187a4e5a3e\",\"4:52caf4d1cbf74644027a\",\"4:977779c330b6e2d1\",\"4:c7c9b5edb0496\",\"3:5cdbfecf14603956222deae\",\"4:d9a5db096cb4cb8e\",\"4:9f81247074b53bce190eb\"]');

-- --------------------------------------------------------

--
-- Structure de la table `burgershotcom`
--

CREATE TABLE `burgershotcom` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `burger` varchar(255) DEFAULT NULL,
  `boisson` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `datastore`
--

CREATE TABLE `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_ambulance', 'Pillbox Hill Medical Center', 1),
('society_barber', 'Herr Kutz', 1),
('society_burgershot', 'BurgerShot', 1),
('society_lscustom', 'LS Customs', 1),
('society_police', 'Los Santos Police Department', 1),
('society_realestateagent', 'Dynasty 8', 1),
('society_restaurant', 'Irish Pub', 1),
('society_tattoo', 'Blazing Tattoo', 1),
('society_unicorn', 'Unicorn', 1);

-- --------------------------------------------------------

--
-- Structure de la table `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `owner` varchar(40) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `datastore_data`
--

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(1, 'society_ambulance', NULL, '{}'),
(2, 'society_barber', NULL, '{}'),
(3, 'society_burgershot', NULL, '{}'),
(4, 'society_lscustom', NULL, '{}'),
(5, 'society_police', NULL, '{}'),
(6, 'society_realestateagent', NULL, '{}'),
(7, 'society_restaurant', NULL, '{}'),
(8, 'society_tattoo', NULL, '{}'),
(9, 'society_unicorn', NULL, '{}');

-- --------------------------------------------------------

--
-- Structure de la table `data_inventory`
--

CREATE TABLE `data_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `limit` int(11) NOT NULL DEFAULT 10,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `label`, `weight`, `limit`, `rare`, `can_remove`) VALUES
('ammo_pistol', '.45', 1, -1, 0, 1),
('ammo_rifle', '5.56mm', 1, -1, 0, 1),
('ammo_rpg', 'Roquettes', 1, -1, 0, 1),
('ammo_shotgun', 'Calibre 12', 1, -1, 0, 1),
('ammo_smg', '9mm', 1, -1, 0, 1),
('ammo_smg_large', '28mm', 1, -1, 0, 1),
('ammo_snp', '300 Magnum', 1, -1, 0, 1),
('bandage', 'Bandage', 1, 10, 0, 1),
('biere', 'Bière', 1, 2, 0, 1),
('bmx', 'Bmx', 1, -1, 0, 1),
('bread', 'Pain', 1, 5, 0, 1),
('cabillaud', 'Cabillaud', 20, 20, 0, 1),
('calvados', 'Calvados', 1, 2, 0, 1),
('canneapeche', 'Canne à Pêche', 2, 2, 0, 1),
('carpe', 'Carpe', 20, 20, 0, 1),
('cartebancaire', 'Carte Bancaire', 1, 2, 0, 1),
('chanvre', 'Chanvre', 1, 10, 0, 1),
('cheeseburger', 'Cheeseburger', 1, 2, 0, 1),
('chickenburger', 'Chicken burger', 1, 50, 0, 1),
('chocolat', 'Chocolat', 1, 10, 0, 1),
('coke', 'Figurine Super Hero', 1, 10, 0, 1),
('cokebrut', 'Cocaïne', 1, 10, 0, 1),
('cornichon', 'Cornichon', 1, 50, 0, 1),
('crystaldemeth', 'Crystal de meth', 1, 10, 0, 1),
('cut_money', 'Argent couper', 1, 10, 0, 1),
('ecoca', 'eCola', 1, 2, 0, 1),
('feuilledecoca', 'Coca', 1, 10, 0, 1),
('fishburger', 'Fish burger', 1, 50, 0, 1),
('fixter', 'Fixter', 1, -1, 0, 1),
('fromage', 'Fromage', 1, 50, 0, 1),
('gin', 'Gin', 1, 2, 0, 1),
('gps', 'GPS', -1, 1, 0, 1),
('graineweed', 'Graîne de cannabis', 1, 10, 0, 1),
('hamburger', 'Hamburger', 1, 50, 0, 1),
('hotdog', 'Hot-dog', 1, 2, 0, 1),
('lockpick', 'Outil de crochetage', 1, 2, 0, 1),
('medikit', 'Kit de Soin', 1, 10, 0, 1),
('meth', 'Méthamphétamine', 1, 10, 0, 1),
('meth_raw', 'Meth brute', 1, 10, 0, 1),
('moteur', 'Moteur', 1, 2, 0, 1),
('paracetamol', 'Paracetamol', 1, 10, 0, 1),
('phone', 'Téléphone', 1, 10, 0, 1),
('pneu', 'Pneu', 1, 2, 0, 1),
('poissonpane', 'Poisson pané', 1, 50, 0, 1),
('pouletpane', 'Poulet pané', 1, 50, 0, 1),
('radio', 'Radio', 1, -1, 0, 1),
('sardine', 'Sardine', 20, 20, 0, 1),
('saumon', 'Saumon', 20, 20, 0, 1),
('saumonrose', 'Saumon Rose', 20, 20, 0, 1),
('scorcher', 'Scorcher', 1, -1, 0, 1),
('sorted_money', 'Argent trié', 1, 10, 0, 1),
('sprunk', 'Sprunk', 1, 2, 0, 1),
('steak', 'Steak-Frites', 1, 2, 0, 1),
('tenuecere', 'Tenue Cérémonie', 1, 5, 0, 1),
('tenuecourte', 'Tenue Manche Courte', 1, 5, 0, 1),
('tenuelongue', 'Tenue Manche longue', 1, 5, 0, 1),
('tenuemoto', 'Tenue Moto', 1, 5, 0, 1),
('tenuepilote', 'Tenue Pilote', 1, 5, 0, 1),
('tenuevelo', 'Tenue Vélo', 1, 5, 0, 1),
('tomate', 'Tomate', 1, 50, 0, 1),
('tribike', 'Tribike', 1, -1, 0, 1),
('truite', 'Truite', 20, 20, 0, 1),
('vodka', 'Vodka', 1, 2, 0, 1),
('water', 'Bouteille d\'eau', 1, 5, 0, 1),
('weapon_advancedrifle', 'Fusil avancé', 1, -1, 0, 1),
('weapon_appistol', 'Pistolet Perforant', 1, -1, 0, 1),
('weapon_assaultrifle', 'AK-47', 1, -1, 0, 1),
('weapon_assaultrifle_mk2', 'AK-47 MK2', 1, -1, 0, 1),
('weapon_assaultshotgun', 'UTAS UTS-15', 1, -1, 0, 1),
('weapon_assaultsmg', 'SMG', 1, -1, 0, 1),
('weapon_autoshotgun', 'AA-12', 1, -1, 0, 1),
('weapon_ball', 'ball', 1, -1, 0, 1),
('weapon_bat', 'Batte de Baseball', 1, -1, 0, 1),
('weapon_battleaxe', 'Hache de combat', 1, -1, 0, 1),
('weapon_bottle', 'Bouteille cassé', 1, -1, 0, 1),
('weapon_bullpuprifle_mk2', 'Fusil Bullpup MK2', 1, -1, 0, 1),
('weapon_bullpupshotgun', 'Kel-Tec KSG', 1, -1, 0, 1),
('weapon_carbinerifle', 'Carabine', 1, -1, 0, 1),
('weapon_carbinerifle_mk2', 'Carabine MK2', 1, -1, 0, 1),
('weapon_combatmg', 'mitrailleuse de Combat', 1, -1, 0, 1),
('weapon_combatmg_mk2', 'Mitrailleuse de Combat MK2', 1, -1, 0, 1),
('weapon_combatpdw', 'ADP De Combat', 1, -1, 0, 1),
('weapon_combatpistol', 'Pistolet de Combat', 1, -1, 0, 1),
('weapon_compactrifle', 'Micro Draco AK Pistol', 1, -1, 0, 1),
('weapon_crowbar', 'Pied de biche', 1, -1, 0, 1),
('weapon_dagger', 'Dague', 1, -1, 0, 1),
('weapon_dbshotgun', 'Fusil a double Canon', 1, -1, 0, 1),
('weapon_doubleaction', 'Double-Actino Revolver', 1, -1, 0, 1),
('weapon_fireextinguisher', 'Extincteur', 1, -1, 0, 1),
('weapon_flare', 'Fumigène', 1, -1, 0, 1),
('weapon_golfclub', 'Club de Golf', 1, -1, 0, 1),
('weapon_gusenberg', 'Mitrailleuse Gusenberg', 1, -1, 0, 1),
('weapon_hammer', 'Marteau', 1, -1, 0, 1),
('weapon_hatchet', 'Hachette', 1, -1, 0, 1),
('weapon_heavypistol', 'Pistolet Lourd', 1, -1, 0, 1),
('weapon_heavyshotgun', 'Saiga-12K', 1, -1, 0, 1),
('weapon_knife', 'Couteau', 1, -1, 0, 1),
('weapon_knuckle', 'Poing américain', 1, -1, 0, 1),
('weapon_machete', 'Machette', 1, -1, 0, 1),
('weapon_machinepistol', 'TEC-9', 1, -1, 0, 1),
('weapon_marksmanpistol', 'Pistolet Marksman', 1, -1, 0, 1),
('weapon_marksmanrifle', 'M39 EMR', 1, -1, 0, 1),
('weapon_marksmanrifle_mk2', 'Fusil Marksman MK2', 1, -1, 0, 1),
('weapon_mg', 'Mitrailleuse', 1, -1, 0, 1),
('weapon_microsmg', 'Micro SMG', 1, -1, 0, 1),
('weapon_minismg', 'Skorpion Vz. 61', 1, -1, 0, 1),
('weapon_molotov', 'Cocktail Molotov', 1, -1, 0, 1),
('weapon_nightstick', 'Matraque', 1, -1, 0, 1),
('weapon_parachute', 'Parachute', 1, -1, 0, 1),
('weapon_petrolcan', 'Jerycan', 1, -1, 0, 1),
('weapon_pistol', 'Pistolet', 1, -1, 0, 1),
('weapon_pistol50', 'Pistolet Calibre 50', 1, -1, 0, 1),
('weapon_pistol_mk2', 'Pistolet MK2', 1, -1, 0, 1),
('weapon_poolcue', 'Queue de billard', 1, -1, 0, 1),
('weapon_pumpshotgun', 'Fusil à pompe', 1, -1, 0, 1),
('weapon_pumpshotgun_mk2', 'Fusil à Pompe MK2', 1, -1, 0, 1),
('weapon_revolver', 'Revolver', 1, -1, 0, 1),
('weapon_revolver_mk2', 'Révolver MK2', 1, -1, 0, 1),
('weapon_sawnoffshotgun', 'Mossberg 500', 1, -1, 0, 1),
('weapon_smg', 'SMG', 1, -1, 0, 1),
('weapon_smg_mk2', 'SMG MK2', 1, -1, 0, 1),
('weapon_smokegrenade', 'Grenage lacrymogène', 1, -1, 0, 1),
('weapon_snowball', 'Boule de neige', 1, -1, 0, 1),
('weapon_snspistol', 'Pétoire', 1, -1, 0, 1),
('weapon_snspistol_mk2', 'Pétoire MK2', 1, -1, 0, 1),
('weapon_specialcarbine', 'H&K G36C', 1, -1, 0, 1),
('weapon_specialcarbine_mk2', 'Carabine Spéciale MK2', 1, -1, 0, 1),
('weapon_stungun', 'X26 Taser', 1, -1, 0, 1),
('weapon_switchblade', 'Couteau à cran arrêt', 1, -1, 0, 1),
('weapon_vintagepistol', 'Radar Manuelle LSPD', 1, -1, 0, 1),
('weapon_wrench', 'clef a molette', 1, -1, 0, 1),
('weed', 'Cannabis', 1, 10, 0, 1),
('whisky', 'Whisky', 1, 2, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`) VALUES
('ambulance', 'Pillbox Hill Medical Center'),
('barber', 'Herr Kutz'),
('burgershot', 'BurgerShot'),
('lscustom', 'LS Customs'),
('police', 'Los Santos Police Department'),
('realestateagent', 'Dynasty 8'),
('restaurant', 'Irish Pub'),
('tattoo', 'Blazing Tattoo'),
('unemployed', 'Civil'),
('unicorn', 'Unicorn');

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Chomeur', 50, '{}', '{}'),
(2, 'lscustom', 0, 'recrue', 'Recrue', 0, '{}', '{}'),
(3, 'lscustom', 1, 'novice', 'Novice', 20, '{}', '{}'),
(4, 'lscustom', 2, 'experimente', 'Responsable', 30, '{}', '{}'),
(5, 'lscustom', 3, 'chief', 'Co-Patron', 40, '{}', '{}'),
(6, 'lscustom', 4, 'boss', 'Patron', 50, '{}', '{}'),
(7, 'restaurant', 0, 'recrue', 'Stagiaire', 10, '{}', '{}'),
(8, 'restaurant', 1, 'novice', 'Serveur', 20, '{}', '{}'),
(9, 'restaurant', 2, 'experimente', 'Responsable', 30, '{}', '{}'),
(10, 'restaurant', 3, 'chief', 'Co-Patron', 40, '{}', '{}'),
(11, 'restaurant', 4, 'boss', 'Patron', 50, '{}', '{}'),
(13, 'police', 0, 'stagiaire', 'Stagiaire', 10, '{}', '{}'),
(14, 'police', 1, 'cadet', 'Cadet', 20, '{}', '{}'),
(15, 'police', 2, 'officier', 'Officier', 30, '{}', '{}'),
(16, 'police', 3, 'sergent', 'Sergent', 40, '{}', '{}'),
(17, 'police', 4, 'lieutenant', 'Lieutenant', 50, '{}', '{}'),
(18, 'police', 5, 'boss', 'Capitaine', 60, '{}', '{}'),
(21, 'ambulance', 0, 'stagiaire', 'Stagiaire', 10, '{}', '{}'),
(22, 'ambulance', 1, 'infirmier', 'infirmier', 20, '{}', '{}'),
(23, 'ambulance', 2, 'docteur', 'Docteur', 30, '{}', '{}'),
(24, 'ambulance', 3, 'chief', 'Co-Patron', 40, '{}', '{}'),
(25, 'ambulance', 4, 'boss', 'Patron', 50, '{}', '{}'),
(26, 'tattoo', 0, 'stagiaire', 'Stagiaire', 12, '{}', '{}'),
(27, 'tattoo', 1, 'recrue', 'Recrue', 24, '{}', '{}'),
(28, 'tattoo', 2, 'employe', 'Employé', 24, '{}', '{}'),
(29, 'tattoo', 3, 'boss', 'Patron', 0, '{}', '{}'),
(30, 'barber', 0, 'stagiaire', 'Stagiaire', 12, '{}', '{}'),
(31, 'barber', 1, 'recrue', 'Recrue', 24, '{}', '{}'),
(32, 'barber', 2, 'employe', 'Employé', 24, '{}', '{}'),
(33, 'barber', 3, 'boss', 'Patron', 0, '{}', '{}'),
(34, 'unicorn', 0, 'recrue', 'Stagiaire', 10, '{}', '{}'),
(35, 'unicorn', 1, 'novice', 'Serveur', 20, '{}', '{}'),
(36, 'unicorn', 2, 'experimente', 'Responsable', 30, '{}', '{}'),
(37, 'unicorn', 2, 'chief', 'Co-Patron', 40, '{}', '{}'),
(38, 'unicorn', 4, 'boss', 'Patron', 50, '{}', '{}'),
(39, 'realestateagent', 0, 'recrue', 'Agent Immobilier', 10, '{}', '{}'),
(40, 'burgershot', 0, 'recrue', 'Stagiaire', 10, '{}', '{}'),
(41, 'burgershot', 1, 'novice', 'Serveur', 20, '{}', '{}'),
(42, 'burgershot', 2, 'experimente', 'Responsable', 30, '{}', '{}'),
(43, 'burgershot', 3, 'chief', 'Co-Patron', 40, '{}', '{}'),
(44, 'burgershot', 4, 'boss', 'Patron', 50, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `open_car`
--

CREATE TABLE `open_car` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `got` varchar(50) DEFAULT NULL,
  `NB` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `orga_grades`
--

CREATE TABLE `orga_grades` (
  `id_grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rang` int(11) NOT NULL,
  `id_orga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `orga_grades`
--

INSERT INTO `orga_grades` (`id_grade`, `name`, `rang`, `id_orga`) VALUES
(17, 'Chef', 1, 5),
(18, 'OG', 2, 5),
(19, 'Habitant', 3, 5);

-- --------------------------------------------------------

--
-- Structure de la table `orga_grade_perm`
--

CREATE TABLE `orga_grade_perm` (
  `id_grade_perm` int(11) NOT NULL,
  `recruit` varchar(50) DEFAULT NULL,
  `fire` varchar(50) DEFAULT NULL,
  `attribute_property` varchar(50) DEFAULT NULL,
  `give_access_property` varchar(50) DEFAULT NULL,
  `access_property` varchar(50) DEFAULT NULL,
  `see_chest` varchar(50) DEFAULT NULL,
  `deposit` varchar(50) DEFAULT NULL,
  `remove` varchar(50) DEFAULT NULL,
  `access_garage` varchar(50) DEFAULT NULL,
  `take_car` varchar(50) DEFAULT NULL,
  `park_car` varchar(50) DEFAULT NULL,
  `id_grade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `orga_grade_perm`
--

INSERT INTO `orga_grade_perm` (`id_grade_perm`, `recruit`, `fire`, `attribute_property`, `give_access_property`, `access_property`, `see_chest`, `deposit`, `remove`, `access_garage`, `take_car`, `park_car`, `id_grade`) VALUES
(17, '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', 17),
(18, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 19),
(19, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 18);

-- --------------------------------------------------------

--
-- Structure de la table `orga_liste`
--

CREATE TABLE `orga_liste` (
  `id_orga` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `devise` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `orga_liste`
--

INSERT INTO `orga_liste` (`id_orga`, `name`, `devise`) VALUES
(5, 'Ballas', 'Ballas.');

-- --------------------------------------------------------

--
-- Structure de la table `orga_membres`
--

CREATE TABLE `orga_membres` (
  `id_membre` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `id_grade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `orga_membres`
--

INSERT INTO `orga_membres` (`id_membre`, `identifier`, `label`, `id_grade`) VALUES
(13, 'steam:11000013e993a14', 'Zedkover Youtube', 17);

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(40) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `state` tinyint(4) NOT NULL DEFAULT 0,
  `mod` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `properties_access`
--

CREATE TABLE `properties_access` (
  `id_access` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `id_property` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `properties_list`
--

CREATE TABLE `properties_list` (
  `id_property` int(11) NOT NULL,
  `property_name` varchar(50) NOT NULL,
  `property_pos` varchar(100) DEFAULT NULL,
  `property_chest` varchar(50) DEFAULT NULL,
  `property_type` varchar(50) DEFAULT NULL,
  `property_price` int(11) DEFAULT NULL,
  `property_status` varchar(50) DEFAULT 'free',
  `property_owner` varchar(50) DEFAULT NULL,
  `garage_pos` varchar(100) DEFAULT NULL,
  `garage_max` int(11) DEFAULT NULL,
  `jobs` varchar(50) DEFAULT NULL,
  `orga` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `properties_vehicles`
--

CREATE TABLE `properties_vehicles` (
  `id_vehicle` int(11) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `vehicle_property` longtext DEFAULT NULL,
  `health_engine` int(11) DEFAULT NULL,
  `tire_front_left` tinyint(1) DEFAULT NULL,
  `tire_front_right` tinyint(1) DEFAULT NULL,
  `tire_back_left` tinyint(1) DEFAULT NULL,
  `tire_back_right` tinyint(1) DEFAULT NULL,
  `id_property` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `society_moneywash`
--

CREATE TABLE `society_moneywash` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `trunk_inventory`
--

CREATE TABLE `trunk_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `trunk_inventory`
--

INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
(1, '03RVY097', '{\"coffre\":[]}', 0),
(2, '65YVF301', '{\"coffre\":[]}', 0);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(60) NOT NULL,
  `license` varchar(60) DEFAULT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `position` varchar(255) DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
  `skin` longtext DEFAULT NULL,
  `firstname` varchar(50) DEFAULT '',
  `lastname` varchar(50) DEFAULT '',
  `dateofbirth` varchar(25) DEFAULT '',
  `sex` varchar(10) DEFAULT '',
  `height` varchar(5) DEFAULT '',
  `status` longtext DEFAULT NULL,
  `isDead` bit(1) DEFAULT b'0',
  `licenses` longtext DEFAULT '{"car":false, "motor":false, "heli":false, "boat": false, "heavycar": false, "ppa":false}',
  `phone_number` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`identifier`, `license`, `accounts`, `group`, `inventory`, `job`, `job_grade`, `loadout`, `position`, `skin`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `status`, `isDead`, `licenses`, `phone_number`) VALUES
('steam:11000013e993a14', 'license:e2e8205eb18c6c95344c088d1d9620a7d5ba90fe', '{\"black_money\":0,\"bank\":5000,\"money\":99489690}', 'admin', '{\"radio\":1,\"ammo_smg\":5,\"canneapeche\":1,\"bread\":1,\"weapon_knife\":1,\"weapon_snspistol\":1,\"bmx\":1,\"ammo_pistol\":20}', 'police', 4, '[]', '{\"x\":-1441.9,\"y\":-450.2,\"z\":35.4,\"heading\":221.0}', '{\"cheeks_3\":0.0,\"glasses_2\":0,\"chin_width\":0.0,\"cheeks_2\":0.0,\"eyebrows_1\":0,\"watches_2\":0,\"bracelets_1\":-1,\"hair_color_2\":0,\"bproof_1\":0,\"makeup_2\":0,\"mom\":0.0,\"age_2\":0,\"chin_height\":0.0,\"sun_2\":0,\"chin_hole\":0.0,\"nose_1\":0.0,\"pants_2\":0,\"shoes_2\":0,\"complexion_2\":0,\"hair_2\":0,\"arms\":0,\"watches_1\":-1,\"torso_2\":0,\"nose_4\":0.0,\"lipstick_2\":0,\"chain_2\":0,\"beard_3\":0,\"pants_1\":0,\"bproof_2\":0,\"eyebrows_2\":0,\"sun_1\":0,\"beard_1\":0,\"beard_4\":0,\"jaw_1\":0.0,\"eyebrows_5\":0.0,\"bags_2\":0,\"blemishes_1\":0,\"decals_2\":0,\"blush_1\":0,\"mask_1\":0,\"makeup_4\":0,\"ears_1\":-1,\"moles_2\":0,\"chest_3\":0,\"bracelets_2\":0,\"hair_1\":0,\"eyebrows_4\":0,\"tshirt_2\":0,\"neck_thick\":0.0,\"chin_lenght\":0.0,\"lipstick_1\":0,\"tshirt_1\":0,\"eyebrows_6\":0.0,\"dad\":0.0,\"beard_2\":0,\"nose_6\":0.0,\"chest_2\":0,\"makeup_3\":0,\"helmet_1\":-1,\"age_1\":0,\"lipstick_3\":0,\"torso_1\":0,\"makeup_1\":0,\"blush_3\":0,\"bodyb_2\":0,\"complexion_1\":0,\"nose_3\":0.0,\"nose_2\":0.0,\"eye_open\":0.0,\"bags_1\":0,\"eye_color\":0,\"helmet_2\":0,\"chest_1\":0,\"eyebrows_3\":0,\"ears_2\":0,\"chain_1\":0,\"sex\":0,\"lipstick_4\":0,\"hair_color_1\":0,\"skin\":0,\"mask_2\":0,\"glasses_1\":0,\"cheeks_1\":0.0,\"face\":0,\"decals_1\":0,\"bodyb_1\":0,\"moles_1\":0,\"arms_2\":0,\"lips_thick\":0.0,\"blemishes_2\":0,\"jaw_2\":0.0,\"blush_2\":0,\"nose_5\":0.0,\"shoes_1\":0}', 'John', 'Smith', '12/02/1999', 'm', '181', '[{\"name\":\"hunger\",\"val\":724400,\"percent\":72.44},{\"name\":\"thirst\",\"val\":808075,\"percent\":80.8075},{\"name\":\"drunk\",\"val\":0,\"percent\":0.0}]', b'0', '{\"car\":false, \"motor\":false, \"heli\":false, \"boat\": false, \"heavycar\": false, \"ppa\":false}', '555-3173');

-- --------------------------------------------------------

--
-- Structure de la table `user_accounts`
--

CREATE TABLE `user_accounts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(22) NOT NULL,
  `name` varchar(50) NOT NULL,
  `money` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `zk_clothe`
--

CREATE TABLE `zk_clothe` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `identifier` varchar(40) DEFAULT NULL,
  `nom` longtext DEFAULT NULL,
  `clothe` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  ADD KEY `index_addon_account_data_account_name` (`account_name`);

--
-- Index pour la table `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  ADD KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  ADD KEY `index_addon_inventory_inventory_name` (`inventory_name`);

--
-- Index pour la table `baninfo`
--
ALTER TABLE `baninfo`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `burgershotcom`
--
ALTER TABLE `burgershotcom`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  ADD KEY `index_datastore_data_name` (`name`);

--
-- Index pour la table `data_inventory`
--
ALTER TABLE `data_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate` (`plate`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `open_car`
--
ALTER TABLE `open_car`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `orga_grades`
--
ALTER TABLE `orga_grades`
  ADD PRIMARY KEY (`id_grade`),
  ADD KEY `id_orga` (`id_orga`);

--
-- Index pour la table `orga_grade_perm`
--
ALTER TABLE `orga_grade_perm`
  ADD PRIMARY KEY (`id_grade_perm`),
  ADD KEY `id_grade` (`id_grade`);

--
-- Index pour la table `orga_liste`
--
ALTER TABLE `orga_liste`
  ADD PRIMARY KEY (`id_orga`);

--
-- Index pour la table `orga_membres`
--
ALTER TABLE `orga_membres`
  ADD PRIMARY KEY (`id_membre`),
  ADD KEY `id_grade` (`id_grade`);

--
-- Index pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `properties_access`
--
ALTER TABLE `properties_access`
  ADD PRIMARY KEY (`id_access`),
  ADD KEY `id_property` (`id_property`);

--
-- Index pour la table `properties_list`
--
ALTER TABLE `properties_list`
  ADD PRIMARY KEY (`id_property`),
  ADD UNIQUE KEY `property_name` (`property_name`),
  ADD UNIQUE KEY `property_pos` (`property_pos`),
  ADD UNIQUE KEY `garage_pos` (`garage_pos`),
  ADD KEY `jobs` (`jobs`);

--
-- Index pour la table `properties_vehicles`
--
ALTER TABLE `properties_vehicles`
  ADD PRIMARY KEY (`id_vehicle`),
  ADD KEY `id_property` (`id_property`);

--
-- Index pour la table `society_moneywash`
--
ALTER TABLE `society_moneywash`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate` (`plate`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `user_accounts`
--
ALTER TABLE `user_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `zk_clothe`
--
ALTER TABLE `zk_clothe`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `baninfo`
--
ALTER TABLE `baninfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=711;

--
-- AUTO_INCREMENT pour la table `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT pour la table `burgershotcom`
--
ALTER TABLE `burgershotcom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `data_inventory`
--
ALTER TABLE `data_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT pour la table `open_car`
--
ALTER TABLE `open_car`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `orga_grades`
--
ALTER TABLE `orga_grades`
  MODIFY `id_grade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `orga_grade_perm`
--
ALTER TABLE `orga_grade_perm`
  MODIFY `id_grade_perm` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `orga_liste`
--
ALTER TABLE `orga_liste`
  MODIFY `id_orga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `orga_membres`
--
ALTER TABLE `orga_membres`
  MODIFY `id_membre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `properties_access`
--
ALTER TABLE `properties_access`
  MODIFY `id_access` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `properties_list`
--
ALTER TABLE `properties_list`
  MODIFY `id_property` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `properties_vehicles`
--
ALTER TABLE `properties_vehicles`
  MODIFY `id_vehicle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `society_moneywash`
--
ALTER TABLE `society_moneywash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `user_accounts`
--
ALTER TABLE `user_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `zk_clothe`
--
ALTER TABLE `zk_clothe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `orga_grades`
--
ALTER TABLE `orga_grades`
  ADD CONSTRAINT `orga_grades_ibfk_1` FOREIGN KEY (`id_orga`) REFERENCES `orga_liste` (`id_orga`);

--
-- Contraintes pour la table `orga_grade_perm`
--
ALTER TABLE `orga_grade_perm`
  ADD CONSTRAINT `orga_grade_perm_ibfk_1` FOREIGN KEY (`id_grade`) REFERENCES `orga_grades` (`id_grade`);

--
-- Contraintes pour la table `orga_membres`
--
ALTER TABLE `orga_membres`
  ADD CONSTRAINT `orga_membres_ibfk_1` FOREIGN KEY (`id_grade`) REFERENCES `orga_grades` (`id_grade`);

--
-- Contraintes pour la table `properties_access`
--
ALTER TABLE `properties_access`
  ADD CONSTRAINT `properties_access_ibfk_1` FOREIGN KEY (`id_property`) REFERENCES `properties_list` (`id_property`);

--
-- Contraintes pour la table `properties_vehicles`
--
ALTER TABLE `properties_vehicles`
  ADD CONSTRAINT `properties_vehicles_ibfk_1` FOREIGN KEY (`id_property`) REFERENCES `properties_list` (`id_property`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
