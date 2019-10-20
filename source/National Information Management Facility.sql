CREATE TABLE `organisation` (
`organisation_id` int(11) NOT NULL AUTO_INCREMENT,
`organisation_type` enum("COMPANY","ASSOCIATION","NGO","RESEARCH INSTITUTION","RFMO","LAW ENFORCEMENT","MILITARY","GOVENMENT AGENCY","OTHER") NULL,
`organisation` varchar(255) NULL,
`organisation_phone` varchar(255) NULL,
`organisation_email` varchar(255) NULL,
`organisation_postal_address` varchar(255) NULL,
`registration_number` varchar(255) NULL,
`registration_country` char(2) NULL,
`notes` varchar(255) NULL,
PRIMARY KEY (`organisation_id`) 
);

CREATE TABLE `vessel` (
`vessel_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`vessel_name` varchar(255) NOT NULL COMMENT 'The official registered name of the vessel',
`vessel_category` enum("Fishing","Bunker","Carrier","Support","Research","Other") NOT NULL COMMENT 'The Category of the Vessel',
`vessel_type` enum("Purse Seiners","Longliners","Pole and Line","Trawllers") CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Type of Fishing Vessel as defined in the FAO ISSFV standards',
`vessel_uvi` int(11) NULL,
`vessel_wcpfc_vid` int(11) NULL,
`vessel_ffa_vid` int(11) NULL,
`vessel_mmsi` varchar(255) NULL,
`vessel_flag` char(2) NULL,
`vessel_flag_registration_number` varchar(60) NULL,
`vessel_length_overall` decimal(11,5) NULL,
`vessel_gross_tonnage` decimal(11,5) NULL,
`vessel_storage_capacity` decimal(11,5) NULL,
`vessel_fuel_capacity` decimal(11,5) NULL,
`vessel_engine_power` varchar(255) NULL,
`vessel_is_chartered` tinyint(1) NULL,
`organisation_id` int(11) NULL,
`notes` text NULL,
PRIMARY KEY (`vessel_id`) 
);

CREATE TABLE `vessel_permit` (
`permit_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`vessel_id` int(11) NULL,
`permit_start_date` datetime NULL,
`permit_end_date` datetime NULL,
`permit_issue_date` datetime NULL,
`permit_issued_by` varchar(255) NULL,
`permit_area` varchar(255) NULL,
`agreement_id` int(11) NULL,
`permit_type` enum("FISH","TRANSHIP","UNLOAD","ENTER ZONE","ENTER PORT","EXIT PORT","EXIT ZONE") NULL,
`notes` varchar(255) NULL,
PRIMARY KEY (`permit_id`) 
);

CREATE TABLE `agreement` (
`agreement_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`agreement_type` enum("BILATERAL","PSMA","US TREATY") NULL,
`agreement_name` varchar(255) NULL,
`agreement_stat_date` datetime NULL,
`agreement_end_date` datetime NULL,
`agreement_issue_date` datetime NULL,
`notes` varchar(255) NULL,
PRIMARY KEY (`agreement_id`) 
);

CREATE TABLE `vessel_tracks` (
`position_id` bigint(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`vessel_id` int(11) NOT NULL,
`latitude` decimal(11,8) NOT NULL,
`longditude` decimal(11,8) NOT NULL,
`datetime` datetime NOT NULL,
`position` point NULL,
PRIMARY KEY (`position_id`) 
);

CREATE TABLE `vessel_catch` (
`vessel_catch_id` int(11) NOT NULL,
`vessel_id` int(11) NULL,
`permit_id` int(11) NULL,
`vessel_catch_datetime` datetime NULL,
`vessel_catch_latitude` decimal(11,8) NULL,
`vessel_catch_longditude` decimal(11,8) NULL,
`vessel_catch_position` point NULL,
`supporting_documents` varchar(255) NULL,
PRIMARY KEY (`vessel_catch_id`) 
);

CREATE TABLE `vessel_offload` (
`vessel_offload_id` int(11) NOT NULL,
`vessel_catch_id` int(11) NOT NULL,
`vessel_id` int(11) NULL,
`permit_id` int(11) NULL,
`vessel_offload_type` enum("UNLOADING","TRANSHIPMENT") NOT NULL,
`vessel_offload_from` int(11) NOT NULL,
`vessel_offload_to` int(11) NULL,
`supporting_documents` varchar(255) NULL,
`port_id` int(11) NULL,
`offload_latitude` varchar(11) NULL,
`offload_longditude` decimal(11,8) NULL,
`offload_postiion` point NULL,
`offload_datetime` datetime NULL,
`captain_id` int(11) NULL,
`is_different` bool NULL,
`fishingmaster_id` int(11) NULL,
PRIMARY KEY (`vessel_offload_id`) 
);

CREATE TABLE `destination` (
`destination_id` int(11) NOT NULL,
`destination_type` enum("PROCESSING PLANT","COLD STORE","EXPORT DESTINATION","OTHER") NOT NULL,
`destination_name` varchar(255) NOT NULL,
`destination_national_identifier` char(36) NULL,
`destination_latitude` decimal(11,8) NULL,
`destination_longditude` decimal(11,8) NULL,
`destination_position` point NULL,
`notes` varchar(255) NULL,
PRIMARY KEY (`destination_id`) 
);

CREATE TABLE `factory_ownership` (
`ownership_id` int(11) NOT NULL,
`organisation_id` int(11) NULL,
`factory_id` int(11) NULL,
PRIMARY KEY (`ownership_id`) 
);

CREATE TABLE `catch_offload` (
`catch_offload_id` int(11) NOT NULL,
`vessel_offload_id` int(11) NULL,
`catch_species` enum("SKIPJACK","YELLOWFIN","ALBACORE","BIG EYE","OTHER TUNA SPECIES","OTHER FISH SPECIES") NULL,
`catch_weight` double NULL,
`catch_count` int(11) NULL,
`destination_id` int(11) NULL,
PRIMARY KEY (`catch_offload_id`) 
);

CREATE TABLE `port` (
`port_id` int(11) NOT NULL,
`port_name` varchar(255) NULL,
`port_unlocode` char(5) NULL,
`port_latitude` decimal(11,8) NULL,
`port_longditude` decimal(11,8) NULL,
`port_position` point NULL,
PRIMARY KEY (`port_id`) 
);

CREATE TABLE `person` (
`person_id` int(11) NOT NULL,
`person_first_name` varchar(255) NOT NULL,
`person_last_name` varchar(255) NOT NULL,
`person_passport_number` char(36) NOT NULL,
`person_passport_country` char(2) NOT NULL,
`person_passport_gender` enum("Male","Female","Other") NULL,
`person_passport_birthdate` date NULL,
`person_passport_expiry` date NULL,
`supporting_documents` varchar(255) NULL,
`notes` varchar(255) NULL,
PRIMARY KEY (`person_id`) 
);

CREATE TABLE `catch` (
`catch_id` int(11) NOT NULL,
`catch_species` enum("SKIPJACK","YELLOWFIN","ALBACORE","BIG EYE","OTHER TUNA SPECIES","OTHER FISH SPECIES") NULL,
`catch_weight` double NULL,
`catch_count` int(11) NULL,
PRIMARY KEY (`catch_id`) 
);

CREATE TABLE `export_certificate` (
`catch_certificate_id` int(11) UNSIGNED NOT NULL COMMENT 'The person who issued the certificate',
`certificate_status` enum("PENDING","APPROVED","DENIED","REVOKED") NULL,
`certificate_issued_date` datetime NULL,
`certificate_issued_by_id` int(11) NULL,
`export_company_id` int(11) NULL,
`consignee_id` int(11) NULL,
`authority_id` int(11) NULL,
`export_shipment_number` int NULL,
`export_booking_number` int NULL,
`total_process_quantity` decimal(11,4) NULL,
`total_export_quantity` varchar(11) NULL,
PRIMARY KEY (`catch_certificate_id`) 
);

CREATE TABLE `export_product` (
`export_product_id` int(11) NOT NULL,
`catch_certificate_id` int(11) NOT NULL,
`vessel_id` int(11) NOT NULL,
`vessel_permit_id` int(11) NOT NULL,
`vessel_catch_id` int(11) NOT NULL,
`vessel_offload_id` int(11) NOT NULL,
`product_type` enum("CANS","FROZEN COOKED LOINS","FROZEN FRESH LOINS","FROZEN FRESH FLAKES","STEAKS","WHOLE ROUND FROZEN","FRESH CHILLED LOINS","WHOLE ROUND CHILL FRESH") NULL,
`species` varchar(255) NULL COMMENT '\"SKIPJACK\",\"YELLOWFIN\",\"ALBACORE\",\"BIG EYE\",\"OTHER TUNA SPECIES\",\"OTHER FISH SPECIES\"',
`export_quantity` decimal(11,0) NULL,
`process_quantity` varchar(255) NULL,
`customs_product_code` varchar(255) NULL,
`customs_container_number` varchar(255) NULL,
PRIMARY KEY (`export_product_id`) 
);

CREATE TABLE `product` (
`product_id` int(11) NOT NULL AUTO_INCREMENT,
`product_type` enum() NULL,
`species` enum() NULL,
`product_description` varchar(11) NULL,
PRIMARY KEY (`product_id`) 
);

CREATE TABLE `catch_onboard` (
`catch_onboard_id` int(11) NOT NULL,
`port_entry_id` int(11) NULL,
`movement_type` enum("ZONE ENTRY","PORT ENTRY","PORT EXIT","ZONE EXIT") NULL,
`species` enum("SKIPJACK","YELLOWFIN","ALBACORE","BIG EYE","OTHER TUNA SPECIES","OTHER FISH SPECIES") NULL,
`weight` double NULL,
`count` int(11) NULL,
`destination_id` int(11) NULL,
PRIMARY KEY (`catch_onboard_id`) 
);

CREATE TABLE `port_entry` (
`port_entry_id` int(11) NOT NULL,
`port_id` int(11) NULL,
`vessel_id` int(11) NULL,
`permit_id` int(11) NULL,
`request_date` datetime NULL,
`arrival_date` datetime NULL,
`departure_date` datetime NULL,
PRIMARY KEY (`port_entry_id`) 
);

CREATE TABLE `agreement_partners` (
`partner_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`partner_name` varchar(255) NULL,
`notes` varchar(255) NULL,
`agreement_id` int(11) NULL,
PRIMARY KEY (`partner_id`) 
);

CREATE TABLE `factory` (
`factory_id` int(11) NOT NULL,
`destination_id` int(11) NULL,
PRIMARY KEY (`factory_id`) 
);


ALTER TABLE `organisation` ADD CONSTRAINT `fk_organisation_vessel_1` FOREIGN KEY (`organisation_id`) REFERENCES `vessel` (`organisation_id`);
ALTER TABLE `vessel` ADD CONSTRAINT `fk_vessel_vessel_permit_1` FOREIGN KEY (`vessel_id`) REFERENCES `vessel_permit` (`vessel_id`);
ALTER TABLE `agreement` ADD CONSTRAINT `fk_agreement_vessel_permit_1` FOREIGN KEY (`agreement_id`) REFERENCES `vessel_permit` (`agreement_id`);
ALTER TABLE `vessel_catch` ADD CONSTRAINT `fk_vessel_catch_vessel_tranship_1` FOREIGN KEY (`vessel_catch_id`) REFERENCES `vessel_offload` (`vessel_catch_id`);
ALTER TABLE `organisation` ADD CONSTRAINT `fk_organisation_owners_1` FOREIGN KEY (`organisation_id`) REFERENCES `factory_ownership` (`organisation_id`);
ALTER TABLE `vessel_offload` ADD CONSTRAINT `fk_vessel_offload_catch_tranship_catch_1` FOREIGN KEY (`vessel_offload_id`) REFERENCES `catch_offload` (`vessel_offload_id`);
ALTER TABLE `vessel_catch` ADD CONSTRAINT `fk_vessel_catch_catch_1` FOREIGN KEY (`vessel_catch_id`) REFERENCES `catch` (`catch_id`);
ALTER TABLE `export_certificate` ADD CONSTRAINT `fk_catch_certificate_export_product_1` FOREIGN KEY (`catch_certificate_id`) REFERENCES `export_product` (`catch_certificate_id`);
ALTER TABLE `agreement` ADD CONSTRAINT `fk_agreement_agreement_partners_1` FOREIGN KEY (`agreement_id`) REFERENCES `agreement_partners` (`agreement_id`);
ALTER TABLE `port_entry` ADD CONSTRAINT `fk_port_entry_catch_onboard_1` FOREIGN KEY (`port_entry_id`) REFERENCES `catch_onboard` (`port_entry_id`);
ALTER TABLE `destination` ADD CONSTRAINT `fk_destination_ownership_1` FOREIGN KEY (`destination_id`) REFERENCES `factory_ownership` (`factory_id`);

