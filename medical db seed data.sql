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
    status VARCHAR(20), -- active, locked, inactive
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
    status VARCHAR(20),       -- active / revoked
	revoked_at DATETIME,
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

-- ===============================
-- Applications
-- ===============================

INSERT INTO applications (app_name, environment) VALUES
('Clinical Records', 'prod'),
('Reporting Tool', 'prod'),
('User Management', 'prod'),
('Audit Logging', 'prod'),
('Reporting Tool', 'test');

-- ===============================
-- Users (realistic names)
-- ~600 users
-- ===============================

INSERT INTO users (full_name, email, status, created_at) VALUES
('James Wilson', 'james.wilson@example.com', 'active', NOW() - INTERVAL 400 DAY),
('Sarah Thompson', 'sarah.thompson@example.com', 'active', NOW() - INTERVAL 380 DAY),
('Michael Brown', 'michael.brown@example.com', 'locked', NOW() - INTERVAL 370 DAY),
('Emily Johnson', 'emily.johnson@example.com', 'active', NOW() - INTERVAL 360 DAY),
('Daniel Carter', 'daniel.carter@example.com', 'inactive', NOW() - INTERVAL 350 DAY),
('Rachel Lee', 'rachel.lee@example.com', 'active', NOW() - INTERVAL 340 DAY),
('Thomas Nguyen', 'thomas.nguyen@example.com', 'active', NOW() - INTERVAL 330 DAY),
('Olivia Harris', 'olivia.harris@example.com', 'active', NOW() - INTERVAL 320 DAY),
('Liam Patel', 'liam.patel@example.com', 'locked', NOW() - INTERVAL 310 DAY),
('Hannah Martin', 'hannah.martin@example.com', 'active', NOW() - INTERVAL 300 DAY);

-- Generate bulk users
INSERT INTO applications (application_id, app_name, environment) VALUES
(1,'Clinical Records','prod'),
(2,'Reporting Tool','prod'),
(3,'Reporting Tool','test'),
(4,'User Management','prod'),
(5,'Audit Logging','prod');

-- =====================
-- USERS (100 real names)
-- =====================
INSERT INTO users (user_id,name,email,status,created_at) VALUES
(1,'James Wilson','james.wilson@example.com','active',NOW()-INTERVAL 300 DAY),
(2,'Emily Thompson','emily.thompson@example.com','active',NOW()-INTERVAL 295 DAY),
(3,'Oliver Martin','oliver.martin@example.com','locked',NOW()-INTERVAL 290 DAY),
(4,'Charlotte Brown','charlotte.brown@example.com','active',NOW()-INTERVAL 285 DAY),
(5,'Liam Anderson','liam.anderson@example.com','inactive',NOW()-INTERVAL 280 DAY),
(6,'Amelia Taylor','amelia.taylor@example.com','active',NOW()-INTERVAL 275 DAY),
(7,'Noah Harris','noah.harris@example.com','active',NOW()-INTERVAL 270 DAY),
(8,'Isla Clark','isla.clark@example.com','active',NOW()-INTERVAL 265 DAY),
(9,'Ethan Lewis','ethan.lewis@example.com','locked',NOW()-INTERVAL 260 DAY),
(10,'Sophia Walker','sophia.walker@example.com','active',NOW()-INTERVAL 255 DAY),
(11,'Benjamin Hall','benjamin.hall@example.com','active',NOW()-INTERVAL 250 DAY),
(12,'Mia Allen','mia.allen@example.com','active',NOW()-INTERVAL 245 DAY),
(13,'Lucas Young','lucas.young@example.com','inactive',NOW()-INTERVAL 240 DAY),
(14,'Ella King','ella.king@example.com','active',NOW()-INTERVAL 235 DAY),
(15,'Henry Wright','henry.wright@example.com','active',NOW()-INTERVAL 230 DAY),
(16,'Ava Lopez','ava.lopez@example.com','active',NOW()-INTERVAL 225 DAY),
(17,'Jack Green','jack.green@example.com','active',NOW()-INTERVAL 220 DAY),
(18,'Zoe Adams','zoe.adams@example.com','active',NOW()-INTERVAL 215 DAY),
(19,'Leo Baker','leo.baker@example.com','locked',NOW()-INTERVAL 210 DAY),
(20,'Lily Gonzalez','lily.gonzalez@example.com','active',NOW()-INTERVAL 205 DAY),
(21,'Oscar Perez','oscar.perez@example.com','active',NOW()-INTERVAL 200 DAY),
(22,'Grace Roberts','grace.roberts@example.com','active',NOW()-INTERVAL 195 DAY),
(23,'Theo Turner','theo.turner@example.com','inactive',NOW()-INTERVAL 190 DAY),
(24,'Ruby Phillips','ruby.phillips@example.com','active',NOW()-INTERVAL 185 DAY),
(25,'Isaac Campbell','isaac.campbell@example.com','active',NOW()-INTERVAL 180 DAY),
(26,'Sophie Parker','sophie.parker@example.com','active',NOW()-INTERVAL 175 DAY),
(27,'Leo Evans','leo.evans@example.com','active',NOW()-INTERVAL 170 DAY),
(28,'Hannah Edwards','hannah.edwards@example.com','locked',NOW()-INTERVAL 165 DAY),
(29,'Daniel Collins','daniel.collins@example.com','active',NOW()-INTERVAL 160 DAY),
(30,'Ella Stewart','ella.stewart@example.com','active',NOW()-INTERVAL 155 DAY),
(31,'Tom Morris','tom.morris@example.com','active',NOW()-INTERVAL 150 DAY),
(32,'Freya Rogers','freya.rogers@example.com','active',NOW()-INTERVAL 145 DAY),
(33,'Max Reed','max.reed@example.com','inactive',NOW()-INTERVAL 140 DAY),
(34,'Nina Cook','nina.cook@example.com','active',NOW()-INTERVAL 135 DAY),
(35,'Owen Morgan','owen.morgan@example.com','active',NOW()-INTERVAL 130 DAY),
(36,'Evie Bell','evie.bell@example.com','active',NOW()-INTERVAL 125 DAY),
(37,'Sam Murphy','sam.murphy@example.com','active',NOW()-INTERVAL 120 DAY),
(38,'Ivy Bailey','ivy.bailey@example.com','locked',NOW()-INTERVAL 115 DAY),
(39,'Alex Rivera','alex.rivera@example.com','active',NOW()-INTERVAL 110 DAY),
(40,'Chloe Cooper','chloe.cooper@example.com','active',NOW()-INTERVAL 105 DAY),
(41,'Ryan Ward','ryan.ward@example.com','active',NOW()-INTERVAL 100 DAY),
(42,'Lucy Brooks','lucy.brooks@example.com','active',NOW()-INTERVAL 95 DAY),
(43,'Nathan Kelly','nathan.kelly@example.com','inactive',NOW()-INTERVAL 90 DAY),
(44,'Maya Price','maya.price@example.com','active',NOW()-INTERVAL 85 DAY),
(45,'Aaron Bennett','aaron.bennett@example.com','active',NOW()-INTERVAL 80 DAY),
(46,'Leah Wood','leah.wood@example.com','active',NOW()-INTERVAL 75 DAY),
(47,'Callum Barnes','callum.barnes@example.com','active',NOW()-INTERVAL 70 DAY),
(48,'Poppy Ross','poppy.ross@example.com','locked',NOW()-INTERVAL 65 DAY),
(49,'Finn Henderson','finn.henderson@example.com','active',NOW()-INTERVAL 60 DAY),
(50,'Sienna Coleman','sienna.coleman@example.com','active',NOW()-INTERVAL 55 DAY),
(51,'Josh Fisher','josh.fisher@example.com','active',NOW()-INTERVAL 50 DAY),
(52,'Tara Simmons','tara.simmons@example.com','active',NOW()-INTERVAL 48 DAY),
(53,'Luke Patterson','luke.patterson@example.com','inactive',NOW()-INTERVAL 46 DAY),
(54,'Molly Grant','molly.grant@example.com','active',NOW()-INTERVAL 44 DAY),
(55,'Evan Porter','evan.porter@example.com','active',NOW()-INTERVAL 42 DAY),
(56,'Anna Hughes','anna.hughes@example.com','active',NOW()-INTERVAL 40 DAY),
(57,'Jake Foster','jake.foster@example.com','active',NOW()-INTERVAL 38 DAY),
(58,'Clara Watson','clara.watson@example.com','locked',NOW()-INTERVAL 36 DAY),
(59,'Ben Howard','ben.howard@example.com','active',NOW()-INTERVAL 34 DAY),
(60,'Nora James','nora.james@example.com','active',NOW()-INTERVAL 32 DAY),
(61,'Peter Long','peter.long@example.com','active',NOW()-INTERVAL 30 DAY),
(62,'Ellie Scott','ellie.scott@example.com','active',NOW()-INTERVAL 28 DAY),
(63,'Adam Reed','adam.reed@example.com','inactive',NOW()-INTERVAL 26 DAY),
(64,'Rose Mitchell','rose.mitchell@example.com','active',NOW()-INTERVAL 24 DAY),
(65,'Chris Carter','chris.carter@example.com','active',NOW()-INTERVAL 22 DAY),
(66,'Lara Powell','lara.powell@example.com','active',NOW()-INTERVAL 20 DAY),
(67,'Sean Russell','sean.russell@example.com','active',NOW()-INTERVAL 18 DAY),
(68,'Megan Griffin','megan.griffin@example.com','locked',NOW()-INTERVAL 16 DAY),
(69,'Kyle Butler','kyle.butler@example.com','active',NOW()-INTERVAL 14 DAY),
(70,'Paige Stone','paige.stone@example.com','active',NOW()-INTERVAL 12 DAY),
(71,'Aaron Webb','aaron.webb@example.com','active',NOW()-INTERVAL 11 DAY),
(72,'Emily Fox','emily.fox@example.com','active',NOW()-INTERVAL 10 DAY),
(73,'Josh Dean','josh.dean@example.com','inactive',NOW()-INTERVAL 9 DAY),
(74,'Laura Mills','laura.mills@example.com','active',NOW()-INTERVAL 8 DAY),
(75,'Tom Shaw','tom.shaw@example.com','active',NOW()-INTERVAL 7 DAY),
(76,'Zara Knight','zara.knight@example.com','active',NOW()-INTERVAL 6 DAY),
(77,'Ben Murray','ben.murray@example.com','active',NOW()-INTERVAL 5 DAY),
(78,'Kate Arnold','kate.arnold@example.com','locked',NOW()-INTERVAL 4 DAY),
(79,'Dan Fowler','dan.fowler@example.com','active',NOW()-INTERVAL 3 DAY),
(80,'Lucy Dean','lucy.dean@example.com','active',NOW()-INTERVAL 2 DAY),
(81,'Matt Cole','matt.cole@example.com','active',NOW()-INTERVAL 1 DAY),
(82,'Sarah Cross','sarah.cross@example.com','active',NOW()),
(83,'Will Hardy','will.hardy@example.com','inactive',NOW()),
(84,'Emily Stone','emily.stone@example.com','active',NOW()),
(85,'Jack Newman','jack.newman@example.com','active',NOW()),
(86,'Anna Price','anna.price@example.com','active',NOW()),
(87,'Luke Sharp','luke.sharp@example.com','active',NOW()),
(88,'Nina Watts','nina.watts@example.com','locked',NOW()),
(89,'Ollie Ford','ollie.ford@example.com','active',NOW()),
(90,'Sophie Ray','sophie.ray@example.com','active',NOW()),
(91,'Daniel Scott','daniel.scott@example.com','active',NOW()),
(92,'Grace Adams','grace.adams@example.com','active',NOW()),
(93,'Samuel Baker','samuel.baker@example.com','locked',NOW()),
(94,'Chloe Nelson','chloe.nelson@example.com','active',NOW()),
(95,'Matthew Carter','matthew.carter@example.com','active',NOW()),
(96,'Harry Dunn','harry.dunn@example.com','active',NOW()),
(97,'Olivia Knight','olivia.knight@example.com','active',NOW()),
(98,'Thomas Wells','thomas.wells@example.com','inactive',NOW()),
(99,'Imogen Black','imogen.black@example.com','active',NOW()),
(100,'Nathan Cole','nathan.cole@example.com','active',NOW());

-- =====================
-- USER ACCESS (intentional defects)
-- =====================
INSERT INTO user_access (user_id,application_id,access_level,granted_at) VALUES
(1,1,'read',NOW()-INTERVAL 200 DAY),
(1,2,'write',NOW()-INTERVAL 180 DAY),
(2,4,'admin',NOW()-INTERVAL 170 DAY),
(2,4,'admin',NOW()-INTERVAL 170 DAY), -- duplicate
(3,1,'read',NOW()-INTERVAL 160 DAY),   -- locked user
(4,3,'write',NOW()-INTERVAL 150 DAY),  -- test only
(5,4,'admin',NOW()-INTERVAL 140 DAY),  -- inactive admin
(7,1,'read',NOW()-INTERVAL 130 DAY),
(7,2,'read',NOW()-INTERVAL 130 DAY),
(10,4,'admin',NOW()-INTERVAL 100 DAY),
(10,5,'admin',NOW()-INTERVAL 100 DAY);

-- =====================
-- INCIDENTS (realistic problems)
-- =====================
INSERT INTO incidents (user_id,application_id,severity,status,created_at,resolved_at) VALUES
(1,1,'medium','resolved',NOW()-INTERVAL 10 DAY,NOW()-INTERVAL 9 DAY),
(2,1,'high','resolved',NOW()-INTERVAL 12 DAY,NULL), -- missing resolved_at
(3,1,'high','open',NOW()-INTERVAL 20 DAY,NULL),     -- stale open
(5,2,'medium','open',NOW()-INTERVAL 15 DAY,NULL),   -- inactive user
(4,3,'low','resolved',NOW()-INTERVAL 8 DAY,NOW()-INTERVAL 7 DAY),
(7,1,'medium','open',NOW()-INTERVAL 2 DAY,NULL),
(9,1,'medium','open',NOW()-INTERVAL 3 DAY,NULL);

-- ===============================
-- Intentional Data Problems
-- (Do NOT read during practice)
-- ===============================

-- 1. Active user with no access
DELETE FROM user_access
WHERE user_id = (SELECT user_id FROM users WHERE full_name = 'Sarah Thompson');

-- 2. Locked user still has admin access
INSERT INTO user_access (user_id, application_id, access_level, granted_at)
SELECT u.user_id, a.application_id, 'admin', NOW()
FROM users u
JOIN applications a
WHERE u.status = 'locked'
  AND a.app_name = 'User Management'
LIMIT 1;

-- 3. Duplicate access rows
INSERT INTO user_access (user_id, application_id, access_level, granted_at)
SELECT user_id, application_id, access_level, granted_at
FROM user_access
LIMIT 5;

-- 4. Incident marked resolved but missing resolved_at
UPDATE incidents
SET resolved_at = NULL
WHERE status = 'resolved'
LIMIT 10;

-- 5. Incident linked to inactive user
INSERT INTO incidents (user_id, application_id, severity, status, created_at, resolved_at)
SELECT u.user_id, a.application_id, 'medium', 'open', NOW() - INTERVAL 3 DAY, NULL
FROM users u
JOIN applications a
WHERE u.status = 'inactive'
  AND a.environment = 'prod'
LIMIT 5;
