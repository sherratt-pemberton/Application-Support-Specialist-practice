-- ===============================
-- Application Support Practice DB
-- ===============================

DROP DATABASE IF EXISTS app_support_practice_medical;
CREATE DATABASE app_support_practice_medical;
USE app_support_practice_medical;

-- ===============================
-- Tables
-- ===============================

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    status VARCHAR(20) , -- active, locked, inactive
    created_at DATETIME
);

CREATE TABLE applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    app_name VARCHAR(100),
    environment VARCHAR(20) -- prod, test
);

CREATE TABLE user_access (
    access_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    application_id INT,
    access_level VARCHAR(20), -- read, write, admin
    granted_at DATETIME,
    status VARCHAR(20) NOT NULL DEFAULT 'active',       -- active / revoked
	revoked_at DATETIME NUlL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
);

CREATE TABLE incidents (
    incident_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    application_id INT,
    severity VARCHAR(10), -- low, medium, high
    status VARCHAR(20), -- open, resolved
    created_at DATETIME,
    resolved_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
);