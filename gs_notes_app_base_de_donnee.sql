-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 11 juin 2022 à 20:19
-- Version du serveur :  10.4.18-MariaDB
-- Version de PHP : 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gs_notes_app`
--

-- --------------------------------------------------------

--
-- Structure de la table `cadreadministrateur`
--

CREATE TABLE `cadreadministrateur` (
  `grade` varchar(255) DEFAULT NULL,
  `idCardreAdmin` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `cadreadministrateur`
--

INSERT INTO `cadreadministrateur` (`grade`, `idCardreAdmin`) VALUES
('gradeeee', 8),
('Admin 2eme grade', 12);

-- --------------------------------------------------------

--
-- Structure de la table `compte`
--

CREATE TABLE `compte` (
  `idCompte` bigint(20) NOT NULL,
  `accepteDemandeAutorisationAbsence` bit(1) NOT NULL,
  `accountNonExpired` bit(1) NOT NULL,
  `accountNonLocked` bit(1) NOT NULL,
  `afficheEmail` bit(1) NOT NULL,
  `affichePhoto` bit(1) NOT NULL,
  `credentialsNonExpired` bit(1) NOT NULL,
  `disconnectAccount` bit(1) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `login` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `idUtilisateur` bigint(20) DEFAULT NULL,
  `idRole` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `compte`
--

INSERT INTO `compte` (`idCompte`, `accepteDemandeAutorisationAbsence`, `accountNonExpired`, `accountNonLocked`, `afficheEmail`, `affichePhoto`, `credentialsNonExpired`, `disconnectAccount`, `enabled`, `login`, `password`, `idUtilisateur`, `idRole`) VALUES
(8, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'admin', '{bcrypt}$2a$10$vsjRwUSUi2B/jlw4ATXEN.B2IIcVY8ourImFZnWcW1tLz3G6mLfpe', 8, 1),
(9, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'prof', '{bcrypt}$2a$10$vsjRwUSUi2B/jlw4ATXEN.B2IIcVY8ourImFZnWcW1tLz3G6mLfpe', 9, 2),
(12, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'student', '{bcrypt}$2a$10$vsjRwUSUi2B/jlw4ATXEN.B2IIcVY8ourImFZnWcW1tLz3G6mLfpe', 11, 4),
(13, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'cadre_admin', '{bcrypt}$2a$10$vsjRwUSUi2B/jlw4ATXEN.B2IIcVY8ourImFZnWcW1tLz3G6mLfpe', 11, 3),
(14, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'biblio', '{bcrypt}$2a$10$vsjRwUSUi2B/jlw4ATXEN.B2IIcVY8ourImFZnWcW1tLz3G6mLfpe', 12, 5),
(15, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'dqdqsddsqd', '{bcrypt}$2a$10$KP4L1iA3LEw.R5Fhxcvke.uPYJ78FrRC.f5cgvRFUkSxm0LG2k4f6', 10, 1),
(16, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'dsqdaaa', '{bcrypt}$2a$10$FpZXiDuChY5dLKYLsiYK5e8H.WHjhAwreM4cLsUwOwjojQumIIUWm', 11, 1),
(17, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'BOUDAATarik', '{bcrypt}$2a$10$Lq.IEQa5h6Q8xJ5s5vhVKuU8GhoYMAPtrcQdy6TIHJyWRy66yuwpG', 8, 5),
(18, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'Mohamed AyadiArrogan Wickhurst Road', '{bcrypt}$2a$10$4lp3uhaIVTuy92zahl9oguypviCRScbWLw0CQ1evkpbWDh6Gm7.Q.', 13, 4);

-- --------------------------------------------------------

--
-- Structure de la table `element`
--

CREATE TABLE `element` (
  `idMatiere` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `currentCoefficient` double NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `idModule` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `element`
--

INSERT INTO `element` (`idMatiere`, `code`, `currentCoefficient`, `nom`, `idModule`) VALUES
(1, 'JEE', 0.4, 'JEE', 3),
(2, 'Spring', 0.6, 'Spring', 3);

-- --------------------------------------------------------

--
-- Structure de la table `enseignant`
--

CREATE TABLE `enseignant` (
  `specialite` varchar(255) DEFAULT NULL,
  `idEnseighant` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `enseignant`
--

INSERT INTO `enseignant` (`specialite`, `idEnseighant`) VALUES
('math', 10);

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

CREATE TABLE `etudiant` (
  `cne` varchar(255) DEFAULT NULL,
  `dateNaissance` datetime(6) DEFAULT NULL,
  `idEtudiant` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`cne`, `dateNaissance`, `idEtudiant`) VALUES
('DDDDDDDD', NULL, 4),
('EEEEEEEE', NULL, 5),
('FFFFFFFF', NULL, 6),
('GGGGGGGG', NULL, 7),
('DDDDDDDD', NULL, 8),
('aaaa', NULL, 9),
('dsqd', NULL, 11),
('EEEEEEEE', NULL, 12),
('H137204192', NULL, 13);

-- --------------------------------------------------------

--
-- Structure de la table `filiere`
--

CREATE TABLE `filiere` (
  `idFiliere` bigint(20) NOT NULL,
  `anneeFinaccreditation` int(11) NOT NULL,
  `anneeaccreditation` int(11) NOT NULL,
  `codeFiliere` varchar(255) DEFAULT NULL,
  `titreFiliere` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `filiere`
--

INSERT INTO `filiere` (`idFiliere`, `anneeFinaccreditation`, `anneeaccreditation`, `codeFiliere`, `titreFiliere`) VALUES
(1, 2010, 2030, 'AP', 'Annees Preparatoires'),
(2, 2010, 2030, 'GI', 'Genie Informatique'),
(3, 2010, 2030, 'GC', 'Genie Civil'),
(4, 2010, 2030, 'GEER', 'Genie energetique & Energie renouvlable'),
(5, 2010, 2030, 'GEE', 'Genie de l\'Eau $ l\'Envirenement'),
(6, 2010, 2030, 'GM', 'Genie Mecanique'),
(7, 2010, 2030, 'ID', 'Ingenirie des Donnees');

-- --------------------------------------------------------

--
-- Structure de la table `inscriptionannuelle`
--

CREATE TABLE `inscriptionannuelle` (
  `idInscription` bigint(20) NOT NULL,
  `annee` varchar(255) NOT NULL,
  `etat` int(11) NOT NULL,
  `mention` varchar(255) DEFAULT NULL,
  `plusInfos` varchar(255) DEFAULT NULL,
  `rang` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `validation` varchar(255) DEFAULT NULL,
  `idEtudiant` bigint(20) DEFAULT NULL,
  `idNiveau` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `inscriptionannuelle`
--

INSERT INTO `inscriptionannuelle` (`idInscription`, `annee`, `etat`, `mention`, `plusInfos`, `rang`, `type`, `validation`, `idEtudiant`, `idNiveau`) VALUES
(1, '2021/2022', 2, NULL, NULL, 3, NULL, NULL, 7, 4),
(2, '2021/2022', 1, NULL, NULL, 1, NULL, NULL, 9, 4),
(3, '2021/2022', 1, NULL, NULL, 1, NULL, NULL, 11, 4),
(4, '2021/2022', 1, NULL, NULL, 1, NULL, NULL, 13, 4);

-- --------------------------------------------------------

--
-- Structure de la table `inscriptionmatiere`
--

CREATE TABLE `inscriptionmatiere` (
  `idInscriptionMatiere` bigint(20) NOT NULL,
  `coefficient` double NOT NULL,
  `noteFinale` double NOT NULL,
  `noteSN` double NOT NULL,
  `noteSR` double NOT NULL,
  `plusInfos` varchar(255) DEFAULT NULL,
  `validation` varchar(255) DEFAULT NULL,
  `idInscription` bigint(20) DEFAULT NULL,
  `idMatiere` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `inscriptionmodule`
--

CREATE TABLE `inscriptionmodule` (
  `idInscriptionModule` bigint(20) NOT NULL,
  `noteFinale` double NOT NULL,
  `noteSN` double NOT NULL,
  `noteSR` double NOT NULL,
  `plusInfos` varchar(255) DEFAULT NULL,
  `validation` varchar(255) DEFAULT NULL,
  `idInscription` bigint(20) DEFAULT NULL,
  `idModule` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `inscriptionmodule`
--

INSERT INTO `inscriptionmodule` (`idInscriptionModule`, `noteFinale`, `noteSN`, `noteSR`, `plusInfos`, `validation`, `idInscription`, `idModule`) VALUES
(1, -1, 16, 16, NULL, NULL, 1, 3),
(2, -1, 6.6000000000000005, 6.6000000000000005, NULL, NULL, 2, 3),
(3, -1, 11, 11, NULL, NULL, 3, 3),
(4, -1, 10.8, 10.8, NULL, NULL, 4, 3);

-- --------------------------------------------------------

--
-- Structure de la table `module`
--

CREATE TABLE `module` (
  `idModule` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `idNiveau` bigint(20) DEFAULT NULL,
  `idEnseignant` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `module`
--

INSERT INTO `module` (`idModule`, `code`, `titre`, `idNiveau`, `idEnseignant`) VALUES
(1, 'Ana 1', 'Analyse 1', 1, 10),
(2, 'Alg1', 'Algebre 1', 1, 10),
(3, 'JEE', 'Java-EE & Spring', 4, 10),
(4, 'JAVA', 'Programmation Java', 18, 10);

-- --------------------------------------------------------

--
-- Structure de la table `niveau`
--

CREATE TABLE `niveau` (
  `idNiveau` bigint(20) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `idFiliere` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `niveau`
--

INSERT INTO `niveau` (`idNiveau`, `alias`, `titre`, `idFiliere`) VALUES
(1, 'AP1', 'Annee Preparatoire 1', 1),
(2, 'AP2', 'Annee Preparatoire 2', 1),
(3, 'GI1', 'Genie Informatique 1', 2),
(4, 'GI2', 'Genie Informatique 2', 2),
(5, 'GI3', 'Genie Informatique 3', 2),
(6, 'GC1', 'Genie Civil 1', 3),
(7, 'GC2', 'Genie Civil 2', 3),
(8, 'GC3', 'Genie Civil 3', 3),
(9, 'GEER1', 'Genie energetique & Energie renouvlable 1', 4),
(10, 'GEER2', 'Genie energetique & Energie renouvlable 2', 4),
(11, 'GEER3', 'Genie energetique & Energie renouvlable 3', 4),
(12, 'GEE1', 'Genie de l\'Eau $ l\'Envirenement 1', 5),
(13, 'GEE2', 'Genie de l\'Eau $ l\'Envirenement 2', 5),
(14, 'GEE3', 'Genie de l\'Eau $ l\'Envirenement 3', 5),
(15, 'GM1', 'Genie Mecanique 1', 6),
(16, 'GM2', 'Genie Mecanique 2', 6),
(17, 'GM1', 'Genie Mecanique 3', 6),
(18, 'ID1', 'Ingenirie des Donnees 1', 7),
(19, 'ID2', 'Ingenirie des Donnees 2', 7),
(20, 'ID1', 'Ingenirie des Donnees 3', 7);

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

CREATE TABLE `role` (
  `idRole` bigint(20) NOT NULL,
  `nomRole` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`idRole`, `nomRole`) VALUES
(1, 'ROLE_ADMIN'),
(2, 'ROLE_PROF'),
(3, 'ROLE_CADRE_ADMIN'),
(4, 'ROLE_STUDENT'),
(5, 'ROLE_BIBLIO');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `idUtilisateur` bigint(20) NOT NULL,
  `cin` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `nomArabe` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `prenomArabe` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `cin`, `email`, `nom`, `nomArabe`, `photo`, `prenom`, `prenomArabe`, `telephone`) VALUES
(1, 'AAAAA', 'charroud@charroud.com', 'Charroud', 'شرود', NULL, 'Mohammed', 'محمد', '060000000'),
(2, 'BBBBBBB', 'boudaa@boudaa.com', 'BOUDAA', 'بوضع', NULL, 'Tarik', 'طارق', '0600000000'),
(3, 'CCCC', 'addam@addam.com', 'ADDAM', 'عدام', NULL, 'Mohammed', 'محمد', '0600000000'),
(4, 'DDDD', 'mohamed@anir.com', 'Anir', NULL, NULL, 'Mohammed', '', '0600000000'),
(5, 'EEEE', 'karam@karam.com', 'KARAM', 'كرم', NULL, 'KARAM', 'كرم', '0600000000'),
(6, 'FFFF', 'cp1@1.com', 'CP1St1Nom', 'CP1St1Nom', NULL, 'CP1St1Prenom', 'CP1St1Prenom', '0600000000'),
(7, 'GGGG', 'cp1@2.com', 'CP1St2Nom', 'CP1St2Nom', NULL, 'CP1St2Prenom', 'CP1St2Prenom', '0600000000'),
(8, 'AAAA', 'tarik@tarik.fr', 'BOUDAA', 'Tarik', NULL, 'Tarik', 'Boudaa', '060000000'),
(9, 'ABnh1', 'med1@med.com', 'BOUDAA', 'med', NULL, 'Mohamed', 'med', '2522255'),
(10, 'dqsdqsd', 'dqsdsqd', 'dqdqsd', 'dqsdqdqsd', NULL, 'dsqd', 'dqdqd', '12589632'),
(11, 'AB', 'dsqdqs', 'dsqd', 'dsqdqsd', NULL, 'aaa', 'dqsdqsd', '12589632'),
(12, 'BBBB', 'karama@karam.fr', 'KARAM', 'KARAM', NULL, 'KARAM', 'KARAM', '0666666666'),
(13, 'S775494', 'gsmohamedd@gmail.com', 'Mohamed Ayadi', 'Ayadi', NULL, 'Arrogan Wickhurst Road', 'Mohamed', '0642376654');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cadreadministrateur`
--
ALTER TABLE `cadreadministrateur`
  ADD PRIMARY KEY (`idCardreAdmin`);

--
-- Index pour la table `compte`
--
ALTER TABLE `compte`
  ADD PRIMARY KEY (`idCompte`),
  ADD KEY `FK4me3b7yms83bsk757qlkk5icm` (`idUtilisateur`),
  ADD KEY `FK6rqvo0g5sv97xlbrragf5rwn3` (`idRole`);

--
-- Index pour la table `element`
--
ALTER TABLE `element`
  ADD PRIMARY KEY (`idMatiere`),
  ADD KEY `FKpy7uud3qt1x365dnkff4f41l8` (`idModule`);

--
-- Index pour la table `enseignant`
--
ALTER TABLE `enseignant`
  ADD PRIMARY KEY (`idEnseighant`);

--
-- Index pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`idEtudiant`);

--
-- Index pour la table `filiere`
--
ALTER TABLE `filiere`
  ADD PRIMARY KEY (`idFiliere`);

--
-- Index pour la table `inscriptionannuelle`
--
ALTER TABLE `inscriptionannuelle`
  ADD PRIMARY KEY (`idInscription`),
  ADD KEY `FKge2xwqtfeqnojw9no8og6vbqn` (`idEtudiant`),
  ADD KEY `FK9lrdmhkam481adiwotdpqo8w` (`idNiveau`);

--
-- Index pour la table `inscriptionmatiere`
--
ALTER TABLE `inscriptionmatiere`
  ADD PRIMARY KEY (`idInscriptionMatiere`),
  ADD KEY `FKdrefbosgrrf561bghbosk681q` (`idInscription`),
  ADD KEY `FK6om7ooil7qy2ipbtocv7hqrwo` (`idMatiere`);

--
-- Index pour la table `inscriptionmodule`
--
ALTER TABLE `inscriptionmodule`
  ADD PRIMARY KEY (`idInscriptionModule`),
  ADD KEY `FK2rp4wu9gg4s1yvbannj858m3c` (`idInscription`),
  ADD KEY `FKsfog581rh033dgomu0u7xywgd` (`idModule`);

--
-- Index pour la table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`idModule`),
  ADD KEY `FK2kgd6okkiatvq3do7akj1cm2k` (`idNiveau`),
  ADD KEY `FK8gasmkwnlxgdrdk4h8tenvd7n` (`idEnseignant`);

--
-- Index pour la table `niveau`
--
ALTER TABLE `niveau`
  ADD PRIMARY KEY (`idNiveau`),
  ADD KEY `FK9qvkxk4ayqkjopclmlgoel8d9` (`idFiliere`);

--
-- Index pour la table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`idRole`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`idUtilisateur`),
  ADD UNIQUE KEY `UK_s4m395xkorrxtrdbuk1upglup` (`cin`),
  ADD UNIQUE KEY `UK_35ysk0sh9ruwixrld3nc0weut` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `compte`
--
ALTER TABLE `compte`
  MODIFY `idCompte` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `element`
--
ALTER TABLE `element`
  MODIFY `idMatiere` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `filiere`
--
ALTER TABLE `filiere`
  MODIFY `idFiliere` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `inscriptionannuelle`
--
ALTER TABLE `inscriptionannuelle`
  MODIFY `idInscription` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `inscriptionmatiere`
--
ALTER TABLE `inscriptionmatiere`
  MODIFY `idInscriptionMatiere` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `inscriptionmodule`
--
ALTER TABLE `inscriptionmodule`
  MODIFY `idInscriptionModule` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `module`
--
ALTER TABLE `module`
  MODIFY `idModule` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `niveau`
--
ALTER TABLE `niveau`
  MODIFY `idNiveau` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `role`
--
ALTER TABLE `role`
  MODIFY `idRole` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `cadreadministrateur`
--
ALTER TABLE `cadreadministrateur`
  ADD CONSTRAINT `FKq2jdlid8esk1jlagny4qhrh2k` FOREIGN KEY (`idCardreAdmin`) REFERENCES `utilisateur` (`idUtilisateur`);

--
-- Contraintes pour la table `compte`
--
ALTER TABLE `compte`
  ADD CONSTRAINT `FK4me3b7yms83bsk757qlkk5icm` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`),
  ADD CONSTRAINT `FK6rqvo0g5sv97xlbrragf5rwn3` FOREIGN KEY (`idRole`) REFERENCES `role` (`idRole`);

--
-- Contraintes pour la table `element`
--
ALTER TABLE `element`
  ADD CONSTRAINT `FKpy7uud3qt1x365dnkff4f41l8` FOREIGN KEY (`idModule`) REFERENCES `module` (`idModule`);

--
-- Contraintes pour la table `enseignant`
--
ALTER TABLE `enseignant`
  ADD CONSTRAINT `FKk26kuxt8qhs6nqv41b2hiyqwb` FOREIGN KEY (`idEnseighant`) REFERENCES `utilisateur` (`idUtilisateur`);

--
-- Contraintes pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `FKkku0boly4both705vo0fri81c` FOREIGN KEY (`idEtudiant`) REFERENCES `utilisateur` (`idUtilisateur`);

--
-- Contraintes pour la table `inscriptionannuelle`
--
ALTER TABLE `inscriptionannuelle`
  ADD CONSTRAINT `FK9lrdmhkam481adiwotdpqo8w` FOREIGN KEY (`idNiveau`) REFERENCES `niveau` (`idNiveau`),
  ADD CONSTRAINT `FKge2xwqtfeqnojw9no8og6vbqn` FOREIGN KEY (`idEtudiant`) REFERENCES `etudiant` (`idEtudiant`);

--
-- Contraintes pour la table `inscriptionmatiere`
--
ALTER TABLE `inscriptionmatiere`
  ADD CONSTRAINT `FK6om7ooil7qy2ipbtocv7hqrwo` FOREIGN KEY (`idMatiere`) REFERENCES `element` (`idMatiere`),
  ADD CONSTRAINT `FKdrefbosgrrf561bghbosk681q` FOREIGN KEY (`idInscription`) REFERENCES `inscriptionannuelle` (`idInscription`);

--
-- Contraintes pour la table `inscriptionmodule`
--
ALTER TABLE `inscriptionmodule`
  ADD CONSTRAINT `FK2rp4wu9gg4s1yvbannj858m3c` FOREIGN KEY (`idInscription`) REFERENCES `inscriptionannuelle` (`idInscription`),
  ADD CONSTRAINT `FKsfog581rh033dgomu0u7xywgd` FOREIGN KEY (`idModule`) REFERENCES `module` (`idModule`);

--
-- Contraintes pour la table `module`
--
ALTER TABLE `module`
  ADD CONSTRAINT `FK2kgd6okkiatvq3do7akj1cm2k` FOREIGN KEY (`idNiveau`) REFERENCES `niveau` (`idNiveau`),
  ADD CONSTRAINT `FK8gasmkwnlxgdrdk4h8tenvd7n` FOREIGN KEY (`idEnseignant`) REFERENCES `enseignant` (`idEnseighant`);

--
-- Contraintes pour la table `niveau`
--
ALTER TABLE `niveau`
  ADD CONSTRAINT `FK9qvkxk4ayqkjopclmlgoel8d9` FOREIGN KEY (`idFiliere`) REFERENCES `filiere` (`idFiliere`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
