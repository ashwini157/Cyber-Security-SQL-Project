CREATE DATABASE Cybersecurity_DB;
USE Cybersecurity_DB;
#drop database Cybersecurity_DB;
select * from global_cybersecurity_threft;
#PROJECT 
-- 1. Group By :
# (i) Country And Total_loss :
SELECT country, SUM(financial_loss) AS total_loss
FROM global_cybersecurity_threft
GROUP BY country
ORDER BY total_loss DESC
LIMIT 5;
# (ii) Target_industry Group By total_attack
SELECT Target_industry, COUNT(*) AS total_attacks
FROM global_cybersecurity_threft
GROUP BY Target_industry
ORDER BY Total_attacks DESC;

# (iii) Attack_Source
SELECT attack_source, COUNT(*) AS total_attacks
FROM global_cybersecurity_threft
GROUP BY attack_source
ORDER BY total_attacks DESC;


-- 2.WHERE AND HAVING :
# (i) Attack_Type and Total_attack 
SELECT attack_type, COUNT(*) AS total_attacks
FROM global_cybersecurity_threft
WHERE year >= 2021
GROUP BY attack_type
HAVING COUNT(*) >200;

# (ii) Year and NO. Of Affacted users
SELECT *
FROM global_cybersecurity_threft
WHERE year = 2020  AND number_of_affected_users > 50000;

# (iii) Incient_Resoluction_Time and Target_Industry :
SELECT *
FROM global_cybersecurity_threft
WHERE target_industry IN ('Telecommunications', 'IT')
  AND incident_resolution_time > 24;

#3. CASE 
SELECT attack_type, financial_loss,
CASE
    WHEN financial_loss >= 100 THEN 'Critical'
    WHEN financial_loss >= 50 THEN 'High'
    WHEN financial_loss >= 20 THEN 'Medium'
    WHEN financial_loss >= 10 THEN 'Lower'
    ELSE 'Little'
  END AS severity_level
FROM global_cybersecurity_threft;

-- 4. Join

-- Create industry_info table
CREATE TABLE Industry_Info (
  industry_name VARCHAR(100) PRIMARY KEY,
  is_critical_sector BOOLEAN
);


INSERT INTO Industry_Info VALUES
('Banking', TRUE),
('Healthcare', TRUE),
('Retail', FALSE);


SELECT gct.country, gct.attack_type, ii.is_critical_sector
FROM global_cybersecurity_threft as gct
JOIN Industry_Info as ii
  ON gct.target_industry = ii.industry_name;

# (i) Attack_Source:
CREATE TABLE attack_source_info (
  attack_source VARCHAR(100) PRIMARY KEY,
  source_category VARCHAR(50),    -- e.g. ‘External’, ‘Internal’
  description    VARCHAR(500)
);
INSERT INTO attack_source_info (attack_source, source_category, description) VALUES
('Insider',      'Internal', 'Employees or contractors misusing access'),
('Nation-state', 'External','Government-sponsored actors'),
('Hacktivist',   'External','Ideologically-motivated individuals/groups'),
('Criminal',     'External','Organized crime or financially motivated'),
('Script Kiddie','External','Unskilled attackers using off-the-shelf tools');

SELECT gct.year, gct.country, gct.attack_type, gct.attack_source,
  asi.source_category, asi.description
FROM global_cybersecurity_threft AS gct
JOIN attack_source_info AS asi
  ON gct.attack_source = asi.attack_source;
# Incident Resoluction Time  and no. of affected users
CREATE TABLE resolution_time_category (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(50),
  min_time INT,
  max_time INT
);
INSERT INTO resolution_time_category VALUES
(1, 'Fast', 0, 24),
(2, 'Moderate', 25, 72),
(3, 'Slow', 73, 100);
CREATE TABLE user_impact_category (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(50),
  min_users INT,
  max_users INT
);
INSERT INTO user_impact_category VALUES
(1, 'Low Impact', 0, 999),
(2, 'Medium Impact', 1000, 9999),
(3, 'High Impact', 10000, 1000000);
SELECT gct.attack_type, gct.number_of_affected_users,
uic.category_name AS impact_level, gct.incident_resolution_time,
  rtc.category_name AS resolution_speed
FROM global_cybersecurity_threft AS gct
INNER JOIN user_impact_category AS uic 
ON gct.number_of_affected_users BETWEEN uic.min_users AND uic.max_users
INNER JOIN resolution_time_category AS rtc
  ON gct.incident_resolution_time BETWEEN rtc.min_time AND rtc.max_time;

-- 5. Subquery
# (i) Country and Financial loss
SELECT *
FROM global_cybersecurity_threft as gct
WHERE (SELECT COUNT(*)
  FROM global_cybersecurity_threft
  WHERE country = gct.country AND financial_loss > gct.financial_loss
) < 50;

# (ii) target_industry and total_attack 
SELECT target_industry, COUNT(*) AS total_attacks
FROM global_cybersecurity_threft
GROUP BY target_industry
HAVING total_attacks > (SELECT AVG(industry_attack_count)
FROM (SELECT COUNT(*) AS industry_attack_count
FROM global_cybersecurity_threft
GROUP BY target_industry) AS temp);

# (iii) Security_Vulnerability_Type and total cases
SELECT Security_Vulnerability_Type, total_cases
FROM (SELECT Security_Vulnerability_Type, COUNT(*) AS total_cases
  FROM global_cybersecurity_threft
  GROUP BY Security_Vulnerability_Type
) AS v_summary
WHERE total_cases > 5;
 
-- 6.window functions:
# (i) Country,Financial loss with rank
SELECT country, attack_type, financial_loss,
  RANK() OVER (PARTITION BY country ORDER BY financial_loss DESC) AS Top_rank
FROM global_cybersecurity_threft;

# (ii) Country and Total rank
SELECT country, COUNT(*) AS total_attacks,
  DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS country_dense_rank
FROM global_cybersecurity_threft
GROUP BY country;

# (iii) Defense mechanism used total time
SELECT defense_mechanism_used, SUM(incident_resolution_time) AS total_time,
  RANK() OVER (ORDER BY SUM(incident_resolution_time) ASC) AS resolution_rank
FROM global_cybersecurity_threft
GROUP BY defense_mechanism_used;

select * from global_cybersecurity_threft;
 