-- MySQL dump 10.13  Distrib 5.1.69, for redhat-linux-gnu (x86_64)
--
-- Host: calvin    Database: purchasable
-- ------------------------------------------------------
-- Server version	5.1.67

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `definition_count_groups_openeye`
--

DROP TABLE IF EXISTS `definition_count_groups_openeye`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `definition_count_groups_openeye` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `smarts_string` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `definition_count_groups_openeye`
--

LOCK TABLES `definition_count_groups_openeye` WRITE;
/*!40000 ALTER TABLE `definition_count_groups_openeye` DISABLE KEYS */;
INSERT INTO `definition_count_groups_openeye` VALUES (2,'num_nitril','','C#N'),(4,'num_amid','no urea','[c,C][C,c;!R](=O)N'),(7,'num_ether','but not ester','[CX4,c]O[CX4,c]'),(11,'num_imine','','[N!R]=[C,c]'),(12,'num_substituted_aniline','not amides','[cR2]1[cR2]c([$([NH][CX4]),$(N([CX4])[CX4])])[cR2][cR2][cR2]1'),(13,'num_amino_thiazole','','[cR2]1[cR2]s[cR2]([NH2])n1');
/*!40000 ALTER TABLE `definition_count_groups_openeye` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `definition_neutralize_compounds`
--

DROP TABLE IF EXISTS `definition_neutralize_compounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `definition_neutralize_compounds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(15) NOT NULL DEFAULT '' COMMENT 'acid / base',
  `pka` float NOT NULL DEFAULT '0',
  `smirks` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `gif` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=493 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `definition_neutralize_compounds`
--

LOCK TABLES `definition_neutralize_compounds` WRITE;
/*!40000 ALTER TABLE `definition_neutralize_compounds` DISABLE KEYS */;
INSERT INTO `definition_neutralize_compounds` VALUES (481,'acid',5,'[*;C,c,S,P:1](=O)[O-]>>[*;C,c,S,P:1](=O)O','neutralize acids',''),(482,'base',9,'[*:1][NH3+]>>[*:1][NH2]','neutralize amines',''),(483,'base',9,'[*:1][NH2+][*:2]>>[*:1][NH][*:2]','neutralize sec. amines',''),(484,'base',9,'[*:1][NH+]([*:2])[*:3]>>[*:1]N([*:2])[*:3]','neutralize tert. amines',''),(485,'base',9,'[*:1][nH+][*:2]>>[*:1]:n:[*:2]','neutralize aromatic amines',''),(486,'acid',6,'[*:1][SX1-]>>[*:1]S','neutralize thiols',''),(487,'acid',2,'[*:1]S(=O)(=O)[O-]>>[*:1]S(=O)(=O)[OH]','sulfonic acid',''),(490,'acid',4,'[*:1]S(=O)(=O)[N-][C:2]=[O:3]>>[*:1]S(=O)(=O)[NH][C:2]=[O:3]','sulfonamid (carbonyl substituent)',''),(488,'acid',5,'c1([*:1])nnn[n-]1>>c1([*:1])nnn[nH]1','tetrazole',''),(489,'base',12,'[N+0:1]C(=[NH+][*:2])[*;c,C:3]>>[N+0:1]C(=[N+0][*:2])[*;c,C:3]','amidine',''),(491,'acid',5,'[*:1]c1n[n-]nn1>>[*:1]c1n[nH]nn1','tetrazole',''),(492,'base',12,'[N+0:1]C(=[NH2+])[*;c,C:3]>>[N+0:1]C(=[NH])[*;c,C:3]','amdine, primary','');
/*!40000 ALTER TABLE `definition_neutralize_compounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `definition_prot_rules`
--

DROP TABLE IF EXISTS `definition_prot_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `definition_prot_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL DEFAULT '',
  `pka` int(11) NOT NULL DEFAULT '0',
  `smirks` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `gif` varchar(20) NOT NULL DEFAULT '',
  `updated_by` varchar(5) NOT NULL DEFAULT '',
  `date_of_update` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `definition_prot_rules`
--

LOCK TABLES `definition_prot_rules` WRITE;
/*!40000 ALTER TABLE `definition_prot_rules` DISABLE KEYS */;
INSERT INTO `definition_prot_rules` VALUES (9,'base',20,'[*,a,A:1]N(=O)=O>>[*,a,A:1][N+](=O)[O-]','standardise Nitro groups (+/- form is needed to distinguish between NH2 and NO2)','nitro.gif','','0000-00-00'),(22,'acid',4,'[*:1][C:2](=[O+0])[OH]>>[*:1][C:2](=O)[O-]','deprotonate carbonic acids','carb_acid.gif','RB','2009-07-01'),(26,'acid',2,'[*:1][P:22](=O)([OH])[OH]>>[*:1][P:22](=O)([O-])[O-]','deprotonate neutral phosphates / phosphonic acidneeded to preserve  chirality','phos_acid1.gif','','0000-00-00'),(27,'acid',2,'[*:1][P:22](=O)([O-])[OH]>>[*:1][P:22](=O)([O-])[O-]','deprotonate -1 phosphates / phosphonic acidneeded to preserve  chirality','phos_acid2.gif','','0000-00-00'),(28,'acid',2,'[*:1][P:22](=O)([N:2])[OH]>>[*:1][P:22](=O)([N:2])[O-]','phosphorylamideneeded to preserve  chirality','phosphorylamid.gif','','0000-00-00'),(29,'acid',2,'[*:1][S:22](=O)(=O)[OH]>>[*:1][S:22](=O)(=O)[O-]','deprotonate sulfuric / sulfonic acid, needed to preserve  chirality','sulf_acid1.gif','RB','2008-02-11'),(30,'acid',2,'[*:1][S;X3:2](=O)[OH]>>[*:1][S;X3:2](=O)[O-]','deprotonate sulfinic acid (but not sulfonic acid) => sulfur must have exactly three neighbouring atoms','sulf_acid2.gif','','0000-00-00'),(31,'acid',8,'[*:1][C:2](=O)[NH!+][OH]>>[*:1][C:2](=O)[NH!+][O-]','hydroxamic acids (pKa ~ 8.5), N must be 0, otherwise it is probably an N-oxide, carbonly oxygen must by C:2, otherwise chirality is inverted, not sure why','hydroxamid_acid.gif','RB','2008-02-07'),(32,'acid',8,'[*:1][S:22](=O)(=O)[NH][*;a,A:2]=,~[*;a,A:3]>>[*:1][S:22](=O)(=O)[N-][*;a,A:2]=,~[*;a,A:3]','sulfonamid (aromatic or alkene substituent), needed to preserve  chirality','sulfon_amid1.gif','RB','2008-02-11'),(33,'acid',4,'[*:1][S:22](=O)(=O)[NH][C:2]=[O:3]>>[*:1][S:22](=O)(=O)[N-][C:2]=[O:3]','sulfonamid (carbonyl substituent), needed to preserve  chirality','sulfon_amid2.gif','RB','2008-02-11'),(34,'acid',11,'[*:1][S:22](=O)(=O)[NH][CX4:2]>>[*:1][S:22](=O)(=O)[N-][CX4:2]','sulfonamid (alkyl syb.), needed to preserve  chirality','sulfon_amid3.gif','RB','2008-02-11'),(35,'acid',4,'[*:1][S:22](=O)(=O)[NH][*;Cl,Br,F:2]>>[*:1][S:22](=O)(=O)[N-][*;Cl,Br,F:2]','sulfonamid (chlorine), needed to preserve  chirality','sulfon_amid4.gif','RB','2008-02-11'),(36,'acid',4,'[c:2]1([*:1])[nX2][nX2][nX2][nH]1>>[c:2]1([*:1])[nX2][nX2][nX2][n-]1','deprotonate tetrazole, needed to preserve  chirality','','RB','2009-07-01'),(37,'acid',4,'[c:2]1([*:1])[nX2][nX2][nH][nX2]1>>[c:2]1([*:1])[nX2][nX2][nX2][n-]1','deprotonate tetrazole, needed to preserve  chirality','','RB','2009-07-01'),(38,'acid',10,'[OH][c:1]1[c:2][c:3][c:4][c:5][c:6]1>>[O-][c:1]1[c:2][c:3][c:4][c:5][c:6]1','phenol','','','0000-00-00'),(39,'acid',6,'[OH][c:1]1[c:2]([N+](=O)[O-])[c:3][c:4][c:5][c:6]1>>[O-][c:1]1[c:2]([N+](=O)[O-])[c:3][c:4][c:5][c:6]1','2-nitrophenol','','','0000-00-00'),(40,'acid',6,'[OH][c:1]1[c:2][c:3][c:4]([N+](=O)[O-])[c:5][c:6]1>>[O-][c:1]1[c:2][c:3][c:4]([N+](=O)[O-])[c:5][c:6]1','4-nitrophenol','','','0000-00-00'),(41,'acid',6,'[OH][c:1]1[c:2][c:3]([N+](=O)[O-])[c:4][c:5]([N+](=O)[O-])[c:6]1>>[O-][c:1]1[c:2][c:3]([N+](=O)[O-])[c:4][c:5]([N+](=O)[O-])[c:6]1','3,5-dinitrophenol','','','0000-00-00'),(42,'acid',9,'[SHX2][C:1]>>[S-][C:1]','alkyl thiol','','','0000-00-00'),(43,'acid',6,'[SHX2][c:1]1[c:2][c:3][c:4][c:5][c:6]1>>[S-][c:1]1[c:2][c:3][c:4][c:5][c:6]1','aromatic thiol','','','0000-00-00'),(44,'base',10,'[C;X4:1][NH2!+]>>[C;X4:1][NH3+]','protontate prim amine if no aromatic substituent','','','0000-00-00'),(45,'base',11,'[C;X4:1][NH;X3][C;X4:2]>>[C;X4:1][NH2+][C;X4:2]','protontate sec amine, if no aromatic substituent, inverts stereo centre','','','0000-00-00'),(46,'base',10,'[C;X4:1][N;X3]([C;X4:2])[C;X4:3]>>[C;X4:1][NH+]([C;X4:2])[C;X4:3]','protontate tert amine (not quart.), if no aromatic substituent','','','0000-00-00'),(47,'base',0,'[C:1]1[N+:2][C:3][C:4]N[C:6]1>>[C:1]1[N+:2][C:3][C:4][NH2+][C:6]1','rescue sec, sec-tert piperazine','','','0000-00-00'),(48,'base',0,'[C:1]1[N+:2][C:3][C:4]N([C:5])[C:6]1>>[C:1]1[N+:2][C:3][C:4][NH+]([C:5])[C:6]1','rescue tert-tert piperazine','','','0000-00-00'),(49,'base',0,'[C:1]1[N+:2][C:3]N[C:4][C:6]1>>[C:1]1[N+:2][C:3][NH2+][C:4][C:6]1','rescue sec, sec-tert hexa-hydro-pyrimidine','','','0000-00-00'),(50,'base',0,'[C:1]1[N+:2][C:3]N([C:5])[C:4][C:6]1>>[C:1]1[N+:2][C:3][NH+]([C:5])[C:4][C:6]1','rescue tert-tert hexa-hydro-pyrimidine','','','0000-00-00'),(51,'base',10,'[C;!R:1]=[C;!R:2][NH2!+]>>[C;!R:1]=[C;!R:2][NH3+]','primary enamine','','','0000-00-00'),(52,'base',10,'[C;!R:1]=[C;!R:2][NH][C;X4:3]>>[C;!R:1]=[C;!R:2][NH2+][C;X4:3]','sec. enamine','','','0000-00-00'),(53,'base',10,'[C;!R:1]=[C;!R:2][N;X3]([C;X4:3])[C;X4:4]>>[C;!R:1]=[C;!R:2][NH+]([C;X4:3])[C;X4:4]','tert. enamine','','','0000-00-00'),(54,'base',0,'[*;CX3,F,Cl,Br,I,N+X3:6][C;!R:1]=[C;!R:2][NH2!+]>>[*;CX3,F,Cl,Br,I,N+X3:6][C;!R:1]=[C;!R:2][NH3+]','exclude conjugated primary enamine','','','0000-00-00'),(55,'base',0,'[*;CX3,F,Cl,Br,I,N+X3:6][C;!R:1]=[C;!R:2][NH][C;X4:3]>>[*;CX3,F,Cl,Br,I,N+X3:6][C;!R:1]=[C;!R:2][NH2+][C;X4:3]','exclude conjugated sec. enamine','','','0000-00-00'),(56,'base',0,'[*;CX3,F,Cl,Br,I,N+X3:6][C;!R:1]=[C;!R:2][N;X3]([C;X4:3])[C;X4:4]>>[*;CX3,F,Cl,Br,I,N+X3:6][C;!R:1]=[C;!R:2][NH+]([C;X4:3])[C;X4:4]','exclude conjugated tert. enamine','','','0000-00-00'),(57,'base',7,'[C:1][N;X3,R0:2][NH2!+]>>[C:1][N;X3,R0:2][NH3+]','protontate prim hydrazine','','','0000-00-00'),(58,'base',7,'[C:1][N;X3,R0:2][NH!+][C;X4:3]>>[C:1][N;X3,R0:2][NH2+][C;X4:3]','protontate sek hydrazine','','','0000-00-00'),(59,'base',7,'[C:1][N;X3,R0:2][N!+X3]([C;X4:3])[C;X4:4]>>[C:1][N!+:2][NH+]([C;X4:3])[C;X4:4]','protontate tert hydrazine','','','0000-00-00'),(60,'base',30,'[C:1][NH2+][NH+:2]>>[C:1]N[NH+:2]','rescue douple protonated hydrazines','','','0000-00-00'),(61,'base',12,'[N+0:1][C:5](=[NH+0:2])[*;c,C:3]>>[N:1][C:5](=[N+:2][H])[*;c,C:3]','unsub amidine','','RB','2008-02-08'),(63,'base',12,'[NX3+0!R:1][C!R:5](=[N+0!R:2][CX4:4])[N!R:3]>>[N:1][C:5](=[N+:2]([H])[C:4])[*:3]','non-cyclic guanidine','was amidine before','RB','2008-07-03'),(65,'base',12,'[*;O,S,P,N,n,c,CX3,CX2:4][N+0:1][C:3](=[NH2+1])>>[*:4][N:1][C:3](=[NH])','rescue amidine, guanidine','','','0000-00-00'),(66,'base',12,'[*;O,S,P,N,n,c,CX3,CX2:4][N+0:1][C:3](=[NH+1][C:2])>>[*:4][N:1][C:3](=[N+0][C:2])','rescue amidine, guanidine','','','0000-00-00'),(67,'base',12,'[N+0:1][C:3](=[NH+1][*;O,S,P,N,n,c,CX3,CX2:4])>>[N:1][C:3](=[NH0][*:4])','rescue amidine, guanidine','','','0000-00-00'),(71,'base',4,'[c;R2:1]1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH2;!+]>>[c;R2:1]1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH3+]','unsubstitued aniline','','','0000-00-00'),(72,'base',4,'[c;R2:1]1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH;X3!+][C:6]>>[c;R2:1]1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH2+][C:6]','substituted aniline','','','0000-00-00'),(73,'base',4,'[c;R2:1]1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NX3!+]([C:6])[C:7]>>[c;R2:1]1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH+]([C:6])[C:7]','di-substituted aniline','','','0000-00-00'),(74,'base',6,'[c;R2:1]1[c;R2:2][c;R2:3]([NX3!+:8])[c;R2:4][c;R2:5]c1[NH;X3!+][CX4:6]>>[c;R2:1]1[c;R2:2][c;R2:3]([NX3:8])[c;R2:4][c;R2:5]c1[NH2+][CX4:6]','substituted 1,4-diaminobenzene','','','0000-00-00'),(75,'base',6,'[c;R2:1]1[c;R2:2][c;R2:3]([NX3+0:8])[c;R2:4][c;R2:5]c1[NX3+0]([CX4:6])[CX4:7]>>[c;R2:1]1[c;R2:2][c;R2:3]([NX3+0:8])[c;R2:4][c;R2:5]c1[NH+]([CX4:6])[CX4:7]','di-substituted 1,4-diaminobenzene','','','0000-00-00'),(76,'base',6,'[c;R2:1]1[c;R2:2][c;R2:3]([NX3!+:6])[c;R2:4][c;R2:5]c1[NH2!+;X3]>>[c;R2:1]1[c;R2:2][c;R2:3]([NX3:6])[c;R2:4][c;R2:5]c1[NH3+]','unsubstitued 1,4-diaminobenzene','','','0000-00-00'),(77,'base',0,'[*;F,Cl,Br,I,N+X3:1]c1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH2!+]>>[*;F,Cl,Br,I,N+X3:1]c1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH3+]','exclude halogenated, primary aniline','','','0000-00-00'),(78,'base',0,'[c;R2:1]1c([*;F,Cl,Br,I,N+X3:2])[c;R2:3][c;R2:4][c;R2:5]c1[NH2!+]>>[c;R2:1]1c([*;F,Cl,Br,I,N+X3:2])[c;R2:3][c;R2:4][c;R2:5]c1[NH3+]','exclude halogenated, primary  aniline','','','0000-00-00'),(79,'base',0,'[c;R2:1]1[c;R2:2]c([*;F,Cl,Br,I,N+X3:3])[c;R2:4][c;R2:5]c1[NH2!+]>>[c;R2:1]1[c;R2:2]c([*;F,Cl,Br,I,N+X3:3])[c;R2:4][c;R2:5]c1[NH3+]','exclude halogenated, primary  aniline','','','0000-00-00'),(80,'base',0,'[*;F,Cl,Br,I,N+X3:1]c1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH;X3][C:6]>>[*;F,Cl,Br,I,N+X3:1]c1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH2+][C:6]','exclude halogenated, secondary  aniline','','','0000-00-00'),(81,'base',0,'[c;R2:1]1c([*;F,Cl,Br,I,N+X3:2])[c;R2:3][c;R2:4][c;R2:5]c1[NH;X3][C:6]>>[c;R2:1]1c([*;F,Cl,Br,I,N+X3:2])[c;R2:3][c;R2:4][c;R2:5]c1[NH2+][C:6]','exclude halogenated, secondary aniline','','','0000-00-00'),(82,'base',0,'[c;R2:1]1[c;R2:2]c([*;F,Cl,Br,I,N+X3:3])[c;R2:4][c;R2:5]c1[NH;X3][C:6]>>[c;R2:1]1[c;R2:2]c([*;F,Cl,Br,I,N+X3:3])[c;R2:4][c;R2:5]c1[NH2+][C:6]','exclude halogenated, secondary aniline','','','0000-00-00'),(83,'base',0,'[*;F,Cl,Br,I,N+X3:1]c1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NX3]([*:6])[*:7]>>[*;F,Cl,Br,I,N+X3:1]c1[c;R2:2][c;R2:3][c;R2:4][c;R2:5]c1[NH+]([C:6])[C:7]','exclude halogenated, tertary aniline','','','0000-00-00'),(84,'base',0,'[c;R2:1]1c([*;F,Cl,Br,I,N+X3:2])[c;R2:3][c;R2:4][c;R2:5]c1[NX3]([*:6])[*:7]>>[c;R2:1]1c([*;F,Cl,Br,I,N+X3:2])[c;R2:3][c;R2:4][c;R2:5]c1[NH+]([C:6])[C:7]','exclude halogenated tertary aniline','','','0000-00-00'),(85,'base',0,'[c;R2:1]1[c;R2:2]c([*;F,Cl,Br,I,N+X3:3])[c;R2:4][c;R2:5]c1[NX3]([C:6])[C:7]>>[c;R2:1]1[c;R2:2]c([*;F,Cl,Br,I,N+X3:3])[c;R2:4][c;R2:5]c1[NH+]([C:6])[C:7]','exclude halogenated tertary aniline','','','0000-00-00'),(86,'base',7,'[c;R2:1]1[c;R2:2][nX2][c;R2:4][n:5]1>>[c;R2:1]1[c;R2:2][nH+][c;R2:4][n:5]1','imidazole','','','0000-00-00'),(87,'base',0,'[c;R2:1]1[c;R2:2][n:6][c;R2:4]([*;F,Cl,Br,I,N+X3:5])n1>>[c;R2:1]1[c;R2:2][n:6][c;R2:4]([*;F,Cl,Br,I,N+X3:5])[nH+]1','exclude halogenated imidazole','','','0000-00-00'),(88,'base',0,'[*;F,Cl,Br,I,N+X3:5][c;R2:1]1[c;R2:2]n[c;R2:4][n:6]1>>[*;F,Cl,Br,I,N+X3:5][c;R2:1]1[c;R2:2][nH+][c;R2:4][n:6]1','exclude halogenated imidazole','','','0000-00-00'),(89,'base',0,'[*;F,Cl,Br,I,N+X3:5][c;R2:1]1[c;R2:2][n:6][c;R2:4]n1>>[*;F,Cl,Br,I,N+X3:5][c;R2:1]1[c;R2:2][n:6][c;R2:4][nH+]1','exclude halogenated imidazole','','','0000-00-00'),(92,'base',5,'[c;R2:1]1[nX2][c;R2:3][c;R2:4][c;R2:5][c;R2:6]1>>[c;R2:1]1[nH+][c;R2:3][c;R2:4][c;R2:5][c;R2:6]1','pyridine','','','0000-00-00'),(93,'base',6,'[c;R2:1]1[nX2][c;R2:3][c;R2:4]([NX3:7])[c;R2:5][c;R2:6]1>>[c;R2:1]1[nH+][c;R2:3][c;R2:4]([NX3:7])[c;R2:5][c;R2:6]1','3-aminopyridine','','','0000-00-00'),(94,'base',7,'[c;R2:1]1[nX2][c;R2:3]([NX3:7])[c;R2:4][c;R2:5][c;R2:6]1>>[c;R2:1]1[nH+][c;R2:3]([NX3:7])[c;R2:4][c;R2:5][c;R2:6]1','2-aminopyridine','','','0000-00-00'),(95,'base',6,'[c;R2:1]1[nX2][c;R2:3][c;R2:4][c;R2:5](O[C:7])[c;R2:6]1>>[c;R2:1]1[nH+][c;R2:3][c;R2:4][c;R2:5](O[C:7])[c;R2:6]1','4-methoxypyridine','','','0000-00-00'),(96,'base',5,'[c;R2:1]1[nX2][nX2][c;R2:4]([NX3:7])[c;R2:5][c;R2:6]1>>[c;R2:1]1[nH+][nX2][c;R2:4]([NX3:7])[c;R2:5][c;R2:6]1','3-aminopyridazine','','','0000-00-00'),(97,'base',6,'[c;R2:1]1[nX2][nX2][c;R2:4][c;R2:5]([NX3:7])[c;R2:6]1>>[c;R2:1]1[nH+][nX2][c;R2:4][c;R2:5]([NX3:7])[c;R2:6]1','4-aminopyridazine','','','0000-00-00'),(98,'base',3,'[c;R2:1]1[nX2][c;R2:4]([NX3:7])[c;R2:5][nX2][c;R2:6]1>>[c;R2:1]1[nH+][c;R2:4]([NX3:7])[c;R2:5][nX2][c;R2:6]1','2-aminopyrazine','','','0000-00-00'),(99,'base',5,'[c;R2:1]1[nX2][c;R2:3][nX2][c;R2:5]([NX3:7])[c;R2:6]1>>[c;R2:1]1[nH+][c;R2:3][nX2][c;R2:5]([NX3:7])[c;R2:6]1','4-aminopyrimidine','','','0000-00-00'),(100,'base',6,'[c:1]1[nX2][c:3]([NX3:7])[nX2][c:5]([NX3:8])[c:6]1>>[c:1]1[nH+][c:3]([NX3:7])[nX2][c:5]([NX3:8])[c:6]1','2,4-aminopyrimidine','','','0000-00-00'),(101,'base',0,'[*;F,Cl,Br,I,N+X3:8][a;R2:1]1[nX2][a;R2:3][a;R2:4][a;R2:5][a;R2:6]1>>[*;F,Cl,Br,I,N+X3:8][a;R2:1]1[nH+][a;R2:3][a;R2:4][a;R2:5][a;R2:6]1','exclude basic 6-rings','','','0000-00-00'),(102,'base',0,'[a;R2:1]1[nX2][a;R2:3][a;R2:4]([*;F,Cl,Br,I,N+X3:8])[a;R2:5][a;R2:6]1>>[a;R2:1]1[nH+][a;R2:3][a;R2:4]([*;F,Cl,Br,I,N+X3:8])[a;R2:5][a;R2:6]1','exclude basic 6-rings','','','0000-00-00'),(103,'base',0,'[a;R2:1]1[nX2][a;R2:3][a;R2:4][a;R2:5]([*;F,Cl,Br,I,N+X3:8])[a;R2:6]1>>[a;R2:1]1[nH+][a;R2:3][a;R2:4][a;R2:5]([*;F,Cl,Br,I,N+X3:8])[a;R2:6]1','exclude basic 6-rings','','','0000-00-00'),(104,'base',9,'[c;R2:1]1[nX2][c;R2:3][c;R2:4][c;R2:5]([NX3:7])[c;R2:6]1>>[c;R2:1]1[nH+][c;R2:3][c;R2:4][c;R2:5]([NX3:7])[c;R2:6]1','4-aminopyridine, because 4-aminopyrimidine is so bacic, this rule is below the exlcusion rules for all the halogenated stuff','','','0000-00-00'),(105,'base',5,'s1[c;R2:2]([NH2:7])[nX2][c;R2:4][c;R2:5]1>>s1[c;R2:2]([NH2:7])[nH+][c;R2:4][c;R2:5]1','2-amino-thiazole_one','','CM','2007-10-17'),(2,'base',20,'[*;C,c,N+0,n+0:1][O-]>>[*:1]O','neutralize acids / alcohols, but not n-oxids','','','0000-00-00'),(3,'base',20,'[*:1][NH3+]>>[*:1][NH2]','neutralize amines','','','0000-00-00'),(4,'base',20,'[*:1][NH2+][*:2]>>[*:1][NH][*:2]','neutralize sec. amines','','','0000-00-00'),(5,'base',20,'[*:1][NH+]([*:2])[*:3]>>[*:1]N([*:2])[*:3]','neutralize tert. amines','','','0000-00-00'),(6,'base',20,'[*:1][nH+][*:2]>>[*:1]:n:[*:2]','neutralize aromatic amines','','','0000-00-00'),(7,'base',20,'[*:1][SX1-]>>[*:1]S','neutralize thiols','','','0000-00-00'),(8,'base',20,'[*,a,A:1]N(=O)[OH]>>[*,a,A:1][N+](=O)[O-]','standardize nitro groups','','','0000-00-00'),(10,'base',20,'[*:1]=[NH+][*:2]>>[*:1]=[N+0][*:2]','deprotonate N.2 nitrogens, this rule inverts stereocentres, I have no clue how to keep them','','RB','2008-02-11'),(70,'base',12,'[N+0:1][C:3](=[NH+1][*;O,S,P,N,n,c,CX3,CX2:4])>>[N:1][C:3](=[NH0][*:4])','rescue amidine, guanidine, double because of same strange compounds','','','0000-00-00'),(69,'base',12,'[*;O,S,P,N,n,c,CX3,CX2:4][N+0:1][C:3](=[NH+1][C:2])>>[*:4][N:1][C:3](=[N+0][C:2])','rescue amidine, guanidine, double because of same strange compounds','','','0000-00-00'),(68,'base',12,'[*;O,S,P,N,n,c,CX3,CX2:4][N+0:1][C:3](=[NH2+1])>>[*:4][N:1][C:3](=[NH+0])','rescue amidine, guanidine, double because of same strange compounds','','','0000-00-00'),(1,'base',20,'[*:1][n-][*:2]>>[*:1][nH][*:2]','neutralize tetrazoles, ...','','','0000-00-00'),(11,'base',20,'[*:1]=[NH2+]>>[*:1]=N','deprotonate N.2 nitrogens','','','0000-00-00'),(13,'base',20,'[*,a,A:1][S+](=O)([O-])[*,a,A:2]>>[*,a,A:1][S+0](=O)(=O)[*,a,A:2]','standardize S(=O)(=O)','','RB','2007-04-27'),(14,'base',20,'[*,a,A:1][SX3+]([O-])[*,a,A:2]>>[*,a,A:1][S+0](=O)[*,a,A:2]','standardize S(=O)','','RB','2007-04-27'),(15,'base',20,'[*;nR,NR:1](=O)>>[*+1:1][O-]','standardize  N oxides','','RB','2007-04-27'),(106,'base',5,'s1[c;R2:2]([NH:7][CX4:8])[nX2][c;R2:4][c;R2:5]1>>s1[c;R2:2]([NH:7][CX4:8])[nH+][c;R2:4][c;R2:5]1','2-amino-thiazole_two','','CM','2007-10-18'),(107,'base',5,'s1[c;R2:2]([N:7][CX4:8][CX4:9])[nX2][c;R2:4][c;R2:5]1>>s1[c;R2:2]([N:7][CX4:8][CX4:9])[nH+][c;R2:4][c;R2:5]1','2-amino-thiazole_three','','CM','2007-10-18'),(62,'base',12,'[NX3+0:1]C(=[N+0:2][CX4:4])[*;c,C:3]>>[N:1]C(=[N+:2]([H])[C:4])[*;c,C:3]','sub amidine','','RB','2008-02-08'),(64,'base',12,'[NX3+0!R:1][C!R:5](=[NH+0!R])[N!R:3]>>[N:1][C:5](=[NH2+])[*:3]','non-cyclic guanidine, primary, added','','RB','2008-07-04'),(90,'base',5,'[c:1]1[c:2][c:3]c2c([c:4]1)[nR2:5][c:6][nX2R2]2>>[c:1]1[c:2][c:3]c2c([c:4]1)[n:5][c:6][nH+]2','benzimidazole, but not adenine','','RB','2009-02-13'),(91,'base',0,'[a:1]1[a:2][a:3]c2c([a:4]1)[n:5][c:6]([*;F,Cl,Br,I:7])[nX2]2>>[a:1]1[a:2][a:3]c2c([a:4]1)[n:5][c:6]([*;F,Cl,Br,I:7])[nH+]2','exclude halogenated benzimidazole','','RB','2009-02-13');
/*!40000 ALTER TABLE `definition_prot_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `definition_tautomer_rules`
--

DROP TABLE IF EXISTS `definition_tautomer_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `definition_tautomer_rules` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `direction` int(11) NOT NULL DEFAULT '0' COMMENT '0: always both directions => imidazoles, pyrazoles (if only to nitrogen atoms are involved);\n0.5 : forward if unique, else both; \n1: only forward ',
  `type` varchar(15) NOT NULL DEFAULT '' COMMENT 'equal/unequal\nif the product has the same bonds as the educt (e. g. imidazole, but not keto enole)=> forward and backward rules means simply that the input smiles has to be kept => marke them with equal, all other are unequal\n',
  `smirks` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `kek` tinyint(1) NOT NULL DEFAULT '0',
  `gif` varchar(50) NOT NULL DEFAULT '',
  `date_of_update` date NOT NULL DEFAULT '0000-00-00' COMMENT 'To carry the date this was last updated',
  `updated_by` char(3) NOT NULL DEFAULT '',
  `known_error_string` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=461 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `definition_tautomer_rules`
--

LOCK TABLES `definition_tautomer_rules` WRITE;
/*!40000 ALTER TABLE `definition_tautomer_rules` DISABLE KEYS */;
INSERT INTO `definition_tautomer_rules` VALUES (117,0,'equal','[c:1]1[c:2][nX2][cH][nH]1>>[c:1]1[c:2][nH][cH][nX2]1','imidazole',0,'br.gif','0000-00-00','',''),(118,0,'equal','[c:1]1[c:2][nX2]c([*:4])[nH]1>>[c:1]1[c:2][nH]c([*:4])[nX2]1','imidazole, not if C=0',0,'bs.gif','0000-00-00','',''),(119,1,'unequal','[C:1]1=[C:2]S[C:3]2[N:4]1[C:5](=[C:6]([N+:7]=2))>>[c:1]1[c:2]s[c:3]2[n+:4]1[c:5]([c:6]([n+0:7]2))','imidazothiazole',0,'bt.gif','2009-07-17','RB',''),(120,1,'unequal','[OH]c1[nX2]c([OH])[nX2]c([OH])[c:1]1>>O=C1[NH]C(=O)[NH]C(=O)[C:1]1[H]','barbituric acid',0,'bu.gif','0000-00-00','',''),(122,1,'unequal','[OH][C:1]=[N!+X2:2]>>O=[C:1][N:2][H]','amid bond',0,'','0000-00-00','',''),(123,1,'unequal','[SH][C:1]=[N!+X2:2]>>S=[C:1][N:2][H]','thio-amid bond',0,'','0000-00-00','',''),(124,1,'unequal','O=[S:1][NX2]=[C:3][NH][C:4]>>O=[S:1][NH][C:3]=[N][C:4]','conjucated sulfonamid bond',0,'','0000-00-00','',''),(126,1,'unequal','[OH][cr6]([R:1])[nR!+X2][R:2]>>O=C(-[*:1])-n([H])-[*:2]','\'aromatic\' amid bond, mod, might cause errors with some heterocycles',0,'bw.gif','2009-07-02','RB',''),(127,1,'unequal','[SH][cr6:1][nR!+X2:2]>>S=[c:1][n:2]([H])','\'aromatic\' thio-amid bond, mod,  might cause errors with some heterocycles',0,'bx.gif','2009-07-02','RB',''),(146,1,'unequal','O=C1[NH]C(=O)[CH2]-[C:2]=[C:3]1>>O=C1[NH]C(O)=C-[C:2]=[C:3]-1','rescue acids, amids, 6 ring',1,'bz.gif','2009-07-17','RB','x'),(129,0,'unequal','[C:1]1=C([OH])[NH]C(=O)[C:5]=[*:6]1>>[c:1]1c([OH])[nX2]c([OH])[c:5][a:6]1','2,6-dihydroxy--pyridines/pyrazines 2',1,'ca.gif','2009-07-20','RB',''),(130,0,'unequal','[C:1]1=C([OH])[NH]C(=O)[C:5]=[*:6]1>>[C:1]1-C(=O)[NH]C([OH])=[C:5]-[*:6]=1','2,6-dihydroxy-pyridines/pyrazines 1',1,'cb.gif','2009-07-20','RB',''),(125,1,'unequal','[O,S:6]=[CR:1][CR,NR:2]=[CR,NR:3][NRH]-[R&!$(C=[O,S]):5]>>[H][*:6]-[*:1]=[*:2]-[*:3]=[n!+X2]-[a:5]','\'aromatic\' conjucated (thio)-amid bond, must come before aromatic amid bond',0,'bm.gif','2009-07-17','RB',''),(14,1,'unequal','O=C1C(=[C:3][NH][*:4])-[C,N,c:1]=,:[C,N,c:2]-[C,N,c:5]=,:[C,N,c:6]-1>>[OH]c1:[cH0](-[C:3]=[N][*:4]):[a:1]:[a:2]:[a:5]:[a:6]:1','keto imine (needed for NIH), ortho, sec',0,'bn.gif','2009-07-01','RB','x'),(142,0,'equal','[c:1]1[c:2][nX2][nH][c:5]1>>[c:1]1[c:2][nH][nX2][c:5]1','pyrazole 1',0,'','0000-00-00','',''),(143,0,'unequal','[OH]c1[nX2][nH][c:2][c:3]1>>O=c1[nH][nH][c:2][c:3]1','pyrazolol',0,'','0000-00-00','',''),(144,1,'unequal','[C:2]=[C:3]([*;O,NH,NH2:4])[OH]>>[C:2]([H])[C:3](=O)[*;O,N:4]','acids, amids',0,'','2009-07-07','RB',''),(147,1,'unequal','[C:2]=[C:3]([*;O,NH,NH2:4])[SH]>>[C:2]([H])[C:3](=S)[*;O,N:4]','acids, amids (thio)',0,'','2009-07-07','RB',''),(148,0,'unequal','[C:2]=[C:3]([OH])[!N&!O:4]>>[C:2]([H])[C:3](=O)[!N&!O:4]','keto-enol',0,'','2009-07-07','RB',''),(149,1,'unequal','[C:2]=[C:3][SH]>>[C:2]([H])[C:3](=S)','thio keto-enol',0,'','0000-00-00','',''),(152,0,'unequal','[*;c,C:4][C:1](=O)[CH]=[C:3]([OH])[*;c,C:5]>>[*;c,C:4][C:1](=O)[CH2][C:3](=O)[*;c,C:5]','diketo, 2x H',0,'','0000-00-00','',''),(153,0,'unequal','[*;c,C:4][C:1](=O)C([C:2])=[C:3]([OH])[*;c,C:5]>>[*;c,C:4][C:1](=O)[CH]([C:2])[C:3](=O)[*;c,C:5]','diketo, 1x H',0,'','0000-00-00','',''),(154,0,'equal','[!N&!O:4][C:1](=O)[C:2]=[C:3][OH]>>[!N&!O:4][C:1]([OH])=[C:2][C:3](=O)','diketo',0,'','0000-00-00','',''),(155,1,'unequal','[C;R0:1]=[C;R0:2][NH][C;R0:4]=[C;R0:5]>>[C;R0:1]=[C;R0:2]N=[C;R0:4][C;R0:5][H]','diethylenamine 1',0,'','0000-00-00','',''),(156,0,'unequal','[C;R0:1]=[C;R0:2]N=[C;R0:4][CH2][C:5]>>[H][C;R0:1][C;R0:2]=N[C;R0:4]=[CH][C:5]','diethylenamine 3',0,'','0000-00-00','',''),(157,0,'unequal','[C;R0:1]=[C;R0:2]N=[C;R0:4][CH]([C:5])[C:6]>>[H][C;R0:1][C;R0:2]=N[C;R0:4]=C([C:5])[C:6]','diethylenamine 4',0,'','0000-00-00','',''),(158,0,'unequal','[c:1]1[c:2][nH][nX2][nX2]1>>[c:1]1[c:2][nX2][nH][nX2]1','[1,2,3]triazole',0,'','2007-11-09','RB',''),(159,0,'equal','[c:1]1[c:2][nH][nX2][nX2]1>>[c:1]1[c:2][nX2][nX2][nH]1','[1,2,3]triazole',0,'','2007-11-09','RB',''),(162,0,'equal','[c:1]1[c:2][nH+][c:3][nX2][c:4]1>>[c:1]1[c:2][nX2][c:3][n+]([H])[c:4]1','pyrimidine',0,'','0000-00-00','',''),(163,0,'equal','[C:1]1[CX4:2][NH2+][CX4:3][NHX3][CX4:4]1>>[C:1]1[CX4:2][N][CX4:3][N+]([H])([H])[CX4:4]1','hexa-hydro-pyrimidine (sec-sec)',0,'','0000-00-00','',''),(164,0,'equal','[C:1]1[CX4:2][NH+]([CX4:6])[CX4:3][NHX3][CX4:4]1>>[C:1]1[CX4:2][N]([CX4:6])[CX4:3][N+]([H])([H])[CX4:4]1','hexa-hydro-pyrimidine (tert-sec)',0,'','0000-00-00','',''),(165,0,'equal','[C:1]1[CX4:2][NH+]([CX4:6])[CX4:3][NX3]([CX4:7])[CX4:4]1>>[C:1]1[CX4:2][N]([CX4:6])[CX4:3][N+]([CX4:7])([H])[CX4:4]1','hexa-hydro-pyrimidine (tert-tert)',0,'','0000-00-00','',''),(166,0,'equal','[CX4:1]1[NH2+][CX4:2][CX4:3][NHX3][CX4:4]1>>[CX4:1]1N[CX4:2][CX4:3][N+]([H])([H])[CX4:4]1','hexa-hydro-pyrimidine (sec-sec)',0,'','0000-00-00','',''),(167,0,'equal','[CX4:1]1[NH+]([CX4:6])[CX4:2][CX4:3][NHX3][CX4:4]1>>[CX4:1]1N([CX4:6])[CX4:2][CX4:3][N+]([H])([H])[CX4:4]1','hexa-hydro-pyrimidine (tert-sec)',0,'','0000-00-00','',''),(168,0,'equal','[CX4:1]1[NH+]([CX4:6])[CX4:2][CX4:3][NX3]([CX4:7])[CX4:4]1>>[CX4:1]1N([CX4:6])[CX4:2][CX4:3][N+]([CX4:7])([H])[CX4:4]1','hexa-hydro-pyrimidine (tert-tert)',0,'','0000-00-00','',''),(169,1,'unequal','[c:1]1[c:2][nX2]c(=O)[nH]c1[N:3]>>[c:1]1[c:2][nH]c(=O)[nX2]c1[N:3]','cytosine',0,'','0000-00-00','',''),(170,0,'unequal','[HO]c1[c:2][c:3]o[nX2]1>>O=c1[c:2][c:3]o[nH]1','isoxazole',0,'','0000-00-00','',''),(171,0,'unequal','[c:1]1[c:2]c([HO])o[nX2]1>>[c:1]1[c:2]c(=O)o[nH]1','isoxazole 2',0,'','0000-00-00','',''),(172,0,'unequal','[HO]c1[c:2][c:3][sX2][nX2]1>>O=c1[c:2][c:3][sX2][nH]1','isothiazole',0,'','0000-00-00','',''),(173,0,'unequal','[c:1]1[c:2]c([HO])[sX2][nX2]1>>[c:1]1[c:2]c(=O)[sX2][nH]1','isothiazole 2',0,'','0000-00-00','',''),(174,1,'unequal','[CH2]1C(=O)[NX2]=[C:2]S1>>[CH]1=C(O)[NX2]=[C:2]S1','thiazole',0,'','0000-00-00','',''),(175,1,'unequal','[*:1][CH]1C(=O)[NX2]=[C:2]S1>>[*:1]C1=C(O)[NX2]=[C:2]S1','thiazole',0,'','0000-00-00','',''),(176,0,'unequal','[OH]c1[nX2][nX2]c([OH])[c:1][c:2]1>>O=c1[nH!+][nH!+]c(=O)[c:1][c:2]1','6-hydroxypyridazine 1',0,'','0000-00-00','',''),(177,0,'unequal','[OH]c1[nX2][nX2]c([OH])[c:1][c:2]1>>O=c1[nH][nX2]c([OH])[c:1][c:2]1','6-hydroxypyridazine 2',0,'','0000-00-00','',''),(178,0,'equal','O=c1[nH][nX2]c([OH])[c:1][c:2]1>>[OH]c1[nX2][nH]c(=O)[c:1][c:2]1','6-hydroxypyridazine 4',0,'','0000-00-00','',''),(179,0,'equal','[c:1]1[nH+]n[c:4][c:5][c:6]1>>[c:1]1n[nH+][c:4][c:5][c:6]1','charged pyridazine',0,'','0000-00-00','',''),(180,0,'equal','[c;R2:1]1[c;R2:2][c;R2:3]([NH2])[c;R2:4][c;R2:5]c1[NH3+]>>[c;R2:1]1[c;R2:2][c;R2:3]([NH3+])[c;R2:4][c;R2:5]c1[NH2]','1,4 diaminobenzene, primary',0,'','0000-00-00','',''),(181,0,'equal','[c;R2:1]1[c;R2:2][c;R2:3]([NH][CX4:6])[c;R2:4][c;R2:5]c1[NH3+]>>[c;R2:1]1[c;R2:2][c;R2:3]([NH+]([CX4:6])[H])[c;R2:4][c;R2:5]c1[NH2]','1,4 diaminobenzene, primary',0,'','0000-00-00','',''),(182,0,'equal','[c;R2:1]1[c;R2:2][c;R2:3]([N+0]([CX4:6])[CX4:7])[c;R2:4][c;R2:5]c1[NH3+]>>[c;R2:1]1[c;R2:2][c;R2:3]([N+]([CX4:6])([CX4:7])[H])[c;R2:4][c;R2:5]c1[NH2]','1,4 diaminobenzene, primary',0,'','0000-00-00','',''),(183,0,'equal','[c;R2:1]1[c;R2:2][c;R2:3]([NH2])[c;R2:4][c;R2:5]c1[NH2+][C:7]>>[c;R2:1]1[c;R2:2][c;R2:3]([NH3+])[c;R2:4][c;R2:5]c1[NH][CX4:7]','1,4 diaminobenzene, secondary amines',0,'','0000-00-00','',''),(184,0,'equal','[c;R2:1]1[c;R2:2][c;R2:3]([NH][CX4:6])[c;R2:4][c;R2:5]c1[NH2+][C:7]>>[c;R2:1]1[c;R2:2][c;R2:3]([NH+]([CX4:6])[H])[c;R2:4][c;R2:5]c1[NH][CX4:7]','1,4 diaminobenzene, secondary amines',0,'','0000-00-00','',''),(185,0,'equal','[c;R2:1]1[c;R2:2][c;R2:3]([N+0]([CX4:6])[CX4:7])[c;R2:4][c;R2:5]c1[NH2+][C:8]>>[c;R2:1]1[c;R2:2][c;R2:3]([N+]([CX4:6])([CX4:7])[H])[c;R2:4][c;R2:5]c1[NH][CX4:8]','1,4 diaminobenzene, secondary amines',0,'','0000-00-00','',''),(186,0,'equal','[c;R2:1]1[c;R2:2][c;R2:3]([NH2])[c;R2:4][c;R2:5]c1[NH+]([C:7])[C:8]>>[c;R2:1]1[c;R2:2][c;R2:3]([NH3+])[c;R2:4][c;R2:5]c1[N]([CX4:7])[CX4:8]','1,4 diaminobenzene, tertiary',0,'','0000-00-00','',''),(187,0,'equal','[c;R2:1]1[c;R2:2][c;R2:3]([NH][CX4:6])[c;R2:4][c;R2:5]c1[NH+]([C:7])[C:8]>>[c;R2:1]1[c;R2:2][c;R2:3]([NH+]([CX4:6])[H])[c;R2:4][c;R2:5]c1[N]([CX4:7])[CX4:8]','1,4 diaminobenzene, tertiary',0,'','0000-00-00','',''),(188,0,'equal','[c;R2:1]1[c;R2:2][c;R2:3]([N+0]([CX4:6])[CX4:9])[c;R2:4][c;R2:5]c1[NH+]([C:7])[C:8]>>[c;R2:1]1[c;R2:2][c;R2:3]([N+]([CX4:6])([CX4:9])[H])[c;R2:4][c;R2:5]c1[N]([CX4:7])[CX4:8]','1,4 diaminobenzene, tertiary',0,'','0000-00-00','',''),(2,1,'unequal','[NX2R,SX2R,OX2R,CX3R:1][NH][CR,NR:2]=[CR,NR:3][CR:4](=[N!R:5])>>[*:1]N=[*:2]-[*:3]=[C:4]([N:5][H])','conjugated imine > aromatic ring',1,'at.gif','2009-07-07','RB','x'),(193,1,'unequal','[C:1]1(=[N;R0])[C,N:2]=[C,N:3][NH][C,N:4]=[C,N]1>>[c:1]([NHR0])1[c,n:2][c,n:3]n[c,n:4][c,n]1','pyridinylideamine correction',0,'','2007-04-09','CPM',''),(195,0,'equal','[*:1][cR2]1[nX2][nH][nX2][nX2]1>>[*:1]c1[nH][nX2][nX2][nX2]1','tetrazole, needed for core fragments',0,'','2009-07-09','RB',''),(161,0,'equal','[c:1]1[nX2][c:2][nX2][nH]1>>[c:1]1[nX2][c:2][nH][nX2]1','[1,2,4]triazole',0,'','2007-11-09','RB',''),(160,0,'unequal','[c:1]1[nX2][c:2][nX2][nH]1>>[c:1]1[nH][c:2][nX2][nX2]1','[1,2,4]triazole',0,'','2007-11-09','RB',''),(139,0,'equal','[NH2][CR:1]=[NX2R][CR:2]=[NHR0]>>[NH]=[CR:1][NX2R]=[CR:2][NH2]','conjugated primary imin attached to ring',0,'aw.gif','2009-11-09','RB',''),(140,1,'unequal','[*:3][NHR0][CR:1]=[NX2R][CR:2]=[NHR0]>>[*:3]N=[CR:1][NX2R]=[CR:2][NH2]','conjugated primary/sec imin attached to ring -> always free amine gets both hydrogens',0,'ax.gif','2009-09-09','RB',''),(141,0,'equal','[*:3][NHR0][CR:1]=[NX2R][CR:2]=[NR0][*:4]>>[*:3]N=[CR:1][NX2R]=[CR:2][NR0]([H])[*:4]','conjugated sec/sec imin attached to ring',0,'ay.gif','2009-07-09','RB',''),(191,0,'equal','[O,S:4]=C1[NX2]=[C,NX2:1]-[C,NX2:2]=[C,NX2:3]-[NH]1>>[O,S:4]=C1[NH]-[C,NX2:1]=[C,NX2:2]-[C,NX2:3]=[NX2]1','pyridinone',1,'ar.gif','2009-07-02','RB',''),(12,1,'unequal','O=C1[C,N,c:1]=,:[C,N,c:2]C(=[C:3][NH][*:4])[C,N:5]=[C,N:6]1>>[OH][caH0]1-[a:1]=[a:2]-[caH0]([C:3]=N[*:4])=[a:5]-[a:6]=1','keto imine (needed for NIH) (explicit double bonds needed to work properly)',0,'ao.gif','2008-07-01','RB',''),(13,1,'unequal','O=C1C(=[C:3][NH2])-[C,N,c:1]=,:[C,N,c:2]-[C,N,c:5]=,:[C,N,c:6]-1>>[OH]c1:[cH0](-[C:3]=[NH]):[a:1]:[a:2]:[a:5]:[a:6]:1','keto imine (needed for NIH), ortho, primary',0,'ap.gif','2009-07-01','RB',''),(15,1,'unequal','O=C1[C,N,c:1]=,:[C,N,c:2]C(=C2[C,N:4]=[C,N:5][NH][*:6]~[*:9]~2)[C,N,c:7]=,:[C,N,c:8]1>>[OH][caH0]1:[a:1]:[a:2]:[caH0](-[ca]2=[a:4]-[a:5]=n-[a:6]=[a:9]-2):[a:7]:[a:8]:1','keto imine (needed for NIH) para, conjugated 6 ring',1,'bo.gif','2008-07-01','RB',''),(16,1,'unequal','O=C1C(=C2[C,N:4]=[C,N:5][NH][*:6]~[*:9]~2)[C,N:1]=[C,N:2][C,N:7]=[C,N:8]1>>[OH][caH0]1=[caH0](-[ca]2=[a:4]-[a:5]=n-[a:6]=[a:9]-2)-[a:1]=[a:2]-[a:7]=[a:8]-1','keto imine (needed for NIH) ortho, conjugated 6 ring',1,'bp.gif','2008-07-01','RB',''),(17,1,'unequal','O=C1[C,N:1]=[C,N:2]C(=C2[C,N:4]=[C,N:5][NH][*:6]~2)[C,N:7]=[C,N:8]1>>[OH][caH0]1-[a:1]=[a:2]-[caH0](-[ca]2=[a:4]-[a:5]=n-[a:6]:2)=[a:7]-[a:8]=1','keto imine (needed for NIH) para, conjugated 5 ring',1,'','2008-07-01','RB',''),(18,1,'unequal','O=C1C(=C2[C,N:4]=[C,N:5][NH][*:6]~2)[C,N:1]=[C,N:2][C,N:7]=[C,N:8]1>>[OH][caH0]1=[caH0](-[ca]2=[a:4]-[a:5]=n-[a:6]:2)-[a:1]=[a:2]-[a:7]=[a:8]-1','keto imine (needed for NIH) ortho, conjugated 5 ring',1,'','2008-07-01','RB',''),(19,1,'unequal','[C:1]1[C,N:2]~[C,N:3]N=C2N1[N,C:4]=[C,N:5][NH]2>>[*:1]1[*:2]~[*:3][nH]:c2n1[a:4][a:5]n2','fused 5ring-6ring, N in bridge, taut1',1,'b.gif','2008-07-02','RB',''),(20,1,'unequal','[C:1]1[C,N:2]~[C,N:3]N=C2N1[NH][C,N:4]=[N,C:5]2>>[*:1]1[*:2]~[*:3][nH]:c2n1-n=[a:4]-[a:5]=2','fused 5ring-6ring, N in bridge, taut2',1,'bb.gif','2008-07-02','RB',''),(25,1,'unequal','[O,S:10]=C1-[C,N:1]=[C,N:2]C(=[C:3][NH,NH2:4])[C,N:5]=[C,N:6]1>>[H]-[*:10]-C1-[a:1]=[a:2]-[caH0]([C:3]=[N:4])=[a:5]-[a:6]=1','fused 5ring-6ring, N in bridge, taut1, aromatic',0,'cc.gif','2009-07-03','RB',''),(57,1,'unequal','[*:4][NH+0]-C([!N:1])=[NH0+0][$(C=[O,S]):2][!N:3]>>[*:4]N=C([*:1])-[NH][*:2][*:3]','rescue amidine-amid',0,'bh.gif','2009-07-08','RB','x'),(32,1,'unequal','[c,C:1]1=[NX2]C(=O)C([NH2])=[C,c:2]-1>>[*:1]1[NH]-C(=O)-C(=[NH])-[*:2]=1','pyrol-amid-imine(primary)',0,'bd.gif','2008-07-03','RB',''),(33,1,'unequal','[c,C:1]1=[NX2]C(=O)C([NH][*:3])=[C,c:2]-1>>[*:1]1N-C(=O)-C(=N[*:3])-[*:2]=1','pyrol-amid-imine(secondary)',0,'be.gif','2008-07-03','RB',''),(35,1,'unequal','[c,C:1]1=NC(=[O,S:10])C([NH][*:3])=[C,c:2]1>>[*:1]1N-C(=[*:10])-C(=N[*:3])-[*:2]1','pyrol-amid-imine(secondary), fused',0,'bf.gif','2008-07-03','RB',''),(34,1,'unequal','[c,C:1]1=NC(=[O,S:10])C([NH2])=[C,c:2]1>>[*:1]1[NH]-C(=[*:10])-C(=[NH])-[*:2]1','pyrol-amid-imine(primary), fused',0,'bg.gif','2008-07-03','RB',''),(38,1,'unequal','[NH+0]=C([NH+0][!$(C=[O,S]):1])[N+0:2]>>[NH2]C=(N[*:1])[N:2]','guanidine, if possible, make NH2',0,'','2008-07-03','RB',''),(41,0,'equal','[NH+0]([*:3])[C!R](=[N+0][*:1])[NH+0][!$(C=[O,S]):2]>>[NH]([*:3])[C!R]([NH][*:1])=N[*:2]','guanidine, NH(R),NH',0,'','2009-07-03','RB',''),(39,0,'equal','[NH2+0]C(=[N+0][*:1])[NH+0][!$(C=[O,S]):2]>>[NH2]C([NH][*:1])=N[*:2]','guanidine, NH2,NH',0,'','2008-07-03','RB',''),(40,0,'equal','[N+0]([*:3])([*:4])C(=[N+0][*:1])[NH+0][!$(C=[O,S]):2]>>N([*:3])([*:4])C([NH][*:1])=N[*:2]','guanidine, N(R)(R),NH',0,'','2008-07-03','RB',''),(48,0,'equal','[NH+0]([!$(C=[O,S]):3])C(=[N+0][*:1])[NH+0][!$(C=[O,S]):2]>>N([*:3])=C([NH][*:1])N[*:2]','guanidine, NH(R),NH, other option',0,'','2008-07-03','RB',''),(42,1,'unequal','[O,S:3]=[C:1][N+0]=C([NH2+0])[N+0:2]>>[*:3]=[C:1][NH]C(=[NH])[N:2]','standardize primary amid-guanidines',0,'','2008-07-04','RB',''),(43,1,'unequal','[O,S:3]=C([O,o,C,c,S,s:1])[N+0]=C([NH+0][*:4])[N+0:2]>>[*:3]=C([*:1])[NH]C(=N[*:4])[N:2]','standardize secondary amid-guanidines',0,'','2009-07-04','RB',''),(49,0,'equal','[N+1!H2:1]=C([N+0:2][*:3])[N+0:4][*:5]>>[N+0:1]C(=[N+1:2][*:3])[N+0:4][*:5]','charged guanidine RNH+=C(N)(N)',0,'','2008-07-04','RB',''),(50,0,'equal','[N+1!H2:1]=C([N+0:2][*:3])[N+0:4][*:5]>>[N+0:1]C([N+0:2][*:3])=[N+1:4][*:5]','charged guanidine RNH+=C(N)(N), double bond other side',0,'','2008-07-04','RB',''),(58,1,'unequal','[O,S:1]=[CR:4][NR]=[CR:2][NHR][R:3]>> [O,S:1]=[CR:4][NR]([H])[CR:2]=N[R:3]','rescue heterocycles',0,'','2009-07-04','RB',''),(52,1,'unequal','[S,O:10]=[C:1][NH+1]=C([N+0:3][!$(C=[O,S]):4])([N+0:5])>>[*:10]=[C:1][NH]C(=[N+1:3][*:4])([N+0:5])','rescue guanidine amid, sec',0,'','2008-07-04','RB',''),(53,1,'unequal','[C,c:1]C([NH2])(=[N+1!H2:2])>>[C,c:1]C(=[NH2+])([N+0:2])','amidine, if possible =NH2+',0,'','2008-07-04','RB',''),(138,1,'unequal','[N:5]=C1[C,N:1]=[C,N:2]-[CH2]-[S,N,O:4]1>>[H][N:5]-c1=[a:1]-[a:2]=[CH]-[*:4]1','imine attached to 5 ring, 2xH',0,'av.gif','2008-07-04','RB',''),(137,1,'unequal','[N:5]=C1[C,N:1]=[C,N:2]-[CH]([*:6])-[S,N,O:4]1>>[H][N:5]-c1=[a:1]-[a:2]=C([*:6])-[*:4]1','imine attached to 5 ring, 1xH',0,'au.gif','2008-07-04','RB',''),(60,1,'unequal','[O,S:1]=C1[*;C,N,c:2]=[*;C,N,c:3][CH]([*:4])[*;C,N,c:5]=[*;C,N,c:6]1>>[H][O,S:1]-C1=[*:2]-[*:3]=C(-[*:4])-[*:5]=[*:6]-1','para-phenol,one sub',0,'bi.gif','2008-07-04','RB',''),(64,1,'unequal','[O,S:1]=C1[CH]([*:4])[C,N,c:2]=,:[C,N,c:3][C,N,c:5]=,:[C,N,c:6]1>>[H][O,S:1]-C1=C([*:4])[a:2]=[a:3]-[a:5]=[a:6]-1','ortho-phenol,one sub',0,'bl.gif','2009-07-04','RB',''),(66,0,'equal','[NH]1[C,N:1]=[C,N:2]-[C,N:3]=N[C,N:4]=[N,C:5]1>>N1=[*:1]-[*:2]=[*:3]-[NH]-[*:4]=[*:5]1','7ring,1-4',1,'','2008-07-04','RB',''),(67,0,'equal','[NH]1N=[C,N:2]-[C,N:3]=[N,C:10][C,N:4]=[N,C:5]1>>N1-[NH]-[*:2]=[*:3]-[*:10]=[*:4]-[*:5]=1','7ring,1-2',1,'','2008-07-04','RB',''),(68,0,'equal','[NH]1[C,N:1]=N-[C,N:10]=[C,N:3]-[C,N:4]=[N,C:5]1>>N1=[*:1]-[NH]-[*:10]=[*:3]-[*:4]=[*:5]1','7ring,1-3',1,'','2008-07-04','RB',''),(74,1,'unequal','[c,n:1]1[c,n:2]c(=[O,S:10])[c,n:3]c2oc([c,n:4][c,n:5]c12)[NH2]>>[a:1]1[a:2]c(-[*:10][H])[a:3]c2oc([a:4][a:5]c12)=[NH]','fused phenol=keto, primiary amine',0,'','2008-07-04','RB',''),(75,1,'unequal','[c,n:1]1[c,n:2]c(=[O,S:10])[c,n:3]c2oc([c,n:4][c,n:5]c12)[NH][*:11]>>[a:1]1[a:2]c(-[*:10][H])[a:3]c2oc([a:4][a:5]c12)=N[*:11]','fused phenol=keto, sec amine',0,'','2008-07-04','RB',''),(76,1,'unequal','[NH]=C1[CH2]C(=O)[c,C:2]=,:[c,C:3]C1=O>>[NH2]C1=[CH]C(=O)[*:2][*:3]C1=O','imine, menandione type, unsub',0,'','2008-07-04','RB',''),(77,1,'unequal','[NH]=C1[CH]([*:4])C(=O)[c,C:2]=,:[c,C:3]C1=O>>[NH2]C1=C([*:4])C(=O)[*:2][*:3]C1=O','imine, menandione type, sub',0,'','2008-07-04','RB',''),(78,1,'unequal','[*:10]N=C1[CH2]C(=O)[c,C:2]=,:[c,C:3]C1=O>>[*:10][NH]C1=[CH]C(=O)[*:2][*:3]C1=O','sub imine, menandione type, unsub',0,'','2008-07-04','RB',''),(79,1,'unequal','[*:10]N=C1[CH]([*:4])C(=O)[c,C:2]=,:[c,C:3]C1=O>>[*:10][NH]C1=C([*:4])C(=O)[*:2][*:3]C1=O','sub imine, menandione type, sub',0,'','2008-07-04','RB',''),(31,1,'unequal','[C:1]1N=[C,N:3][C,N:2]=C2N1[NH][C,N:4]=[N,C:5]2>>[*:1]1[nH][*:3]=[*:2]:c2n1-n=[a:4]-[a:5]=2','fused 5ring-6ring, N in bridge, taut2, stereoisomer',1,'a.gif','2008-07-04','RB',''),(11,1,'unequal','O=C1[C,N,c:1]=,:[C,N,c:2]C(=[C:3][NH2])[C,N,c:5]=[C,N:6]1>>[OH][caH0]1-[a:1]=[a:2]-[caH0]([C:3]=[NH])=[a:5]-[a:6]=1','keto imine (needed for NIH) prim amin',0,'ae.gif','2008-07-07','RB',''),(4,0,'equal','[*:1][N+0R]=[CR:2][NH+0R][!$(C=[O,S])&!$(S=O):3]>>[*:1][NH][C:2]=N[*:3]','N=CNH in ring, this is an important rule, change with extreme care!',0,'c.gif','2008-07-07','RB',''),(101,1,'unequal','[C:1]=C1C(=O)[N:2][C:3]=[C:4][NH]1>>[C:1]([H])C1C(=O)[N:2][C:3]=[C:4]N=1','dihydropyrazinone',0,'d.gif','2008-07-07','RB',''),(54,1,'unequal','[!N:3]C(=[NH+0])[NH+0][!$(C=[O,S]):2]>>[*:3]C(=N[*:2])[NH2]','amidine, if possible NH2',0,'f.gif','2009-07-07','RB',''),(55,0,'equal','[*:3][N+0]=C([!N:1])[NH+0][!$(C=[O,S])&!$(S=O):2]>>[!$(C=[O,S])&!$(S=O):3][NH]C([*:1])=N[*:2]','amidine, disub',0,'g.gif','2008-07-07','RB',''),(100,1,'unequal','[c:1]1[c:2]c2[n,c:3]n3[c,n:4][c,n:6][nH]c3[n,c:5]c2n1>>[c:1]1:[c:2]:c:2:[*:3]:n:3:[*:4]:[*:6]:n:c:3:[*:5]:c:2:[nH]:1','5ring-6ring-pyrol',0,'h.gif','2008-07-07','RB',''),(98,1,'unequal','[NH]1[C,N:2]=C2[NH]C(=[S,O:3])[NX2]=C2[C,N:10]=[C,N:4]1>>n1[a:2]c:2:[nH]:c(=[*:3])[nH]c2[a:10][a:4]1','imidazopyridinone 2',0,'j.gif','2009-07-07','RB',''),(116,0,'equal','[nX2]1[c:1][c:2][nH][c:3][c:4]1>>[nH]1[c:1][c:2][nX2][c:3][c:4]1','pyrazine-H, procudes an error for pyridazinones, not nice, but functional',0,'k.gif','2008-07-07','RB',''),(96,0,'equal','[c,n:1]1n2[c,n:3][c,n:4][nH]c2n[c,n:5]1>>[a:1]1n2[a:3][a:4]nc2[nH][a:5]1','diazoloimidazole',0,'l.gif','2008-07-07','RB',''),(95,0,'equal','n1n2[c,n:3][c,n:4][nH]c2[n,c:10][c,n:5]1>>[nH]1n2[a:3][a:4]nc2[a:10][a:5]1','diazoloimidazole 2',0,'m.gif','2008-07-07','RB',''),(94,0,'equal','n1n2[nH][c,n:3][c,n:4]c2[c,n:10][c,n:5]1>>[nH]1n2n[a:3][a:4]c2[a:10][a:5]1','diazoloimidazole 3',0,'n.gif','2009-07-07','RB',''),(93,1,'unequal','[N,C:10]1=[C,N:2][NH]C2=NC(=O)[NH]C(=O)C2=[N,C:3]1>>[a:10]1[a:2]nc2[nH]c(=O)[nH]c(=O)c2[a:3]1','pyridopyrimidinedione',0,'o.gif','2009-07-07','RB',''),(92,1,'unequal','[NH]1[C,N:2]=[C,N:10]C2=NC(=O)[NH]C(=O)C2=[N,C:3]1>>n1[a:2][a:10]c2[nH]c(=O)[nH]c(=O)c2[a:3]1','pyridopyrimidinedione 1',0,'p.gif','2009-07-07','RB',''),(91,1,'unequal','[c,n:1]1[c,n:2]c2[nX2][c,nX2:3][c,n:4]c2[c,nX2:5][nH]1>>[a:1]1[a:2]c2[nH][a:3][a:4]c2[a:5]n1','pyrolopyridine, results in error for amides, not nice but functional',0,'q.gif','2009-01-07','RB',''),(90,1,'unequal','[c,n:1]1[c,n:2]c2[c,n:3][c,n:4][nX2]c2[c,n:5][nH]1>>[a:1]1[a:2]c2[a:3][a:4][nH]c2[a:5]n1','pyrolopyridine 2, results in error for amides, not nice but functional',0,'r.gif','2009-01-07','RB',''),(89,1,'unequal','[c,n:1]1[nH]c2[nX2][c,nX2:3][c,n:4]c2[c,n:5][n,c:10]1>>[a:1]1nc2[nH][a:3][a:4]c2[a:5][a:10]1','pyrolopyridine 3',0,'s.gif','2009-01-07','RB',''),(88,1,'unequal','[c,n+0:1]1[n+0H]c2[c,n+0:3][c,n+0:4][nX2]c2[c,n+0:5][n+0,c:10]1>>[a:1]1nc2[a:3][a:4][n]([H])c2[a:5][a:10]1','pyrolopyridine 4, results in error for amides, not nice but functional',0,'t.gif','2009-01-07','RB',''),(87,1,'unequal','[c,n:1]1[c,n:2]c2c([c,n:3][c,n:4]n2)c3c1[nH]on3>>[a:1]1[a:2]c2c([a:3][a:4][nH]2)c3c1non3','oxatriaatircyclododecapentaene',0,'u.gif','2008-07-07','RB',''),(86,1,'unequal','[c,n:1]1[c,n:2]c2c(n[c,n:4][n,c:10]2)c3c1[nH]on3>>[a:1]1[a:2]c2c([nH][a:4][a:10]2)c3c1non3','oxatriaatircyclododecapentaene 2',0,'v.gif','2008-07-07','RB',''),(85,1,'unequal','[c,n:1]1[c,n:2]c2c([c,n:3]n[c,n:4]2)c3c1[nH]on3>>[a:1]1[a:2]c2c([a:3][nH][a:4]2)c3c1non3','oxatriaatircyclododecapentaene 3',0,'w.gif','2008-07-07','RB',''),(84,1,'unequal','[c,n:1]1[c,n:2]c2c([c,n:3][c,n:4]n2)c3c1no[nH]3>>[a:1]1[a:2]c2c([a:3][a:4]n2)c3c1[nH]on3','oxatriaatircyclododecapentaene, standardize for following rules',0,'x.gif','2009-07-07','RB',''),(102,1,'unequal','[C,N:1]1=[C,N:2][N,C:3]=C2C(=[O,S:6])[N,C:4]=[C,N:5]N=C2[NH]1>>[a:1]1[a:2][a:3]c2c(=[*:6])[a:4][a:5][nH]c2[n]1','pteridine',0,'y.gif','2009-07-07','RB',''),(103,1,'unequal','[C,N:1]1=[C,N:2][N,C:3]=C2C(=[O,S:6])N=[C,N:5][N,C:10]=C2[NH]1>>[a:1]1=[a:2][a:3]=c2c(=[*:6])[nH][a:5]=[a:10]c2=[n]1','pteridine - N',0,'z.gif','2009-07-07','RB',''),(104,1,'unequal','[c,n:1]1[nH][n,c:3]c2c(=[O,S:6])[n,c:4][c,n:5][nX2]c2[n,c:2]1>>[a:1]1n[a:3]c2c(=[*:6])[a:4][a:5][nH]c2[a:2]1','pteridine 2',0,'aa.gif','2008-07-07','RB',''),(105,1,'unequal','[C,N:1]1[NH][N,C:3]=C2C(=[O,S:6])[NX2]=[C,N:5][C,N:10]=C2[N,C:2]=1>>[a:1]1=n[a:3]=c2c(=[*:6])[nH]-[a:5]=[a:10]-c2=[a:2]-1','pteridine 2 - N',0,'ab.gif','2009-07-07','RB',''),(106,1,'unequal','[c,n:1]1[c,n:2]c2c(n1)[n,c:3]c3c([n,c:4]2)[c,n:5][c,n:6][c,n:7][nH]3>>[a:1]1[a:2]c2c([nH]1)[a:3]c3c([a:4]2)[a:5][a:6][a:7]n3','pyrroloquinoline',0,'ac.gif','2008-07-07','RB',''),(107,1,'unequal','[c,n:1]1[c,n:2]c2c(n1)[n,c:3]c3c([n,c:4]2)[c,n:5][nH][c,n:7][n,c:8]3>>[a:1]1[a:2]c2c([nH]1)[a:3]c3c([a:4]2)[a:5]n[a:7][a:8]3','pyrroloquinoline 2',0,'ad.gif','2008-07-07','RB',''),(108,1,'unequal','[C,N:1]1[C,N:2]=C2[C,N:3]=NC(=[N,O,S:4])N2[NH][C,N:5]=1>>[a:1]1=[a:2]-c2=[a:3]-[nH]c(=[*:4])n2-n=[a:5]-1','imidazopyridazineone',0,'af.gif','2009-07-07','RB',''),(109,1,'unequal','[NH]1[C,N:2]=C2[C,N:3]=NC(=[N,O,S:4])N2[N,C:10]=[C,N:5]1>>n1=[a:2]-c2=[a:3]-[nH]c(=[*:4])n2[a:10]=[a:5]-1','imidazopyridazineone',0,'ag.gif','2009-07-07','RB',''),(69,0,'equal','[R:1][Nr7]=[CR,NR:2]-[CR,NR:3]=[CR,NR:4][NHr7][R&!$(C=O)&!$(S=O):5]>>[R:1][NH]-[*:2]=[*:3]-[*:4]=N[R:5]','7ring,1-5',1,'ai.gif','2009-07-08','RB',''),(56,1,'unequal','[NH2+0]-C([!N:1])=[NH0+0][$(C=[O,S]):2][!N:3]>>[NH]=C([*:1])-[NH][*:2][*:3]','rescue amidine-amid',0,'aj.gif','2009-07-08','RB',''),(111,0,'equal','[n+:4]1[c:2][nH][c,n:3]n1>>[n+:4]1[a:2]n[c,n:3][nH]1','fused and charged tetrazole',0,'ak.gif','2008-07-08','RB',''),(112,0,'equal','[C,N:1]2=[C,N:2]-N=C3-N-2-[C,N:3]=[C,N:4][C,N:5]=[N,C:6]N-3>>[A:1]2=[A:2]-[NH]-C3-N-2-[C,N:3]=[C,N:4][C,N:5]=[N,C:6]N=3','triazolodiazepine',1,'bq.gif','2008-07-08','RB',''),(196,1,'unequal','[CH:1]1[CHX4]([*:2])[C:3]=[NX2][C:4]=[C:5]1>>[CH:1]1[CH0]([*:2])=[C:3][NH][C:4]=[C:5]1','partially saturated pyridine',0,'','2009-07-01','RB',''),(197,1,'unequal','[c:1]1oc([OH])[c:2]c(=[N:3])[c:4]1>>[c:1]1oc(=O)[c:2]c([N:3]([H]))[c:4]1','n_sub cumarine analogues',0,'','2009-07-01','RB',''),(198,0,'equal','[!$(O):1][N!R]=[C&!Ca:2][C:3]=[C:4][NH2!R]>>[!$(O):1][N!R]([H])[C:2]=[C:3][C:4]=[NH]','conjugated imine-amine',1,'','2009-07-01','RB',''),(200,1,'unequal','[*:7][CH;R2]([*:5])[C;R2:1]=[NR][CR](=[S,O:4])[NHR,N:6]>>[*:7]C([*:5])=[C:1][NH]C(=[S,O:4])[*:6]','cyclic urea in unsatured ring',0,'','2009-07-01','RB',''),(201,1,'unequal','[S,O:1]=[CR:2][CHR]([*:3])[CR:5]=[N!R][!O:4]>>[*:1]=[C:2]C([*:3])=[C:5]N([H])[*:4]','aliphatic conjugated amide, sub',0,'','2009-07-01','RB',''),(202,1,'unequal','[S,O:1]=[CR:2][CH2R][CR:5]=[N!R][!O:4]>>[*:1]=[C:2][CH]=[C:5]N([H])[*:4]','aliphatic conjugated amide, unsub',0,'aq.gif','2009-07-01','RB',''),(205,0,'unequal','O=[CR:1][CR,NR:2]=[CR]([OH])[OR,NR:3]>>[OH][CR:1]=[CR,NR:2][CR](=O)[OR,NR:3]','tautomerizable cumarine',0,'am.gif','2009-07-01','RB',''),(65,1,'unequal','[O,S:1]=C1[CH2][C,N,c:2]=,:[C,N,c:3][C,N,c:5]=,:[C,N,c:6]1>>[H][O,S:1]-C1=C[a:2]=[a:3]-[a:5]=[a:6]-1','ortho-phenol, no sub',0,'bj.gif','2009-07-16','RB','x'),(62,1,'unequal','[O,S:1]=C1[C,N,c:2]=[C,N,c:3]-[CH2]-[C,N,c:5]=[C,N,c:6]1>>[H][O,S:1]-C1-[*:2]=[*:3]-C=[*:5]-[*:6]=1','para-phenol, no sub',0,'bj.gif','2009-07-16','RB','x'),(206,1,'unequal','[O,S:1]=C1C([*:2])C(=[N:6])[c:4][c:5]O1>>[O,S:1]=C1C([*:2])=C([N:6][H])[C:4]=[C:5]O1','cumarine-imine',0,'','2009-07-01','RB',''),(26,1,'unequal','[OH]c1[nX3:1][nX2,c:2][nX2,c:3]c([nX2,c:4][nX2,c:5][nX2]2)c21>>O=c1[n:1][nX2,c:2][nX2,c:3]c([nX2,c:4][nX2,c:5][n]([H])2)c21','fused pyrol amide',0,'al.gif','2009-07-01','RB',''),(203,0,'unequal','O=[CR:1][CR]([*:2])[CR](=O)[OR,NR:3]>>[OH][CR:1]=[CR]([*:2])[CR](=O)[OR,NR:3]','tautomerizable cumarine, diketo form, sub',0,'','2009-07-01','RB','x'),(27,1,'unequal','[OH]c1[c:1][nX2,c:2][nX2,c:3]c([nX2][nX2,c:4][nX2,c:5]2)n21>>O=c1[c:1][nX2,c:2][nX2,c:3]c([n]([H])[nX2,c:4][nX2,c:5]2)n21','fused pyrol amide 2',0,'an.gif','2009-07-01','RB',''),(209,0,'unequal','[c:1]1[c,nX2:2][nH]n2[c,nX2:3][c,nX2:4][nX2]c12>>[c:1]1[c,nX2:2][nX2]n2[c,nX2:3][c,nX2:4]n([H])c12','5ring-5ring',0,'','2009-07-01','RB',''),(21,1,'unequal','[OH]c1c2[nX2]c([SH])[nX2]c2[c,n:1][n,c:2][nX3:3]1>>O=c1c2[nH]c(=S)[nH]c2[c,n:1][n,c:2][nX3:3]1','thioxo-pyrolo-pyridinone',0,'bv.gif','2009-07-08','RB',''),(28,1,'unequal','[OH]c1[nX3:1][nX2,c:2][nX2,c:3]c([nX2][nX2,c:4][nX2,c:5]2)c21>>O=c1[n:1][nX2,c:2][nX2,c:3]c([n]([H])[nX2,c:4][nX2,c:5]2)c21','fused pyrol amide 3',0,'ba.gif','2008-07-03','RB',''),(29,1,'unequal','[OH]c1[nX3:1][nX2,c:2][nX2,c:3]c([nX2,c:4][nX2][nX2,c:5]2)c21>>O=c1[n:1][nX2,c:2][nX2,c:3]c([nX2,c:4][n]([H])[nX2,c:5]2)c21','fused pyrol amide 4',0,'bc.gif','2008-07-03','RB',''),(204,0,'unequal','O=[CR:1][CH2][CR](=O)[OR,NR:3]>>[OH][CR:1]=[CH][CR](=O)[OR,NR:3]','tautomerizable cumarine, diketo form, unsub',0,'','2009-07-01','RB','x'),(199,1,'unequal','[*:1][NH!R][C:2]=C1[C:3]=[C:4]([C:5]=[C:6]C1=[NH!R])>>[*:1]N=[C:2]c1[c:3][c:4]([c:5][c:6]c1N)','rescue aromatic amines',0,'','2009-07-01','RB','x'),(3,1,'unequal','[*:1][NH+0R][CR:2]=[N+0R][$(C=[O,S]),$(S=O):3]>>[*:1]N=[C:2][NH][*:3]','N=CNH in ring, amid',0,'az.gif','2009-07-07','RB','x'),(1,1,'unequal','[NX2R,SX2R,OX2R,CX3R:1][NH]C(=[N!R:2])[NX2R,SX2R,OX2R,CX3R:3]>>[*:1]N=C([N:2][H])[*:3]','imine > aromatic ring',1,'as.gif','2009-07-07','RB','x'),(145,1,'unequal','O=C1[NH]C(=O)[CH]([*:1])-[C:2]=[C:3]1>>O=C1[NH]C(O)=C([*:1])-[C:2]=[C:3]-1','rescue acids, amids, 6 ring, sub',1,'by.gif','2009-07-17','RB','x'),(61,1,'unequal','[O,S:1]=C1[*;C,N,c:2]=,:[*;C,N,c:3][CH]([*:4])[*;C,N,c:5]=,:[*;C,N,c:6]1>>[H][O,S:1]-C1=[*:2]-[*:3]=C(-[*:4])-[*:5]=[*:6]-1','para-phenol,one sub, fused',0,'bi.gif','2009-07-20','RB','x'),(63,1,'unequal','[O,S:1]=C1[C,N,c:2]=,:[C,N,c:3][CH2][C,N,c:5]=,:[C,N,c:6]1>>[H][O,S:1]-c1:[a:2]:[a:3]:c:[a:5]:[a:6]:1','para-phenol, no sub, fused',0,'bj.gif','2009-07-20','RB','x');
/*!40000 ALTER TABLE `definition_tautomer_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `definition_unwanted_groups_openeye`
--

DROP TABLE IF EXISTS `definition_unwanted_groups_openeye`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `definition_unwanted_groups_openeye` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'michael acceptor, nitro group, ...',
  `description` varchar(255) NOT NULL DEFAULT '',
  `smarts_string` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `date_of_update` date DEFAULT NULL,
  `updated_by` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `definition_unwanted_groups_openeye`
--

LOCK TABLES `definition_unwanted_groups_openeye` WRITE;
/*!40000 ALTER TABLE `definition_unwanted_groups_openeye` DISABLE KEYS */;
INSERT INTO `definition_unwanted_groups_openeye` VALUES (1,'three membered heterocycle','oxygen in ring with size 3','*1[O,S,N]*1',NULL,''),(2,'acid halides','Updated to include sulphonyl halides (chido 21-07-2007)','[S,C](=[O,S])[F,Br,Cl,I]','2007-02-07','cpm'),(3,'alkyl halides','except F (w/o X4 -> any C-Hal, includes also acid halides)','[CX4][Cl,Br,I]',NULL,''),(4,'x-ylates','tosylates, mesylates, etc','[C,c]S(=O)(=O)O[C,c]',NULL,''),(6,'Michael acceptor','triple bond, keto','[$([CH]),$(CC)]#CC(=O)[C,c]',NULL,''),(10,'Michael acceptor','triple bond, ester','[$([CH]),$(CC)]#CC(=O)O[C,c]',NULL,''),(123,'hydroxy pyridine','all N(aromatic) OH','n[OH]',NULL,''),(12,'Michael acceptor','triple bond, suflone','[$([CH]),$(CC)]#CS(=O)(=O)[C,c]',NULL,''),(13,'Michael acceptor','always','C=C(C=O)C=O',NULL,''),(14,'2-halo pyridine','','n1c([F,Cl,Br,I])cccc1',NULL,''),(15,'aldehydes','(carbon atom with one hydrogen atom and double bonded oxygen)','[CH1](=O)',NULL,''),(16,'peroxide','','[O,o][O,o]','2007-07-31','RB'),(17,'imine','','C=[N!R]',NULL,''),(19,'diazo','','[N!R]=[N!R]',NULL,''),(20,'diketo','some carbons in four membered rings are flagged as aromatic','[C,c](=O)[C,c](=O)',NULL,''),(21,'disulphides','max 3 F per compound','[S,s][S,s]','2007-07-31','RB'),(22,'hydrazine','','[N,n][NH2]','2007-07-31','RB'),(23,'acyl hydrazine','(already included in hydrazine)','C(=O)N[NH2]',NULL,''),(24,'thiocarbonyl','any thiocarbonyl','[C,c]=S',NULL,''),(25,'isolated alkene','','[$([CH2]),$([CH][CX4]),$(C([CX4])[CX4])]=[$([CH2]),$([CH][CX4]),$(C([CX4])[CX4])]',NULL,''),(26,'chinone','para, also N is bad','C1(=[O,N])C=CC(=[O,N])C=C1',NULL,''),(27,'chinone','ortho, also N is bad','C1(=[O,N])C(=[O,N])C=CC=C1',NULL,''),(28,'polycyclic','linear','a21aa3a(aa1aaaa2)aaaa3',NULL,''),(29,'polycyclic','crooked','a31a(a2a(aa1)aaaa2)aaaa3',NULL,''),(30,'polycyclic','the missing polycyclic system','a1aa2a3a(a1)A=AA=A3=AA=A2',NULL,''),(31,'aniline','also fused','c1cc([NH2])ccc1',NULL,''),(32,'heavy metals','everything that is not C,N,S,O,Fl,Cl,Br','[Hg,Fe,As,Sb,Zn,Se,se,Te,B,Si,Na,Ca,Ge,Ag,Mg,K,Ba,Sr,Be,Ti,Mo,Mn,Ru,Pd,Ni,Cu,Au,Cd,Al,Ga,Sn,Rh,Tl,Bi,Nb,Li,Pb,Hf,Ho]','2008-05-20','RB'),(33,'iodines','','I',NULL,''),(35,'sulphates','(have to be deprotonated with charger bevor)','OS(=O)(=O)[O-]',NULL,''),(36,'nitro group','','[N+](=O)[O-]',NULL,''),(37,'hydroxamic acid','','C(=O)N[OH]',NULL,''),(38,'hydantoine','','C1NC(=O)NC(=O)1',NULL,''),(39,'thiol','','[SH]',NULL,''),(40,'thiol','(deprotonated, generated by charger.py)','[S-]',NULL,''),(41,'halogeneted rings','more than two hal / ring','c1ccc([Cl,Br,I,F])c([Cl,Br,I,F])c1[Cl,Br,I,F]',NULL,''),(42,'halogeneted rings','more than two hal / ring','c1cc([Cl,Br,I,F])cc([Cl,Br,I,F])c1[Cl,Br,I,F]',NULL,''),(43,'cycloheptane','includes substituted rings','[CR2]1[CR2][CR2][CR2][CR2][CR2][CR2]1',NULL,''),(44,'cycloheptane','in fused rings, includes substituted rings','[CR2]1[CR2][CR2]cc[CR2][CR2]1',NULL,''),(45,'cyclooctane','includes substituted rings','[CR2]1[CR2][CR2][CR2][CR2][CR2][CR2][CR2]1',NULL,''),(46,'cyclooctane','in fused rings, includes substituted rings','[CR2]1[CR2][CR2]cc[CR2][CR2][CR2]1',NULL,''),(47,'azepane','n in 7-ring, excludes substituted rings','[CH2R2]1N[CH2R2][CH2R2][CH2R2][CH2R2][CH2R2]1',NULL,''),(48,'azocane','n in 8-ring, excludes substituted rings','[CH2R2]1N[CH2R2][CH2R2][CH2R2][CH2R2][CH2R2][CH2R2]1',NULL,''),(50,'triple bond','','C#C',NULL,''),(51,'crown ether','','[OR2,NR2]@[CR2]@[CR2]@[OR2,NR2]@[CR2]@[CR2]@[OR2,NR2]',NULL,''),(52,'N oxide','','[$([N+R]),$([n+R]),$([N+]=C)][O-]','2007-04-27','RB'),(53,'oxime','','[C,c]=N[OH]',NULL,''),(54,'oxime','ester','[C,c]=NOC=O',NULL,''),(55,'thio ester','DROP in future, too generic and included in esters','SC=O',NULL,''),(56,'beta-keto/anhydride','double bonded if in ring would be okay (but then it is classified as an Michael acceptor)','[C,c](=O)[CX4,CR0X3,O][C,c](=O)',NULL,''),(57,'cumarine','potential michael acceptors','c1ccc2c(c1)ccc(=O)o2',NULL,''),(58,'charged oxygen and S','','[O+,o+,S+,s+]',NULL,''),(59,'isocyanate','','N=C=O',NULL,''),(60,'N-halo compounds','','[NX3,NX4][F,Cl,Br,I]',NULL,''),(61,'phenol ester','','c1ccccc1OC(=O)[#6]',NULL,''),(62,'polyen','','[CR0]=[CR0][CR0]=[CR0]',NULL,''),(63,'carbocataion and anion','','[C+,c+,C-,c-]',NULL,''),(111,'azide','','N=[N+]=[N-]',NULL,''),(65,'biotin analougue','','C12C(NC(N1)=O)CSC2',NULL,''),(64,'catechol','','c1c([OH])c([OH,NH2,NH])ccc1',NULL,''),(66,'phosphor','','P',NULL,''),(67,'cyanate-aminonitrile-thiocyanate','','[N,O,S]C#N',NULL,''),(71,'ketene','','C=C=O',NULL,''),(72,'silicon halogen','','[Si][F,Cl,Br,I]',NULL,''),(73,'sulfur oxygen single bond','','[SX2]O',NULL,''),(74,'tryphenyl methyl-silyl','','[SiR0,CR0](c1ccccc1)(c2ccccc2)(c3ccccc3)',NULL,''),(75,'saponine derivatives','','O1CCCCC1OC2CCC3CCCCC3C2',NULL,''),(77,'imine','','N=[CR0][N,n,O,S]',NULL,''),(79,'benzidine','','[cR2]1[cR2][cR2]([Nv3X3,Nv4X4])[cR2][cR2][cR2]1[cR2]2[cR2][cR2][cR2]([Nv3X3,Nv4X4])[cR2][cR2]2',NULL,''),(80,'conjugate nitrile','','C=[C!r]C#N',NULL,''),(81,'diaminobenzene','','[cR2]1[cR2]c([N+0X3R0,nX3R0])c([N+0X3R0,nX3R0])[cR2][cR2]1',NULL,''),(82,'diaminobenzene','','[cR2]1[cR2]c([N+0X3R0,nX3R0])[cR2]c([N+0X3R0,nX3R0])[cR2]1',NULL,''),(83,'diaminobenzene','','[cR2]1[cR2]c([N+0X3R0,nX3R0])[cR2][cR2]c1([N+0X3R0,nX3R0])',NULL,''),(84,'hydroquinone','','[OH]c1ccc([OH,NH2,NH])cc1',NULL,''),(85,'phenyl carbonate','','c1ccccc1OC(=O)O',NULL,''),(86,'sulphur nitrogen single bond','','[SX2H0][N]',NULL,''),(87,'thiobenzothiazoles','','c12ccccc1(SC(S)=N2)',NULL,''),(88,'thiobenzothiazoles','','c12ccccc1(SC(=S)N2)',NULL,''),(89,'amidotetrazole','','c1nnnn1C=O',NULL,''),(92,'N-acyl-2-amino-5-mercapto-1,3,4-thiadiazole','','s1c(S)nnc1NC=O',NULL,''),(93,'methylidene-1,3-dithiole','','S1C=CSC1=S',NULL,''),(94,'ester of HOBT','','C(=O)Onnn',NULL,''),(95,'triflate','','OS(=O)(=O)C(F)(F)F',NULL,''),(96,'cyanohydrins','','N#CC[OH]',NULL,''),(97,'acyl cyanides','','N#CC(=O)',NULL,''),(98,'sulfonyl cyanides','','S(=O)(=O)C#N',NULL,''),(99,'cyanamide','','N[CH2]C#N',NULL,''),(100,'four member lactones','also lactames','C1(=O)NCC1','2007-07-31','RB'),(101,'sulphonic acid','','S(=O)(=O)[O-,OH]',NULL,''),(102,'N-C-haloamines','','NC[F,Cl,Br,I]',NULL,''),(103,'acyclic C=C-O','','C=[C!r]O',NULL,''),(105,'nitroso','changed from n-nitroso to nitroso','[NX2+0]=[O+0]','2007-05-10','RB'),(106,'oxigen nitrogen single bond','','[OR0,NR0][OR0,NR0]',NULL,''),(107,'acyl more than two','','C(=O)O[C,H1].C(=O)O[C,H1].C(=O)O[C,H1]',NULL,''),(108,'enamine','','[CX2R0][NX3R0]',NULL,''),(109,'stilbene','','c1ccccc1C=Cc2ccccc2',NULL,''),(110,'het-C-het not in ring','modify rule -> one hetero atom can be in a ring','[NX3R0,NX4R0,OR0,SX2R0][CX4][NX3R0,NX4R0,OR0,SX2R0]',NULL,''),(112,'quart_N','','[s,S,c,C,n,N,o,O]~[n+,N+](~[s,S,c,C,n,N,o,O])(~[s,S,c,C,n,N,o,O])~[s,S,c,C,n,N,o,O]',NULL,''),(113,'quart_N','','[s,S,c,C,n,N,o,O]~[nX3+,NX3+](~[s,S,c,C,n,N])~[s,S,c,C,n,N]',NULL,''),(114,'quart_N','','[*]=[N+]=[*]',NULL,''),(116,'sulfinic acid','','[SX3](=O)[O-,OH]',NULL,''),(117,'azo','','N#N',NULL,''),(119,'perfluorated chain','max 3 F per compound','F.F.F.F','2007-07-31','RB'),(120,'Aliphatic long chain',' this hits aliphatic non branched chains of at least 5 atoms','[R0;D2][R0;D2][R0;D2][R0;D2]',NULL,''),(122,'phthalimides','hits all phthalimides','[cR,CR]~C(=O)NC(=O)~[cR,CR]',NULL,''),(121,'Michael acceptor','modified Michael acceptor','C=!@CC=[O,S]',NULL,''),(125,'esters','do not hit carbamates, modify rule -> C(=O)ON should also be excluded','[C,c,o,O,S,s][C,c](=O)O[C,c]','2007-07-31','RB'),(126,'ketone_thioketone','hits all aromatic carbons connected a C not in a ring connected to a (=O) connected to any carbon','c[C;R0](=[O,S])[C,c]','2007-05-24','CPM'),(127,'thioether','hits all thio ethers connected to an aromatic carbon','c[SX2][C,c]','2007-05-31','CPM'),(128,'allene','','C=C=C','2007-07-31','RB'),(129,'halo sulfo pyrimdine','','c1nc([F,Cl,Br,I,S])ncc1','2007-07-31','RB'),(130,'halo sulfo pyrimdine','','c1ncnc([F,Cl,Br,I,S])c1','2007-07-31','RB'),(133,'halo purine','other purines or hit by halo pyrimidine rule','c1nc(c2c(n1)nc(n2)[F,Cl,Br,I])','2007-07-31','RB'),(134,'fluorosulfonylbenzene','','[C,c]S(=O)(=O)c1ccc(cc1)F','2007-07-31','RB'),(135,'Isotopes','N,C,H,S,O isotopes','[15N,13C,18O,2H,34S]','2008-06-03','CPM');
/*!40000 ALTER TABLE `definition_unwanted_groups_openeye` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `project` varchar(255) NOT NULL DEFAULT '',
  `unique_compounds` varchar(255) NOT NULL DEFAULT '',
  `supplier_info_table` varchar(255) NOT NULL DEFAULT '',
  `supplier_table` varchar(255) NOT NULL DEFAULT '',
  `protonated_smiles` varchar(255) NOT NULL DEFAULT '',
  `tautomerized_smiles` varchar(255) NOT NULL DEFAULT '',
  `stereoisomer_smiles` varchar(255) NOT NULL DEFAULT '',
  `unwanted_groups` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`project`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES ('in_house_lib','unique_compounds','supplier_info','supplier','protonated_smiles','tautomerized_smiles','stereoisomer_smiles','unwanted_groups'),('bb','bb_unique_compounds','bb_supplier_info','supplier','','','','bb_unwanted_groups');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protonated_smiles`
--

DROP TABLE IF EXISTS `protonated_smiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protonated_smiles` (
  `prot_id` int(11) NOT NULL AUTO_INCREMENT,
  `ID` int(11) DEFAULT NULL COMMENT 'foreign key',
  `prot_smiles` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `initial` varchar(5) NOT NULL DEFAULT '',
  `date_of_update` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`prot_id`),
  KEY `ID` (`ID`),
  KEY `prot_smiles` (`prot_smiles`(60)) USING BTREE,
  CONSTRAINT `protonated_smiles_ibfk_2` FOREIGN KEY (`ID`) REFERENCES `unique_compounds` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 190464 kB; (`ID`) REFER `purchasable/unique_com';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `protonated_smiles`
--

LOCK TABLES `protonated_smiles` WRITE;
/*!40000 ALTER TABLE `protonated_smiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `protonated_smiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stereoisomer_smiles`
--

DROP TABLE IF EXISTS `stereoisomer_smiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stereoisomer_smiles` (
  `stereo_id` int(11) NOT NULL AUTO_INCREMENT,
  `ID` int(11) NOT NULL DEFAULT '0' COMMENT 'foreign key',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT 'guessed, exceeded max centers, specified',
  `stereo_smiles` varchar(255) DEFAULT NULL,
  `prot_id` int(11) DEFAULT NULL COMMENT 'foreign key',
  `taut_id` int(11) DEFAULT NULL COMMENT 'foreign key',
  `stereo_blob` mediumblob COMMENT 'gzipped flexibase entry',
  PRIMARY KEY (`stereo_id`),
  KEY `ID` (`ID`),
  KEY `prot_id` (`prot_id`),
  KEY `taut_id` (`taut_id`),
  KEY `stereo_blob` (`stereo_blob`(10)),
  KEY `stereo_smiles` (`stereo_smiles`(150)),
  CONSTRAINT `stereoisomer_smiles_ibfk_2` FOREIGN KEY (`ID`) REFERENCES `unique_compounds` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stereoisomer_smiles_ibfk_3` FOREIGN KEY (`prot_id`) REFERENCES `protonated_smiles` (`prot_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stereoisomer_smiles_ibfk_4` FOREIGN KEY (`taut_id`) REFERENCES `tautomerized_smiles` (`taut_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stereoisomer_smiles`
--

LOCK TABLES `stereoisomer_smiles` WRITE;
/*!40000 ALTER TABLE `stereoisomer_smiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `stereoisomer_smiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier` (
  `supplier` varchar(100) NOT NULL DEFAULT '',
  `prefix` char(3) NOT NULL DEFAULT '',
  `bb_library` varchar(1) NOT NULL,
  `purchasable` varchar(1) NOT NULL,
  `contact_info` varchar(255) NOT NULL,
  PRIMARY KEY (`supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_info`
--

DROP TABLE IF EXISTS `supplier_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier_info` (
  `supplier_id` varchar(30) NOT NULL DEFAULT '',
  `ID` int(11) NOT NULL DEFAULT '0' COMMENT 'foreign key from unique smiles table',
  `supplier` varchar(100) NOT NULL DEFAULT '' COMMENT 'foreign key from supplier table',
  `sup_spec_info` mediumtext COMMENT 'supplier sepcificinformation, e. g. to which of their libraries the compound belongs to',
  `compound_availability` char(3) DEFAULT NULL,
  `date_of_update` date DEFAULT NULL,
  `updated_by` char(3) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`),
  KEY `id` (`ID`),
  KEY `supplier` (`supplier`),
  KEY `update` (`date_of_update`),
  KEY `initial` (`updated_by`),
  KEY `available` (`compound_availability`),
  CONSTRAINT `supplier_info_ibfk_1` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`supplier`),
  CONSTRAINT `supplier_info_ibfk_2` FOREIGN KEY (`ID`) REFERENCES `unique_compounds` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='links unique_id to suppliers and their codes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_info`
--

LOCK TABLES `supplier_info` WRITE;
/*!40000 ALTER TABLE `supplier_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tautomerized_smiles`
--

DROP TABLE IF EXISTS `tautomerized_smiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tautomerized_smiles` (
  `taut_id` int(11) NOT NULL AUTO_INCREMENT,
  `ID` int(11) NOT NULL DEFAULT '0' COMMENT 'foreign key',
  `taut_smiles` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `prot_id` int(11) DEFAULT NULL COMMENT 'foreign key',
  `initial` varchar(5) NOT NULL DEFAULT '',
  `date_of_update` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`taut_id`),
  KEY `ID` (`ID`),
  KEY `taut_smiles` (`taut_smiles`(60)),
  KEY `prot_id` (`prot_id`),
  CONSTRAINT `tautomerized_smiles_ibfk_4` FOREIGN KEY (`prot_id`) REFERENCES `protonated_smiles` (`prot_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tautomerized_smiles_ibfk_5` FOREIGN KEY (`ID`) REFERENCES `unique_compounds` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 182272 kB; (`ID`) REFER `purchasable/unique_com';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tautomerized_smiles`
--

LOCK TABLES `tautomerized_smiles` WRITE;
/*!40000 ALTER TABLE `tautomerized_smiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `tautomerized_smiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unique_compounds`
--

DROP TABLE IF EXISTS `unique_compounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unique_compounds` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `unique_smiles` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `charged_taut_smi` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL COMMENT 'charger with 7 0, random tautomer form generated by tautomerizer',
  `MW` float DEFAULT NULL COMMENT 'molecular weight',
  `hev_atoms` int(11) DEFAULT NULL COMMENT 'number of heavy atoms',
  `donors` int(11) DEFAULT NULL COMMENT 'number of hydrogen bond donors',
  `acceptors` int(11) DEFAULT NULL COMMENT 'number of hydrogen bond acceptors',
  `rot_bonds` int(11) DEFAULT NULL COMMENT 'number of rotatable bonds',
  `ring_systems` int(11) DEFAULT NULL COMMENT 'number of ring systems',
  `not_ring_atoms` int(11) DEFAULT NULL COMMENT 'number of not ring_atoms',
  `fused_rings` int(11) DEFAULT NULL COMMENT 'n/y',
  `total_charge` int(11) DEFAULT NULL COMMENT 'total charge',
  `num_nitril` int(11) DEFAULT '0' COMMENT 'number of nitril groups',
  `num_ether` int(11) DEFAULT '0' COMMENT 'number of ether groups',
  `num_amid` int(11) DEFAULT '0' COMMENT 'number of amid groups',
  `num_imine` int(11) DEFAULT '0' COMMENT 'number of imine groups',
  `num_substituted_aniline` int(11) DEFAULT '0' COMMENT 'number of substituted aromatic amino groups',
  `num_amino_thiazole` int(11) DEFAULT '0' COMMENT 'number of 2-amino-thiazole groups',
  `tpsa` float DEFAULT NULL COMMENT 'tpsa',
  `alogp` float DEFAULT NULL COMMENT 'alogp',
  `logd` float DEFAULT NULL COMMENT 'logd',
  PRIMARY KEY (`ID`),
  KEY `unique_smiles` (`unique_smiles`(150)) USING BTREE,
  KEY `hev_atoms` (`hev_atoms`),
  KEY `donors` (`donors`),
  KEY `acceptors` (`acceptors`),
  KEY `rot_bonds` (`rot_bonds`),
  KEY `ring_systems` (`ring_systems`),
  KEY `clogp` (`alogp`),
  KEY `num_nitril` (`num_nitril`),
  KEY `tpsa` (`tpsa`),
  KEY `fused_rings` (`fused_rings`),
  KEY `not_ring_atoms` (`not_ring_atoms`),
  KEY `mw` (`MW`),
  KEY `total_charge` (`total_charge`),
  KEY `num_ether` (`num_ether`),
  KEY `num_amid` (`num_amid`),
  KEY `num_imine` (`num_imine`),
  KEY `logd` (`logd`),
  KEY `charged_taut_smiles` (`charged_taut_smi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=1 COMMENT='unique strings (except of  [nH]) for all compounds; InnoDB f';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unique_compounds`
--

LOCK TABLES `unique_compounds` WRITE;
/*!40000 ALTER TABLE `unique_compounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `unique_compounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unwanted_groups`
--

DROP TABLE IF EXISTS `unwanted_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unwanted_groups` (
  `ID` int(11) NOT NULL DEFAULT '0' COMMENT 'foreign key',
  `three_membered_heterocycle` char(1) DEFAULT NULL,
  `acid_halides` char(1) DEFAULT NULL,
  `alkyl_halides` char(1) DEFAULT NULL,
  `x_ylates` char(1) DEFAULT NULL,
  `Michael_acceptor` char(1) DEFAULT NULL,
  `2_halo_pyridine` char(1) DEFAULT NULL,
  `aldehydes` char(1) DEFAULT NULL,
  `peroxide` char(1) DEFAULT NULL,
  `diazo` char(1) DEFAULT NULL,
  `diketo` char(1) DEFAULT NULL,
  `disulphides` char(1) DEFAULT NULL,
  `hydrazine` char(1) DEFAULT NULL,
  `acyl_hydrazine` char(1) DEFAULT NULL,
  `thiocarbonyl` char(1) DEFAULT NULL,
  `isolated_alkene` char(1) DEFAULT NULL,
  `chinone` char(1) DEFAULT NULL,
  `polycyclic` char(1) DEFAULT NULL,
  `aniline` char(1) DEFAULT NULL,
  `heavy_metals` char(1) DEFAULT NULL,
  `iodines` char(1) DEFAULT NULL,
  `sulphates` char(1) DEFAULT NULL,
  `nitro_group` char(1) DEFAULT NULL,
  `hydroxamic_acid` char(1) DEFAULT NULL,
  `hydantoine` char(1) DEFAULT NULL,
  `thiol` char(1) DEFAULT NULL,
  `halogeneted_rings` char(1) DEFAULT NULL,
  `cycloheptane` char(1) DEFAULT NULL,
  `cyclooctane` char(1) DEFAULT NULL,
  `azepane` char(1) DEFAULT NULL,
  `azocane` char(1) DEFAULT NULL,
  `triple_bond` char(1) DEFAULT NULL,
  `crown_ether` char(1) DEFAULT NULL,
  `N_oxide` char(1) DEFAULT NULL,
  `oxime` char(1) DEFAULT NULL,
  `thio_ester` char(1) DEFAULT NULL,
  `beta_keto_anhydride` char(1) DEFAULT NULL,
  `cumarine` char(1) DEFAULT NULL,
  `isocyanate` char(1) DEFAULT NULL,
  `N_halo_compounds` char(1) DEFAULT NULL,
  `phenol_ester` char(1) DEFAULT NULL,
  `polyen` char(1) DEFAULT NULL,
  `carbo_cation` char(1) DEFAULT NULL,
  `azide` char(1) DEFAULT NULL,
  `biotin_analougue` char(1) DEFAULT NULL,
  `catechol` char(1) DEFAULT NULL,
  `phosphor` char(1) DEFAULT NULL,
  `cyanate_aminonitrile_thiocyanate` char(1) DEFAULT NULL,
  `ketene` char(1) DEFAULT NULL,
  `silicon_halogen` char(1) DEFAULT NULL,
  `sulfur_oxygen_single_bond` char(1) DEFAULT NULL,
  `tryphenyl_methyl_silyl` char(1) DEFAULT NULL,
  `saponine_derivatives` char(1) DEFAULT NULL,
  `imine` char(1) DEFAULT NULL,
  `benzidine` char(1) DEFAULT NULL,
  `conjugate_nitrile` char(1) DEFAULT NULL,
  `diaminobenzene` char(1) DEFAULT NULL,
  `hydroquinone` char(1) DEFAULT NULL,
  `phenyl_carbonate` char(1) DEFAULT NULL,
  `sulphur_nitrogen_single_bond` char(1) DEFAULT NULL,
  `thiobenzothiazoles` char(1) DEFAULT NULL,
  `amidotetrazole` char(1) DEFAULT NULL,
  `phthalimides` char(1) DEFAULT NULL,
  `N_acyl_2_amino_5_mercapto_1_3_4_thiadiazole` char(1) DEFAULT NULL,
  `methylidene_1_3_dithiole` char(1) DEFAULT NULL,
  `ester_of_HOBT` char(1) DEFAULT NULL,
  `triflate` char(1) DEFAULT NULL,
  `cyanohydrins` char(1) DEFAULT NULL,
  `acyl_cyanides` char(1) DEFAULT NULL,
  `sulfonyl_cyanides` char(1) DEFAULT NULL,
  `cyanamide` char(1) DEFAULT NULL,
  `four_member_lactones` char(1) DEFAULT NULL,
  `sulphonic_acid` char(1) DEFAULT NULL,
  `N_C_haloamines` char(1) DEFAULT NULL,
  `acyclic_C_C_O` char(1) DEFAULT NULL,
  `nitroso` char(1) DEFAULT NULL,
  `oxigen_nitrogen_single_bond` char(1) DEFAULT NULL,
  `acyl_more_than_two` char(1) DEFAULT NULL,
  `enamine` char(1) DEFAULT NULL,
  `stilbene` char(1) DEFAULT NULL,
  `het_C_het_not_in_ring` char(1) DEFAULT NULL,
  `quart_N` char(1) DEFAULT NULL,
  `charged_oxygen_and_S` char(1) DEFAULT NULL,
  `carbocataion_and_anion` char(1) DEFAULT NULL,
  `azo` char(1) DEFAULT NULL,
  `sulfinic_acid` char(1) DEFAULT NULL,
  `Aliphatic_long_chain` char(1) DEFAULT NULL,
  `perfluorated_chain` char(1) DEFAULT NULL,
  `hydroxy_pyridine` char(1) DEFAULT NULL,
  `esters` char(1) DEFAULT NULL,
  `ketone_thioketone` char(1) DEFAULT NULL,
  `thioether` char(1) DEFAULT NULL,
  `allene` char(1) DEFAULT NULL,
  `fluorosulfonylbenzene` char(1) DEFAULT NULL,
  `halo_purine` char(1) DEFAULT NULL,
  `halo_sulfo_pyrimdine` char(1) DEFAULT NULL,
  `Isotopes` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `unwanted_groups_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `unique_compounds` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 971776 kB; (`ID`) REFER `purchasable/unique_com';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unwanted_groups`
--

LOCK TABLES `unwanted_groups` WRITE;
/*!40000 ALTER TABLE `unwanted_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `unwanted_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-05-03 10:32:43
