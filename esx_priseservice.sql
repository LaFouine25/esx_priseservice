CREATE TABLE `prisesdeservices` (
	`identifier` VARCHAR(25) NOT NULL COMMENT 'Identifiant Steam du joueur',
	`job` VARCHAR(25) NOT NULL,
	`grade` INT(2) NOT NULL DEFAULT 0,
	`onoff` INT(1) NOT NULL DEFAULT 1 COMMENT '0 Hors service, 1 En service',
	UNIQUE INDEX `identifier` (`identifier`),
	INDEX `job` (`job`)
)
COMMENT='Table de correspondance entre Hors Service et En Service'
COLLATE='utf8mb4_general_ci'
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES ('police', 99, 'horsservice', 'Hors Service', 0, '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES ('ambulance', 99, 'horsservice', 'Hors Service', 0, '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES ('sheriff', 99, 'horsservice', 'Hors Service', 0, '{}', '{}');
