CREATE TABLE `orga_grades` (
  `id_grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rang` int(11) NOT NULL,
  `id_orga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

-- --------------------------------------------------------

--
-- Structure de la table `orga_liste`
--

CREATE TABLE `orga_liste` (
  `id_orga` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `devise` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- AUTO_INCREMENT pour la table `orga_grades`
--
ALTER TABLE `orga_grades`
  MODIFY `id_grade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `orga_grade_perm`
--
ALTER TABLE `orga_grade_perm`
  MODIFY `id_grade_perm` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `orga_liste`
--
ALTER TABLE `orga_liste`
  MODIFY `id_orga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `orga_membres`
--
ALTER TABLE `orga_membres`
  MODIFY `id_membre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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