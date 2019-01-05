/*
 Navicat MySQL Data Transfer

 Source Server         : Local
 Source Server Type    : MariaDB
 Source Server Version : 100311
 Source Host           : localhost:3306
 Source Schema         : itani

 Target Server Type    : MariaDB
 Target Server Version : 100311
 File Encoding         : 65001

 Date: 05/01/2019 15:27:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bumdes
-- ----------------------------
DROP TABLE IF EXISTS `bumdes`;
CREATE TABLE `bumdes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(64) NOT NULL,
  `nomor_telpon` varchar(14) NOT NULL,
  `foto` blob DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `nomor_telpon` (`nomor_telpon`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of bumdes
-- ----------------------------
BEGIN;
INSERT INTO `bumdes` VALUES (1, 'aji laksono', '6282120402431', NULL);
INSERT INTO `bumdes` VALUES (2, 'putri', '6285771460162', NULL);
COMMIT;

-- ----------------------------
-- Table structure for bumdes_session
-- ----------------------------
DROP TABLE IF EXISTS `bumdes_session`;
CREATE TABLE `bumdes_session` (
  `id_bumdes` int(11) NOT NULL,
  `nomor_telpon` varchar(14) DEFAULT NULL,
  `code` varchar(6) NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_bumdes`) USING BTREE,
  KEY `auth_bumdes_phone` (`nomor_telpon`),
  CONSTRAINT `auth_bumdes` FOREIGN KEY (`id_bumdes`) REFERENCES `bumdes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `auth_bumdes_phone` FOREIGN KEY (`nomor_telpon`) REFERENCES `bumdes` (`nomor_telpon`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of bumdes_session
-- ----------------------------
BEGIN;
INSERT INTO `bumdes_session` VALUES (1, '6282120402431', '378742', '2019-01-05 15:02:58');
COMMIT;

-- ----------------------------
-- Table structure for bumdes_verify
-- ----------------------------
DROP TABLE IF EXISTS `bumdes_verify`;
CREATE TABLE `bumdes_verify` (
  `id_bumdes` int(11) NOT NULL,
  `code` varchar(6) NOT NULL,
  `status` enum('unverified','verified') NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_bumdes`) USING BTREE,
  CONSTRAINT `verify_bumdes` FOREIGN KEY (`id_bumdes`) REFERENCES `bumdes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of bumdes_verify
-- ----------------------------
BEGIN;
INSERT INTO `bumdes_verify` VALUES (1, '432454', 'verified', '2018-12-31 16:47:06');
INSERT INTO `bumdes_verify` VALUES (2, '432423', 'verified', '2019-01-05 09:35:03');
COMMIT;

-- ----------------------------
-- Table structure for core_store
-- ----------------------------
DROP TABLE IF EXISTS `core_store`;
CREATE TABLE `core_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` longtext DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `environment` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `SEARCH_CORE_STORE` (`key`,`value`,`type`,`environment`,`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of core_store
-- ----------------------------
BEGIN;
INSERT INTO `core_store` VALUES (1, 'db_model_core_store', '{\"key\":{\"type\":\"string\"},\"value\":{\"type\":\"text\"},\"type\":{\"type\":\"string\"},\"environment\":{\"type\":\"string\"},\"tag\":{\"type\":\"string\"}}', 'object', NULL, NULL);
INSERT INTO `core_store` VALUES (2, 'db_model_users-permissions_permission', '{\"type\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"controller\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"action\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"enabled\":{\"type\":\"boolean\",\"required\":true,\"configurable\":false},\"policy\":{\"type\":\"string\",\"configurable\":false},\"role\":{\"model\":\"role\",\"via\":\"permissions\",\"plugin\":\"users-permissions\",\"configurable\":false}}', 'object', NULL, NULL);
INSERT INTO `core_store` VALUES (3, 'db_model_users-permissions_role', '{\"name\":{\"type\":\"string\",\"minLength\":3,\"required\":true,\"configurable\":false},\"description\":{\"type\":\"string\",\"configurable\":false},\"type\":{\"type\":\"string\",\"unique\":true,\"configurable\":false},\"permissions\":{\"collection\":\"permission\",\"via\":\"role\",\"plugin\":\"users-permissions\",\"configurable\":false,\"isVirtual\":true},\"users\":{\"collection\":\"user\",\"via\":\"role\",\"plugin\":\"users-permissions\",\"isVirtual\":true}}', 'object', NULL, NULL);
INSERT INTO `core_store` VALUES (4, 'db_model_upload_file', '{\"name\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"hash\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"sha256\":{\"type\":\"string\",\"configurable\":false},\"ext\":{\"type\":\"string\",\"configurable\":false},\"mime\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"size\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"url\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"provider\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"public_id\":{\"type\":\"string\",\"configurable\":false},\"related\":{\"collection\":\"*\",\"filter\":\"field\",\"configurable\":false},\"created_at\":{\"type\":\"timestamp\"},\"updated_at\":{\"type\":\"timestampUpdate\"}}', 'object', NULL, NULL);
INSERT INTO `core_store` VALUES (5, 'db_model_users-permissions_user', '{\"username\":{\"type\":\"string\",\"minLength\":3,\"unique\":true,\"configurable\":false,\"required\":true},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true},\"provider\":{\"type\":\"string\",\"configurable\":false},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"private\":true},\"resetPasswordToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"confirmed\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"role\":{\"model\":\"role\",\"via\":\"users\",\"plugin\":\"users-permissions\",\"configurable\":false}}', 'object', NULL, NULL);
INSERT INTO `core_store` VALUES (6, 'db_model_upload_file_morph', '{\"upload_file_id\":{\"type\":\"integer\"},\"related_id\":{\"type\":\"integer\"},\"related_type\":{\"type\":\"text\"},\"field\":{\"type\":\"text\"}}', 'object', NULL, NULL);
INSERT INTO `core_store` VALUES (7, 'core_application', '{\"name\":\"Default Application\",\"description\":\"This API is going to be awesome!\"}', 'object', '', '');
INSERT INTO `core_store` VALUES (8, 'plugin_content-manager_schema', '{\"generalSettings\":{\"search\":true,\"filters\":true,\"bulkActions\":true,\"pageEntries\":10},\"models\":{\"plugins\":{\"upload\":{\"file\":{\"label\":\"File\",\"labelPlural\":\"Files\",\"orm\":\"bookshelf\",\"search\":true,\"filters\":true,\"bulkActions\":true,\"pageEntries\":10,\"defaultSort\":\"id\",\"sort\":\"ASC\",\"editDisplay\":{\"availableFields\":{\"name\":{\"label\":\"Name\",\"type\":\"string\",\"description\":\"\",\"name\":\"name\",\"editable\":true,\"placeholder\":\"\"},\"hash\":{\"label\":\"Hash\",\"type\":\"string\",\"description\":\"\",\"name\":\"hash\",\"editable\":true,\"placeholder\":\"\"},\"sha256\":{\"label\":\"Sha256\",\"type\":\"string\",\"description\":\"\",\"name\":\"sha256\",\"editable\":true,\"placeholder\":\"\"},\"ext\":{\"label\":\"Ext\",\"type\":\"string\",\"description\":\"\",\"name\":\"ext\",\"editable\":true,\"placeholder\":\"\"},\"mime\":{\"label\":\"Mime\",\"type\":\"string\",\"description\":\"\",\"name\":\"mime\",\"editable\":true,\"placeholder\":\"\"},\"size\":{\"label\":\"Size\",\"type\":\"string\",\"description\":\"\",\"name\":\"size\",\"editable\":true,\"placeholder\":\"\"},\"url\":{\"label\":\"Url\",\"type\":\"string\",\"description\":\"\",\"name\":\"url\",\"editable\":true,\"placeholder\":\"\"},\"provider\":{\"label\":\"Provider\",\"type\":\"string\",\"description\":\"\",\"name\":\"provider\",\"editable\":true,\"placeholder\":\"\"},\"public_id\":{\"label\":\"Public_id\",\"type\":\"string\",\"description\":\"\",\"name\":\"public_id\",\"editable\":true,\"placeholder\":\"\"}},\"fields\":[\"name\",\"hash\",\"sha256\",\"ext\",\"mime\",\"size\",\"url\",\"provider\",\"public_id\"],\"relations\":[]},\"info\":{\"name\":\"file\",\"description\":\"\"},\"connection\":\"default\",\"collectionName\":\"upload_file\",\"attributes\":{\"name\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"hash\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"sha256\":{\"type\":\"string\",\"configurable\":false},\"ext\":{\"type\":\"string\",\"configurable\":false},\"mime\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"size\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"url\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"provider\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"public_id\":{\"type\":\"string\",\"configurable\":false},\"related\":{\"collection\":\"*\",\"filter\":\"field\",\"configurable\":false}},\"globalId\":\"UploadFile\",\"globalName\":\"UploadFile\",\"primaryKey\":\"id\",\"associations\":[{\"alias\":\"related\",\"type\":\"collection\",\"related\":[],\"nature\":\"manyMorphToMany\",\"autoPopulate\":true,\"filter\":\"field\"}],\"fields\":{\"name\":{\"label\":\"Name\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"name\",\"sortable\":true,\"searchable\":true},\"hash\":{\"label\":\"Hash\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"hash\",\"sortable\":true,\"searchable\":true},\"sha256\":{\"label\":\"Sha256\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"sha256\",\"sortable\":true,\"searchable\":true},\"ext\":{\"label\":\"Ext\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"ext\",\"sortable\":true,\"searchable\":true},\"mime\":{\"label\":\"Mime\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"mime\",\"sortable\":true,\"searchable\":true},\"size\":{\"label\":\"Size\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"size\",\"sortable\":true,\"searchable\":true},\"url\":{\"label\":\"Url\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"url\",\"sortable\":true,\"searchable\":true},\"provider\":{\"label\":\"Provider\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"provider\",\"sortable\":true,\"searchable\":true},\"public_id\":{\"label\":\"Public_id\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"public_id\",\"sortable\":true,\"searchable\":true}},\"listDisplay\":[{\"name\":\"id\",\"label\":\"Id\",\"type\":\"string\",\"sortable\":true,\"searchable\":true},{\"label\":\"Name\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"name\",\"sortable\":true,\"searchable\":true},{\"label\":\"Hash\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"hash\",\"sortable\":true,\"searchable\":true},{\"label\":\"Sha256\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"sha256\",\"sortable\":true,\"searchable\":true},{\"label\":\"Ext\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"ext\",\"sortable\":true,\"searchable\":true}],\"relations\":{\"related\":{\"alias\":\"related\",\"type\":\"collection\",\"related\":[],\"nature\":\"manyMorphToMany\",\"autoPopulate\":true,\"filter\":\"field\",\"description\":\"\",\"label\":\"Related\",\"displayedAttribute\":\"id\"}}}},\"users-permissions\":{\"permission\":{\"label\":\"Permission\",\"labelPlural\":\"Permissions\",\"orm\":\"bookshelf\",\"search\":true,\"filters\":true,\"bulkActions\":true,\"pageEntries\":10,\"defaultSort\":\"id\",\"sort\":\"ASC\",\"editDisplay\":{\"availableFields\":{\"type\":{\"label\":\"Type\",\"type\":\"string\",\"description\":\"\",\"name\":\"type\",\"editable\":true,\"placeholder\":\"\"},\"controller\":{\"label\":\"Controller\",\"type\":\"string\",\"description\":\"\",\"name\":\"controller\",\"editable\":true,\"placeholder\":\"\"},\"action\":{\"label\":\"Action\",\"type\":\"string\",\"description\":\"\",\"name\":\"action\",\"editable\":true,\"placeholder\":\"\"},\"enabled\":{\"label\":\"Enabled\",\"type\":\"boolean\",\"description\":\"\",\"name\":\"enabled\",\"editable\":true,\"placeholder\":\"\"},\"policy\":{\"label\":\"Policy\",\"type\":\"string\",\"description\":\"\",\"name\":\"policy\",\"editable\":true,\"placeholder\":\"\"}},\"fields\":[\"type\",\"controller\",\"action\",\"enabled\",\"policy\"],\"relations\":[\"role\"]},\"info\":{\"name\":\"permission\",\"description\":\"\"},\"connection\":\"default\",\"collectionName\":\"users-permissions_permission\",\"attributes\":{\"type\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"controller\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"action\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"enabled\":{\"type\":\"boolean\",\"required\":true,\"configurable\":false},\"policy\":{\"type\":\"string\",\"configurable\":false},\"role\":{\"model\":\"role\",\"via\":\"permissions\",\"plugin\":\"users-permissions\",\"configurable\":false}},\"globalId\":\"UsersPermissionsPermission\",\"globalName\":\"UsersPermissionsPermission\",\"primaryKey\":\"id\",\"associations\":[{\"alias\":\"role\",\"type\":\"model\",\"model\":\"role\",\"via\":\"permissions\",\"nature\":\"manyToOne\",\"autoPopulate\":true,\"dominant\":true,\"plugin\":\"users-permissions\"}],\"fields\":{\"type\":{\"label\":\"Type\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"type\",\"sortable\":true,\"searchable\":true},\"controller\":{\"label\":\"Controller\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"controller\",\"sortable\":true,\"searchable\":true},\"action\":{\"label\":\"Action\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"action\",\"sortable\":true,\"searchable\":true},\"enabled\":{\"label\":\"Enabled\",\"description\":\"\",\"type\":\"boolean\",\"disabled\":false,\"name\":\"enabled\",\"sortable\":true,\"searchable\":true},\"policy\":{\"label\":\"Policy\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"policy\",\"sortable\":true,\"searchable\":true}},\"listDisplay\":[{\"name\":\"id\",\"label\":\"Id\",\"type\":\"string\",\"sortable\":true,\"searchable\":true},{\"label\":\"Type\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"type\",\"sortable\":true,\"searchable\":true},{\"label\":\"Controller\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"controller\",\"sortable\":true,\"searchable\":true},{\"label\":\"Action\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"action\",\"sortable\":true,\"searchable\":true},{\"label\":\"Enabled\",\"description\":\"\",\"type\":\"boolean\",\"disabled\":false,\"name\":\"enabled\",\"sortable\":true,\"searchable\":true}],\"relations\":{\"role\":{\"alias\":\"role\",\"type\":\"model\",\"model\":\"role\",\"via\":\"permissions\",\"nature\":\"manyToOne\",\"autoPopulate\":true,\"dominant\":true,\"plugin\":\"users-permissions\",\"description\":\"\",\"label\":\"Role\",\"displayedAttribute\":\"name\"}}},\"role\":{\"label\":\"Role\",\"labelPlural\":\"Roles\",\"orm\":\"bookshelf\",\"search\":true,\"filters\":true,\"bulkActions\":true,\"pageEntries\":10,\"defaultSort\":\"id\",\"sort\":\"ASC\",\"editDisplay\":{\"availableFields\":{\"name\":{\"label\":\"Name\",\"type\":\"string\",\"description\":\"\",\"name\":\"name\",\"editable\":true,\"placeholder\":\"\"},\"description\":{\"label\":\"Description\",\"type\":\"string\",\"description\":\"\",\"name\":\"description\",\"editable\":true,\"placeholder\":\"\"},\"type\":{\"label\":\"Type\",\"type\":\"string\",\"description\":\"\",\"name\":\"type\",\"editable\":true,\"placeholder\":\"\"}},\"fields\":[\"name\",\"description\",\"type\"],\"relations\":[\"permissions\",\"users\"]},\"info\":{\"name\":\"role\",\"description\":\"\"},\"connection\":\"default\",\"collectionName\":\"users-permissions_role\",\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":3,\"required\":true,\"configurable\":false},\"description\":{\"type\":\"string\",\"configurable\":false},\"type\":{\"type\":\"string\",\"unique\":true,\"configurable\":false},\"permissions\":{\"collection\":\"permission\",\"via\":\"role\",\"plugin\":\"users-permissions\",\"configurable\":false,\"isVirtual\":true},\"users\":{\"collection\":\"user\",\"via\":\"role\",\"plugin\":\"users-permissions\",\"isVirtual\":true}},\"globalId\":\"UsersPermissionsRole\",\"globalName\":\"UsersPermissionsRole\",\"primaryKey\":\"id\",\"associations\":[{\"alias\":\"permissions\",\"type\":\"collection\",\"collection\":\"permission\",\"via\":\"role\",\"nature\":\"oneToMany\",\"autoPopulate\":true,\"dominant\":true,\"plugin\":\"users-permissions\"},{\"alias\":\"users\",\"type\":\"collection\",\"collection\":\"user\",\"via\":\"role\",\"nature\":\"oneToMany\",\"autoPopulate\":true,\"dominant\":true,\"plugin\":\"users-permissions\"}],\"fields\":{\"name\":{\"label\":\"Name\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"name\",\"sortable\":true,\"searchable\":true},\"description\":{\"label\":\"Description\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"description\",\"sortable\":true,\"searchable\":true},\"type\":{\"label\":\"Type\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"type\",\"sortable\":true,\"searchable\":true}},\"listDisplay\":[{\"name\":\"id\",\"label\":\"Id\",\"type\":\"string\",\"sortable\":true,\"searchable\":true},{\"label\":\"Name\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"name\",\"sortable\":true,\"searchable\":true},{\"label\":\"Description\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"description\",\"sortable\":true,\"searchable\":true},{\"label\":\"Type\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"type\",\"sortable\":true,\"searchable\":true}],\"relations\":{\"permissions\":{\"alias\":\"permissions\",\"type\":\"collection\",\"collection\":\"permission\",\"via\":\"role\",\"nature\":\"oneToMany\",\"autoPopulate\":true,\"dominant\":true,\"plugin\":\"users-permissions\",\"description\":\"\",\"label\":\"Permissions\",\"displayedAttribute\":\"type\"},\"users\":{\"alias\":\"users\",\"type\":\"collection\",\"collection\":\"user\",\"via\":\"role\",\"nature\":\"oneToMany\",\"autoPopulate\":true,\"dominant\":true,\"plugin\":\"users-permissions\",\"description\":\"\",\"label\":\"Users\",\"displayedAttribute\":\"username\"}}},\"user\":{\"label\":\"User\",\"labelPlural\":\"Users\",\"orm\":\"bookshelf\",\"search\":true,\"filters\":true,\"bulkActions\":true,\"pageEntries\":10,\"defaultSort\":\"id\",\"sort\":\"ASC\",\"editDisplay\":{\"availableFields\":{\"username\":{\"label\":\"Username\",\"type\":\"string\",\"description\":\"\",\"name\":\"username\",\"editable\":true,\"placeholder\":\"\"},\"email\":{\"label\":\"Email\",\"type\":\"email\",\"description\":\"\",\"name\":\"email\",\"editable\":true,\"placeholder\":\"\"},\"provider\":{\"label\":\"Provider\",\"type\":\"string\",\"description\":\"\",\"name\":\"provider\",\"editable\":true,\"placeholder\":\"\"},\"password\":{\"label\":\"Password\",\"type\":\"password\",\"description\":\"\",\"name\":\"password\",\"editable\":true,\"placeholder\":\"\"},\"confirmed\":{\"label\":\"Confirmed\",\"type\":\"boolean\",\"description\":\"\",\"name\":\"confirmed\",\"editable\":true,\"placeholder\":\"\"},\"blocked\":{\"label\":\"Blocked\",\"type\":\"boolean\",\"description\":\"\",\"name\":\"blocked\",\"editable\":true,\"placeholder\":\"\"}},\"fields\":[\"username\",\"email\",\"provider\",\"password\",\"confirmed\",\"blocked\"],\"relations\":[\"role\"]},\"info\":{\"name\":\"user\",\"description\":\"\"},\"connection\":\"default\",\"collectionName\":\"users-permissions_user\",\"attributes\":{\"username\":{\"type\":\"string\",\"minLength\":3,\"unique\":true,\"configurable\":false,\"required\":true},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true},\"provider\":{\"type\":\"string\",\"configurable\":false},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"private\":true},\"confirmed\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"role\":{\"model\":\"role\",\"via\":\"users\",\"plugin\":\"users-permissions\",\"configurable\":false}},\"globalId\":\"UsersPermissionsUser\",\"globalName\":\"UsersPermissionsUser\",\"primaryKey\":\"id\",\"associations\":[{\"alias\":\"role\",\"type\":\"model\",\"model\":\"role\",\"via\":\"users\",\"nature\":\"manyToOne\",\"autoPopulate\":true,\"dominant\":true,\"plugin\":\"users-permissions\"}],\"fields\":{\"username\":{\"label\":\"Username\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"username\",\"sortable\":true,\"searchable\":true},\"email\":{\"label\":\"Email\",\"description\":\"\",\"type\":\"email\",\"disabled\":false,\"name\":\"email\",\"sortable\":true,\"searchable\":true},\"provider\":{\"label\":\"Provider\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"provider\",\"sortable\":true,\"searchable\":true},\"password\":{\"label\":\"Password\",\"description\":\"\",\"type\":\"password\",\"disabled\":false,\"name\":\"password\",\"sortable\":true,\"searchable\":true},\"confirmed\":{\"label\":\"Confirmed\",\"description\":\"\",\"type\":\"boolean\",\"disabled\":false,\"name\":\"confirmed\",\"sortable\":true,\"searchable\":true},\"blocked\":{\"label\":\"Blocked\",\"description\":\"\",\"type\":\"boolean\",\"disabled\":false,\"name\":\"blocked\",\"sortable\":true,\"searchable\":true}},\"listDisplay\":[{\"name\":\"id\",\"label\":\"Id\",\"type\":\"string\",\"sortable\":true,\"searchable\":true},{\"label\":\"Username\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"username\",\"sortable\":true,\"searchable\":true},{\"label\":\"Email\",\"description\":\"\",\"type\":\"email\",\"disabled\":false,\"name\":\"email\",\"sortable\":true,\"searchable\":true},{\"label\":\"Provider\",\"description\":\"\",\"type\":\"string\",\"disabled\":false,\"name\":\"provider\",\"sortable\":true,\"searchable\":true},{\"label\":\"Password\",\"description\":\"\",\"type\":\"password\",\"disabled\":false,\"name\":\"password\",\"sortable\":true,\"searchable\":true}],\"relations\":{\"role\":{\"alias\":\"role\",\"type\":\"model\",\"model\":\"role\",\"via\":\"users\",\"nature\":\"manyToOne\",\"autoPopulate\":true,\"dominant\":true,\"plugin\":\"users-permissions\",\"description\":\"\",\"label\":\"Role\",\"displayedAttribute\":\"name\"}}}}}},\"layout\":{\"user\":{\"actions\":{\"create\":\"User.create\",\"update\":\"User.update\",\"destroy\":\"User.destroy\",\"deleteall\":\"User.destroyAll\"},\"attributes\":{\"username\":{\"className\":\"col-md-6\"},\"email\":{\"className\":\"col-md-6\"},\"resetPasswordToken\":{\"className\":\"d-none\"},\"role\":{\"className\":\"d-none\"}}}}}', 'object', '', '');
INSERT INTO `core_store` VALUES (9, 'plugin_users-permissions_grant', '{\"email\":{\"enabled\":true,\"icon\":\"envelope\"},\"discord\":{\"enabled\":false,\"icon\":\"comments\",\"key\":\"\",\"secret\":\"\",\"callback\":\"/auth/discord/callback\",\"scope\":[\"identify\",\"email\"]},\"facebook\":{\"enabled\":false,\"icon\":\"facebook-official\",\"key\":\"\",\"secret\":\"\",\"callback\":\"/auth/facebook/callback\",\"scope\":[\"email\"]},\"google\":{\"enabled\":false,\"icon\":\"google\",\"key\":\"\",\"secret\":\"\",\"callback\":\"/auth/google/callback\",\"scope\":[\"email\"]},\"github\":{\"enabled\":false,\"icon\":\"github\",\"key\":\"\",\"secret\":\"\",\"redirect_uri\":\"/auth/github/callback\",\"scope\":[\"user\",\"user:email\"]},\"microsoft\":{\"enabled\":false,\"icon\":\"windows\",\"key\":\"\",\"secret\":\"\",\"callback\":\"/auth/microsoft/callback\",\"scope\":[\"user.read\"]},\"twitter\":{\"enabled\":false,\"icon\":\"twitter\",\"key\":\"\",\"secret\":\"\",\"callback\":\"/auth/twitter/callback\"}}', 'object', '', '');
INSERT INTO `core_store` VALUES (10, 'plugin_email_provider', '{\"provider\":\"sendmail\",\"name\":\"Sendmail\",\"auth\":{\"sendmail_default_from\":{\"label\":\"Sendmail Default From\",\"type\":\"text\"},\"sendmail_default_replyto\":{\"label\":\"Sendmail Default Reply-To\",\"type\":\"text\"}}}', 'object', 'development', '');
INSERT INTO `core_store` VALUES (11, 'plugin_upload_provider', '{\"provider\":\"local\",\"name\":\"Local server\",\"enabled\":true,\"sizeLimit\":1000000}', 'object', 'development', '');
INSERT INTO `core_store` VALUES (12, 'plugin_users-permissions_email', '{\"reset_password\":{\"display\":\"Email.template.reset_password\",\"icon\":\"refresh\",\"options\":{\"from\":{\"name\":\"Administration Panel\",\"email\":\"no-reply@strapi.io\"},\"response_email\":\"\",\"object\":\"­Reset password\",\"message\":\"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>\"}},\"email_confirmation\":{\"display\":\"Email.template.email_confirmation\",\"icon\":\"check-square-o\",\"options\":{\"from\":{\"name\":\"Administration Panel\",\"email\":\"no-reply@strapi.io\"},\"response_email\":\"\",\"object\":\"Account confirmation\",\"message\":\"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>\"}}}', 'object', '', '');
INSERT INTO `core_store` VALUES (13, 'plugin_users-permissions_advanced', '{\"unique_email\":true,\"allow_register\":true,\"email_confirmation\":false,\"email_confirmation_redirection\":\"http://localhost:1337/admin\",\"default_role\":\"authenticated\"}', 'object', '', '');
COMMIT;

-- ----------------------------
-- Table structure for upload_file
-- ----------------------------
DROP TABLE IF EXISTS `upload_file`;
CREATE TABLE `upload_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `sha256` varchar(255) DEFAULT NULL,
  `ext` varchar(255) DEFAULT NULL,
  `mime` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `public_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  FULLTEXT KEY `SEARCH_UPLOAD_FILE` (`name`,`hash`,`sha256`,`ext`,`mime`,`size`,`url`,`provider`,`public_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for upload_file_morph
-- ----------------------------
DROP TABLE IF EXISTS `upload_file_morph`;
CREATE TABLE `upload_file_morph` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upload_file_id` int(11) DEFAULT NULL,
  `related_id` int(11) DEFAULT NULL,
  `related_type` longtext DEFAULT NULL,
  `field` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `SEARCH_UPLOAD_FILE_MORPH` (`related_type`,`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for users-permissions_permission
-- ----------------------------
DROP TABLE IF EXISTS `users-permissions_permission`;
CREATE TABLE `users-permissions_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `controller` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `policy` varchar(255) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `SEARCH_USERS_PERMISSIONS_PERMISSION` (`type`,`controller`,`action`,`policy`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of users-permissions_permission
-- ----------------------------
BEGIN;
INSERT INTO `users-permissions_permission` VALUES (1, 'content-manager', 'contentmanager', 'models', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (2, 'content-manager', 'contentmanager', 'find', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (3, 'content-manager', 'contentmanager', 'count', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (4, 'content-manager', 'contentmanager', 'findone', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (5, 'content-manager', 'contentmanager', 'create', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (6, 'content-manager', 'contentmanager', 'update', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (7, 'content-manager', 'contentmanager', 'updatesettings', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (8, 'content-manager', 'contentmanager', 'delete', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (9, 'content-manager', 'contentmanager', 'deleteall', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (10, 'content-type-builder', 'contenttypebuilder', 'getmodels', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (11, 'content-type-builder', 'contenttypebuilder', 'getmodel', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (12, 'content-type-builder', 'contenttypebuilder', 'getconnections', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (13, 'content-type-builder', 'contenttypebuilder', 'createmodel', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (14, 'content-type-builder', 'contenttypebuilder', 'updatemodel', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (15, 'content-type-builder', 'contenttypebuilder', 'deletemodel', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (16, 'content-type-builder', 'contenttypebuilder', 'autoreload', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (17, 'content-type-builder', 'contenttypebuilder', 'checktableexists', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (18, 'email', 'email', 'send', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (19, 'email', 'email', 'getenvironments', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (20, 'email', 'email', 'getsettings', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (21, 'email', 'email', 'updatesettings', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (22, 'settings-manager', 'settingsmanager', 'menu', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (23, 'settings-manager', 'settingsmanager', 'environments', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (24, 'settings-manager', 'settingsmanager', 'languages', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (25, 'settings-manager', 'settingsmanager', 'databases', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (26, 'settings-manager', 'settingsmanager', 'database', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (27, 'settings-manager', 'settingsmanager', 'databasemodel', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (28, 'settings-manager', 'settingsmanager', 'get', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (29, 'settings-manager', 'settingsmanager', 'update', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (30, 'settings-manager', 'settingsmanager', 'createlanguage', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (31, 'settings-manager', 'settingsmanager', 'deletelanguage', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (32, 'settings-manager', 'settingsmanager', 'createdatabase', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (33, 'settings-manager', 'settingsmanager', 'updatedatabase', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (34, 'settings-manager', 'settingsmanager', 'deletedatabase', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (35, 'settings-manager', 'settingsmanager', 'autoreload', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (36, 'upload', 'upload', 'upload', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (37, 'upload', 'upload', 'getenvironments', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (38, 'upload', 'upload', 'getsettings', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (39, 'upload', 'upload', 'updatesettings', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (40, 'upload', 'upload', 'find', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (41, 'upload', 'upload', 'findone', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (42, 'upload', 'upload', 'count', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (43, 'upload', 'upload', 'destroy', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (44, 'upload', 'upload', 'search', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (45, 'users-permissions', 'auth', 'callback', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (46, 'users-permissions', 'auth', 'changepassword', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (47, 'users-permissions', 'auth', 'connect', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (48, 'users-permissions', 'auth', 'forgotpassword', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (49, 'users-permissions', 'auth', 'register', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (50, 'users-permissions', 'auth', 'emailconfirmation', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (51, 'users-permissions', 'user', 'find', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (52, 'users-permissions', 'user', 'me', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (53, 'users-permissions', 'user', 'findone', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (54, 'users-permissions', 'user', 'create', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (55, 'users-permissions', 'user', 'update', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (56, 'users-permissions', 'user', 'destroy', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (57, 'users-permissions', 'user', 'destroyall', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (58, 'users-permissions', 'userspermissions', 'createrole', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (59, 'users-permissions', 'userspermissions', 'deleteprovider', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (60, 'users-permissions', 'userspermissions', 'deleterole', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (61, 'users-permissions', 'userspermissions', 'getpermissions', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (62, 'users-permissions', 'userspermissions', 'getpolicies', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (63, 'users-permissions', 'userspermissions', 'getrole', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (64, 'users-permissions', 'userspermissions', 'getroles', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (65, 'users-permissions', 'userspermissions', 'getroutes', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (66, 'users-permissions', 'userspermissions', 'index', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (67, 'users-permissions', 'userspermissions', 'init', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (68, 'users-permissions', 'userspermissions', 'searchusers', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (69, 'users-permissions', 'userspermissions', 'updaterole', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (70, 'users-permissions', 'userspermissions', 'getemailtemplate', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (71, 'users-permissions', 'userspermissions', 'updateemailtemplate', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (72, 'users-permissions', 'userspermissions', 'getadvancedsettings', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (73, 'users-permissions', 'userspermissions', 'updateadvancedsettings', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (74, 'users-permissions', 'userspermissions', 'getproviders', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (75, 'users-permissions', 'userspermissions', 'updateproviders', 1, '', 1);
INSERT INTO `users-permissions_permission` VALUES (76, 'content-manager', 'contentmanager', 'models', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (77, 'content-manager', 'contentmanager', 'find', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (78, 'content-manager', 'contentmanager', 'count', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (79, 'content-manager', 'contentmanager', 'findone', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (80, 'content-manager', 'contentmanager', 'create', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (81, 'content-manager', 'contentmanager', 'update', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (82, 'content-manager', 'contentmanager', 'updatesettings', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (83, 'content-manager', 'contentmanager', 'delete', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (84, 'content-manager', 'contentmanager', 'deleteall', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (85, 'content-type-builder', 'contenttypebuilder', 'getmodels', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (86, 'content-type-builder', 'contenttypebuilder', 'getmodel', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (87, 'content-type-builder', 'contenttypebuilder', 'getconnections', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (88, 'content-type-builder', 'contenttypebuilder', 'createmodel', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (89, 'content-type-builder', 'contenttypebuilder', 'updatemodel', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (90, 'content-type-builder', 'contenttypebuilder', 'deletemodel', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (91, 'content-type-builder', 'contenttypebuilder', 'autoreload', 1, '', 2);
INSERT INTO `users-permissions_permission` VALUES (92, 'content-type-builder', 'contenttypebuilder', 'checktableexists', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (93, 'email', 'email', 'send', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (94, 'email', 'email', 'getenvironments', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (95, 'email', 'email', 'getsettings', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (96, 'email', 'email', 'updatesettings', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (97, 'settings-manager', 'settingsmanager', 'menu', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (98, 'settings-manager', 'settingsmanager', 'environments', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (99, 'settings-manager', 'settingsmanager', 'languages', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (100, 'settings-manager', 'settingsmanager', 'databases', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (101, 'settings-manager', 'settingsmanager', 'database', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (102, 'settings-manager', 'settingsmanager', 'databasemodel', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (103, 'settings-manager', 'settingsmanager', 'get', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (104, 'settings-manager', 'settingsmanager', 'update', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (105, 'settings-manager', 'settingsmanager', 'createlanguage', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (106, 'settings-manager', 'settingsmanager', 'deletelanguage', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (107, 'settings-manager', 'settingsmanager', 'createdatabase', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (108, 'settings-manager', 'settingsmanager', 'updatedatabase', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (109, 'settings-manager', 'settingsmanager', 'deletedatabase', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (110, 'settings-manager', 'settingsmanager', 'autoreload', 1, '', 2);
INSERT INTO `users-permissions_permission` VALUES (111, 'upload', 'upload', 'upload', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (112, 'upload', 'upload', 'getenvironments', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (113, 'upload', 'upload', 'getsettings', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (114, 'upload', 'upload', 'updatesettings', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (115, 'upload', 'upload', 'find', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (116, 'upload', 'upload', 'findone', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (117, 'upload', 'upload', 'count', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (118, 'upload', 'upload', 'destroy', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (119, 'upload', 'upload', 'search', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (120, 'users-permissions', 'auth', 'callback', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (121, 'users-permissions', 'auth', 'changepassword', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (122, 'users-permissions', 'auth', 'connect', 1, '', 2);
INSERT INTO `users-permissions_permission` VALUES (123, 'users-permissions', 'auth', 'forgotpassword', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (124, 'users-permissions', 'auth', 'register', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (125, 'users-permissions', 'auth', 'emailconfirmation', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (126, 'users-permissions', 'user', 'find', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (127, 'users-permissions', 'user', 'me', 1, '', 2);
INSERT INTO `users-permissions_permission` VALUES (128, 'users-permissions', 'user', 'findone', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (129, 'users-permissions', 'user', 'create', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (130, 'users-permissions', 'user', 'update', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (131, 'users-permissions', 'user', 'destroy', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (132, 'users-permissions', 'user', 'destroyall', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (133, 'users-permissions', 'userspermissions', 'createrole', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (134, 'users-permissions', 'userspermissions', 'deleteprovider', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (135, 'users-permissions', 'userspermissions', 'deleterole', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (136, 'users-permissions', 'userspermissions', 'getpermissions', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (137, 'users-permissions', 'userspermissions', 'getpolicies', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (138, 'users-permissions', 'userspermissions', 'getrole', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (139, 'users-permissions', 'userspermissions', 'getroles', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (140, 'users-permissions', 'userspermissions', 'getroutes', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (141, 'users-permissions', 'userspermissions', 'index', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (142, 'users-permissions', 'userspermissions', 'init', 1, '', 2);
INSERT INTO `users-permissions_permission` VALUES (143, 'users-permissions', 'userspermissions', 'searchusers', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (144, 'users-permissions', 'userspermissions', 'updaterole', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (145, 'users-permissions', 'userspermissions', 'getemailtemplate', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (146, 'users-permissions', 'userspermissions', 'updateemailtemplate', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (147, 'users-permissions', 'userspermissions', 'getadvancedsettings', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (148, 'users-permissions', 'userspermissions', 'updateadvancedsettings', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (149, 'users-permissions', 'userspermissions', 'getproviders', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (150, 'users-permissions', 'userspermissions', 'updateproviders', 0, '', 2);
INSERT INTO `users-permissions_permission` VALUES (151, 'content-manager', 'contentmanager', 'models', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (152, 'content-manager', 'contentmanager', 'find', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (153, 'content-manager', 'contentmanager', 'count', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (154, 'content-manager', 'contentmanager', 'findone', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (155, 'content-manager', 'contentmanager', 'create', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (156, 'content-manager', 'contentmanager', 'update', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (157, 'content-manager', 'contentmanager', 'updatesettings', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (158, 'content-manager', 'contentmanager', 'delete', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (159, 'content-manager', 'contentmanager', 'deleteall', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (160, 'content-type-builder', 'contenttypebuilder', 'getmodels', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (161, 'content-type-builder', 'contenttypebuilder', 'getmodel', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (162, 'content-type-builder', 'contenttypebuilder', 'getconnections', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (163, 'content-type-builder', 'contenttypebuilder', 'createmodel', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (164, 'content-type-builder', 'contenttypebuilder', 'updatemodel', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (165, 'content-type-builder', 'contenttypebuilder', 'deletemodel', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (166, 'content-type-builder', 'contenttypebuilder', 'autoreload', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (167, 'content-type-builder', 'contenttypebuilder', 'checktableexists', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (168, 'email', 'email', 'send', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (169, 'email', 'email', 'getenvironments', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (170, 'email', 'email', 'getsettings', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (171, 'email', 'email', 'updatesettings', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (172, 'settings-manager', 'settingsmanager', 'menu', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (173, 'settings-manager', 'settingsmanager', 'environments', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (174, 'settings-manager', 'settingsmanager', 'languages', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (175, 'settings-manager', 'settingsmanager', 'databases', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (176, 'settings-manager', 'settingsmanager', 'database', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (177, 'settings-manager', 'settingsmanager', 'databasemodel', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (178, 'settings-manager', 'settingsmanager', 'get', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (179, 'settings-manager', 'settingsmanager', 'update', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (180, 'settings-manager', 'settingsmanager', 'createlanguage', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (181, 'settings-manager', 'settingsmanager', 'deletelanguage', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (182, 'settings-manager', 'settingsmanager', 'createdatabase', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (183, 'settings-manager', 'settingsmanager', 'updatedatabase', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (184, 'settings-manager', 'settingsmanager', 'deletedatabase', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (185, 'settings-manager', 'settingsmanager', 'autoreload', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (186, 'upload', 'upload', 'upload', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (187, 'upload', 'upload', 'getenvironments', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (188, 'upload', 'upload', 'getsettings', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (189, 'upload', 'upload', 'updatesettings', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (190, 'upload', 'upload', 'find', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (191, 'upload', 'upload', 'findone', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (192, 'upload', 'upload', 'count', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (193, 'upload', 'upload', 'destroy', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (194, 'upload', 'upload', 'search', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (195, 'users-permissions', 'auth', 'callback', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (196, 'users-permissions', 'auth', 'changepassword', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (197, 'users-permissions', 'auth', 'connect', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (198, 'users-permissions', 'auth', 'forgotpassword', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (199, 'users-permissions', 'auth', 'register', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (200, 'users-permissions', 'auth', 'emailconfirmation', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (201, 'users-permissions', 'user', 'find', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (202, 'users-permissions', 'user', 'me', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (203, 'users-permissions', 'user', 'findone', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (204, 'users-permissions', 'user', 'create', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (205, 'users-permissions', 'user', 'update', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (206, 'users-permissions', 'user', 'destroy', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (207, 'users-permissions', 'user', 'destroyall', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (208, 'users-permissions', 'userspermissions', 'createrole', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (209, 'users-permissions', 'userspermissions', 'deleteprovider', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (210, 'users-permissions', 'userspermissions', 'deleterole', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (211, 'users-permissions', 'userspermissions', 'getpermissions', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (212, 'users-permissions', 'userspermissions', 'getpolicies', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (213, 'users-permissions', 'userspermissions', 'getrole', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (214, 'users-permissions', 'userspermissions', 'getroles', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (215, 'users-permissions', 'userspermissions', 'getroutes', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (216, 'users-permissions', 'userspermissions', 'index', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (217, 'users-permissions', 'userspermissions', 'init', 1, '', 3);
INSERT INTO `users-permissions_permission` VALUES (218, 'users-permissions', 'userspermissions', 'searchusers', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (219, 'users-permissions', 'userspermissions', 'updaterole', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (220, 'users-permissions', 'userspermissions', 'getemailtemplate', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (221, 'users-permissions', 'userspermissions', 'updateemailtemplate', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (222, 'users-permissions', 'userspermissions', 'getadvancedsettings', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (223, 'users-permissions', 'userspermissions', 'updateadvancedsettings', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (224, 'users-permissions', 'userspermissions', 'getproviders', 0, '', 3);
INSERT INTO `users-permissions_permission` VALUES (225, 'users-permissions', 'userspermissions', 'updateproviders', 0, '', 3);
COMMIT;

-- ----------------------------
-- Table structure for users-permissions_role
-- ----------------------------
DROP TABLE IF EXISTS `users-permissions_role`;
CREATE TABLE `users-permissions_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `SEARCH_USERS_PERMISSIONS_ROLE` (`name`,`description`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of users-permissions_role
-- ----------------------------
BEGIN;
INSERT INTO `users-permissions_role` VALUES (1, 'Administrator', 'These users have all access in the project.', 'root');
INSERT INTO `users-permissions_role` VALUES (2, 'Authenticated', 'Default role given to authenticated user.', 'authenticated');
INSERT INTO `users-permissions_role` VALUES (3, 'Public', 'Default role given to unauthenticated user.', 'public');
COMMIT;

-- ----------------------------
-- Table structure for users-permissions_user
-- ----------------------------
DROP TABLE IF EXISTS `users-permissions_user`;
CREATE TABLE `users-permissions_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `resetPasswordToken` varchar(255) DEFAULT NULL,
  `confirmed` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `SEARCH_USERS_PERMISSIONS_USER` (`username`,`provider`,`resetPasswordToken`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of users-permissions_user
-- ----------------------------
BEGIN;
INSERT INTO `users-permissions_user` VALUES (1, 'itani', 'itani@gmail.com', 'local', '$2a$10$hb7fVUenPi5sT91A/GCSSeyPFgJCEHHmzowh.z7qREZxhPUjPNNIq', NULL, 1, NULL, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
