CREATE DATABASE test;
USE test;
CREATE TABLE IF NOT EXISTS ticket (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    mask VARCHAR(16) DEFAULT '' NOT NULL,
    subject VARCHAR(255)  DEFAULT '' NOT NULL,
    is_closed TINYINT(1) UNSIGNED DEFAULT 0 NOT NULL,
    is_deleted TINYINT(1) UNSIGNED DEFAULT 0 NOT NULL,
    team_id INT UNSIGNED DEFAULT 0 NOT NULL,
    category_id INT UNSIGNED DEFAULT 0 NOT NULL,
    first_message_id INT UNSIGNED DEFAULT 0 NOT NULL,
    created_date INT UNSIGNED,
    updated_date INT UNSIGNED,
    due_date INT UNSIGNED,
    first_wrote_address_id INT UNSIGNED NOT NULL DEFAULT 0,
    last_wrote_address_id INT UNSIGNED NOT NULL DEFAULT 0,
    spam_score DECIMAL(4,4) NOT NULL DEFAULT 0,
    spam_training VARCHAR(1) NOT NULL DEFAULT '',
    interesting_words VARCHAR(255) NOT NULL DEFAULT '',
    next_action VARCHAR(255) NOT NULL DEFAULT '',
    PRIMARY KEY (id)
) ENGINE=InnoDB;
 
ALTER TABLE ticket 
    CHANGE COLUMN team_id group_id INT UNSIGNED NOT NULL DEFAULT 0,
    CHANGE COLUMN category_id bucket_id INT UNSIGNED NOT NULL DEFAULT 0,
    ADD COLUMN org_id INT UNSIGNED NOT NULL DEFAULT 0, 
    ADD INDEX org_id (org_id);