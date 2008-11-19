/* r91 */
INSERT INTO `sed_bbcode` VALUES (33,'more','str','[more]','<!--more-->',1,1,128,'',0),(34,'more','str','[/more]','&nbsp;',1,1,128,'',0);
INSERT INTO `sed_plugins` VALUES (21, 'header.main', 'search', 'header', 'Search', 'search.header', 10, 1); 
INSERT INTO `sed_plugins` VALUES (22, 'page.first', 'search', 'page', 'Search', 'search.page.first', 10, 1); 
INSERT INTO `sed_plugins` VALUES (23, 'forums.posts.first', 'search', 'forums', 'Search', 'search.forums.posts.first', 10, 1); 

/* r103 */
DELETE FROM `sed_config` WHERE `config_owner` = 'core' AND `config_cat` = 'forums' AND `config_name` = 'antibumpforum' LIMIT 1;

/* r104 */
ALTER TABLE `sed_forum_sections` ADD COLUMN `fs_mastername` varchar(128) NOT NULL;

/* r111 */
ALTER TABLE `sed_forum_sections` ADD COLUMN `fs_allowviewers` tinyint(1) NOT NULL default '1';
ALTER TABLE `sed_users` ADD COLUMN `user_theme` VARCHAR(16) NOT NULL DEFAULT '';

/* r112 Title Mask Enhancments */
UPDATE `sed_config` SET `config_cat` = 'title' WHERE `config_cat` = 'main' AND `config_name` IN ('maintitle', 'subtitle') LIMIT 2;
UPDATE `sed_config` SET `config_order` = '01' WHERE `config_cat` = 'main' AND `config_name` = 'mainurl' LIMIT 1;
UPDATE `sed_config` SET `config_order` = '02' WHERE `config_cat` = 'main' AND `config_name` = 'adminemail' LIMIT 1;
UPDATE `sed_config` SET `config_order` = '03' WHERE `config_cat` = 'main' AND `config_name` = 'hostip' LIMIT 1;
UPDATE `sed_config` SET `config_order` = '04' WHERE `config_cat` = 'main' AND `config_name` = 'cache' LIMIT 1;
UPDATE `sed_config` SET `config_order` = '05' WHERE `config_cat` = 'main' AND `config_name` = 'clustermode' LIMIT 1;
UPDATE `sed_config` SET `config_order` = '06' WHERE `config_cat` = 'main' AND `config_name` = 'gzip' LIMIT 1;
UPDATE `sed_config` SET `config_order` = '07' WHERE `config_cat` = 'main' AND `config_name` = 'devmode' LIMIT 1;

INSERT INTO `sed_config` (`config_owner` ,`config_cat` ,`config_order` ,`config_name` ,`config_type` ,`config_value` ,`config_default` ,`config_text`) VALUES ('core', 'title', '03', 'title_forum_main', '01', '{FORUM}', '', ''),('core', 'title', '04', 'title_forum_topics', '01', '{FORUM} - {SECTION}', '', ''),('core', 'title', '05', 'title_forum_posts', '01', '{FORUM} - {TITLE}', '', ''),('core', 'title', '06', 'title_forum_newtopic', '01', '{FORUM} - {SECTION}', '', ''),('core', 'title', '07', 'title_forum_editpost', '01', '{FORUM} - {SECTION}', '', ''),('core', 'title', '08', 'title_list', '01', '{TITLE}', '', ''),('core', 'title', '09', 'title_page', '01', '{TITLE}', '', ''),('core', 'title', '10', 'title_pfs', '01', '{PFS}', '', ''),('core', 'title', '11', 'title_pm_main', '01', '{PM}', '', ''),('core', 'title', '12', 'title_pm_send', '01', '{PM}', '', ''),('core', 'title', '13', 'title_users_main', '01', '{USERS}', '', ''),('core', 'title', '14', 'title_users_details', '01', '{USER} : {NAME}', '', ''),('core', 'title', '15', 'title_users_profile', '01', '{PROFILE}', '', ''),('core', 'title', '16', 'title_users_edit', '01', '{NAME}', '', ''),('core', 'title', '17', 'title_header', '01', '{MAINTITLE} - {SUBTITLE}', '', ''),('core', 'title', '18', 'title_header_index', '01', '{MAINTITLE} - {DESCRIPTION}', '', '');

/* r124 Subforum enhancements */
CREATE TABLE `sed_forum_subforums` (
  `fm_id` smallint(5) NOT NULL default '0',
  `fm_masterid` smallint(5) NOT NULL default '0',
  `fm_title` varchar(128) NOT NULL,
  `fm_lt_id` int(11) NOT NULL default '0',
  `fm_lt_title` varchar(64) NOT NULL default '',
  `fm_lt_date` int(11) NOT NULL default '0',
  `fm_lt_posterid` int(11) NOT NULL default '-1',
  `fm_lt_postername` varchar(24) NOT NULL default ''
) TYPE=MyISAM;

/* r128 Extra fields */
CREATE TABLE `sed_pages_extra_fields` (
  `field_name` varchar(255) NOT NULL,
  `field_type` varchar(255) NOT NULL,
  `field_html` text NOT NULL,
  `field_variants` text NOT NULL,
  UNIQUE KEY `field_name` (`field_name`)
) TYPE=MyISAM;

/* r139 Some speed up for page listings */
ALTER TABLE sed_structure ADD COLUMN structure_pagecount mediumint(8) NOT NULL default '0';

/* r143 t#105, Forum topic preview */
ALTER TABLE sed_forum_topics ADD COLUMN ft_preview varchar(128) NOT NULL default '';

/* r145 for edited plugins - recentitems and  recentpolls->indexpolls */
INSERT INTO `sed_config` (`config_owner` ,`config_cat` ,`config_order` ,`config_name` ,`config_type` ,`config_value` ,`config_default` ,`config_text`) VALUES ('plug', 'indexpolls', '2', 'mode', '2', 'Recent polls', 'Recent polls,Random polls', 'Mode polls displayed'),('plug', 'indexpolls', '1', 'maxpolls', '2', '1', '0,1,2,3,4,5', 'Polls displayed');

INSERT INTO `sed_plugins` VALUES (32, 'index.tags', 'indexpolls', 'main', 'Indexpolls', 'indexpolls', 10, 1);
INSERT INTO `sed_plugins` VALUES (31, 'polls.main', 'indexpolls', 'indexpolls', 'Indexpolls', 'indexpolls.main', 10, 1);

INSERT INTO `sed_auth` VALUES (582, 1, 'plug', 'indexpolls', 1, 254, 1);
INSERT INTO `sed_auth` VALUES (579, 2, 'plug', 'indexpolls', 1, 254, 1);
INSERT INTO `sed_auth` VALUES (580, 3, 'plug', 'indexpolls', 0, 255, 1);
INSERT INTO `sed_auth` VALUES (581, 4, 'plug', 'indexpolls', 1, 254, 1);
INSERT INTO `sed_auth` VALUES (577, 5, 'plug', 'indexpolls', 255, 255, 1);
INSERT INTO `sed_auth` VALUES (578, 6, 'plug', 'indexpolls', 1, 254, 1);

DELETE FROM `sed_config` WHERE `config_owner`='plug' AND `config_cat`='recentitems' AND `config_name`='maxpolls' LIMIT 1;
INSERT INTO `sed_config` VALUES ('plug', 'recentitems', 5, 'redundancy', 2, '2', '1,2,3,4,5', 'Redundancy to come over "private topics" problem');

UPDATE `sed_config` SET `config_value` = 'UTF-8' WHERE `config_cat` = 'skin' AND `config_name` = 'charset' LIMIT 1;

/* r150 Adding markitup`s tags by default */
INSERT INTO `sed_bbcode` (`bbc_id`, `bbc_name`, `bbc_mode`, `bbc_pattern`, `bbc_replacement`, `bbc_container`, `bbc_enabled`, `bbc_priority`, `bbc_plug`, `bbc_postrender`) VALUES
(35, 'h1', 'str', '[h1]', '<h1>', 1, 1, 128, 'markitup', 0),
(36, 'h1', 'str', '[/h1]', '</h1>', 1, 1, 128, 'markitup', 0),
(37, 'h2', 'str', '[h2]', '<h2>', 1, 1, 128, 'markitup', 0),
(38, 'h2', 'str', '[/h2]', '</h2>', 1, 1, 128, 'markitup', 0),
(39, 'h3', 'str', '[h3]', '<h3>', 1, 1, 128, 'markitup', 0),
(40, 'h3', 'str', '[/h3]', '</h3>', 1, 1, 128, 'markitup', 0),
(41, 'h4', 'str', '[h4]', '<h4>', 1, 1, 128, 'markitup', 0),
(42, 'h4', 'str', '[/h4]', '</h4>', 1, 1, 128, 'markitup', 0),
(43, 'h5', 'str', '[h5]', '<h5>', 1, 1, 128, 'markitup', 0),
(44, 'h5', 'str', '[/h5]', '</h5>', 1, 1, 128, 'markitup', 0),
(45, 'h6', 'str', '[h6]', '<h6>', 1, 1, 128, 'markitup', 0),
(46, 'h6', 'str', '[/h6]', '</h6>', 1, 1, 128, 'markitup', 0),
(47, 'size', 'pcre', '\\[size=([1-2][0-9])\\](.+?)\\[/size\\]', '<span style="font-size:$1pt">$2</span>', 1, 1, 128, 'markitup', 0),
(48, 'list', 'pcre', '\\[list\\](.+?)\\[/list\\]', '<ul>$1</ul>', 1, 1, 128, 'markitup', 0),
(49, 'list', 'pcre', '\\[list=(\\w)\\](.+?)\\[/list\\]', '<ol type="$1">$2</ol>', 1, 1, 128, 'markitup', 0),
(50, 'li', 'str', '[li]', '<li>', 1, 1, 128, 'markitup', 0),
(51, 'li', 'str', '[/li]', '</li>', 1, 1, 128, 'markitup', 0),
(52, 'table', 'str', '[table]', '<table>', 1, 1, 128, 'markitup', 0),
(53, 'table', 'str', '[/table]', '</table>', 1, 1, 128, 'markitup', 0),
(54, 'tr', 'str', '[tr]', '<tr>', 1, 1, 128, 'markitup', 0),
(55, 'tr', 'str', '[/tr]', '</tr>', 1, 1, 128, 'markitup', 0),
(56, 'th', 'str', '[th]', '<th>', 1, 1, 128, 'markitup', 0),
(57, 'th', 'str', '[/th]', '</th>', 1, 1, 128, 'markitup', 0),
(58, 'td', 'str', '[td]', '<td>', 1, 1, 128, 'markitup', 0),
(59, 'td', 'str', '[/td]', '</td>', 1, 1, 128, 'markitup', 0),
(60, 'hide', 'callback', '\\[hide\\](.+?)\\[/hide\\]', 'return $usr["id"] > 0 ? $input[1] : "<div class=\\"hidden\\">".$L["Hidden"]."</div>";', 1, 1, 150, 'markitup', 1),
(61, 'spoiler', 'pcre', '\\[spoiler=([^\\]]+)\\](.+?)\\[/spoiler\\]', '<div style="margin:4px 0px 4px 0px"><input type="button" value="$1" onclick="if(this.parentNode.getElementsByTagName(''div'')[0].style.display != '''') { this.parentNode.getElementsByTagName(''div'')[0].style.display = ''''; } else { this.parentNode.getElementsByTagName(''div'')[0].style.display = ''none''; }" /><div style="display:none" class="spoiler">$2</div></div>', 1, 1, 130, 'markitup', 0),
(62, 'thumb', 'pcre', '\\[thumb=(.*?[^"\\'';:\\?]+\\.(?:jpg|jpeg|gif|png))\\](.*?[^"\\'';:\\?]+\\.(?:jpg|jpeg|gif|png))\\[/thumb\\]', '<a href="datas/users/$2"><img src="$1" alt="$2" /></a>', 1, 1, 128, '', 0),
(63, 'thumb', 'pcre', '\\[thumb\\](.*?[^"\\'';:\\?]+\\.(?:jpg|jpeg|gif|png))\\[/thumb\\]', '<a href="datas/users/$1"><img src="datas/thumbs/$1" /></a>', 1, 1, 128, '', 0),
(64, 'pfs', 'pcre', '\\[pfs\\](.*?[^"\\'';:\\?]+\\.(?:jpg|jpeg|gif|png|zip|rar|7z|pdf|txt))\\[/pfs\\]', '<strong><a href="datas/users/$1">$1</a></strong>', 1, 1, 128, '', 0);

/* r153 Maintenance mode */
INSERT INTO sed_config (config_owner, config_cat, config_order, config_name, config_type, config_value) VALUES ('core', 'main', '07', 'mtmode', 3, '0');
INSERT INTO sed_config (config_owner, config_cat, config_order, config_name, config_type, config_value) VALUES ('core', 'main', '07', 'mtres', 1, '');

ALTER TABLE sed_groups ADD COLUMN grp_maintenance tinyint(1) NOT NULL default '0';

UPDATE sed_groups SET grp_maintenance = '1' WHERE grp_alias = 'administrators';
UPDATE sed_groups SET grp_maintenance = '1' WHERE grp_alias = 'moderators';

/* r155 Fix pfs bbcode */
UPDATE `sed_bbcode` SET `bbc_replacement` = '<strong><a href="datas/users/$1">$1</a></strong>' WHERE `bbc_id` =64