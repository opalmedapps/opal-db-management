ALTER TABLE `Appointment`
    ADD COLUMN `CheckinUsername` VARCHAR(225) NOT NULL DEFAULT '' COMMENT 'Firebase username of the user who checked in.' AFTER `Checkin`;
