-- Selects the total number of reports in the database
USE Crime_db;

-- Total Reports in the Database
SELECT COUNT(report_id) AS total_reports 
FROM processed_bi;

-- Total Reports Grouped by Crime Category
SELECT crime_category, COUNT(report_id) AS total_reports
FROM processed_bi
GROUP BY crime_category
ORDER BY total_reports DESC;

-- Total Reports Grouped by Victim's Gender
SELECT victim_sex, COUNT(report_id) AS total_reports
FROM processed_bi
GROUP BY victim_sex
ORDER BY total_reports DESC;

-- Total Reports by Crime Severity with Percentage
WITH TotalCounts AS (
    SELECT COUNT(report_id) AS total_count FROM processed_bi
)
SELECT 
    part_1_2_crime_severity, 
    COUNT(report_id) AS total_reports,
    CAST(ROUND((COUNT(report_id) * 100.0) / total_count, 2) AS DECIMAL(5,2)) AS percentage
FROM processed_bi, TotalCounts
GROUP BY part_1_2_crime_severity, total_count
ORDER BY total_reports DESC;

-- Total Reports Grouped by Holiday
SELECT holiday, COUNT(report_id) AS total_reports 
FROM processed_bi
GROUP BY holiday
ORDER BY total_reports;

-- Average Age of Victims
SELECT AVG(victim_age) AS average_victim_age 
FROM processed_bi;

-- Top 5 Areas with the Most Crime Reports
SELECT TOP 5 area_name, COUNT(report_id) AS total_reports 
FROM processed_bi
GROUP BY area_name
ORDER BY total_reports DESC;

-- Bottom 5 Areas with the Least Crime Reports
SELECT TOP 5 area_name, COUNT(report_id) AS total_reports 
FROM processed_bi
GROUP BY area_name
ORDER BY total_reports ASC;

-- Total Crime Reports Grouped by Case Status
SELECT case_status_description, COUNT(report_id) AS total_reports
FROM processed_bi
GROUP BY case_status_description
ORDER BY total_reports DESC;

-- Crime Reports Grouped by Victim's Descent (Excluding 'Unknown')
SELECT victim_descent, COUNT(report_id) AS total_reports
FROM processed_bi
WHERE victim_descent NOT IN ('unknown')
GROUP BY victim_descent
ORDER BY total_reports DESC;

-- Total Crime Reports Grouped by Year of Occurrence
SELECT YEAR(date_of_occurrence) AS year, COUNT(report_id) AS total_reports 
FROM processed_bi
GROUP BY YEAR(date_of_occurrence)
ORDER BY year ASC;

-- Total Crime Reports Grouped by Month of Occurrence
SELECT MONTH(date_of_occurrence) AS month, COUNT(report_id) AS total_reports 
FROM processed_bi
GROUP BY MONTH(date_of_occurrence)
ORDER BY month ASC;

-- Crime Reports Grouped by Weekday of Occurrence
SELECT DATENAME(WEEKDAY, date_of_occurrence) AS weekday, 
       COUNT(report_id) AS total_reports
FROM processed_bi
GROUP BY DATENAME(WEEKDAY, date_of_occurrence)
ORDER BY total_reports DESC;

-- Crime Reports Grouped by Category and Weekday
SELECT crime_category, 
       DATENAME(WEEKDAY, date_of_occurrence) AS weekday, 
       COUNT(report_id) AS total_reports
FROM processed_bi
GROUP BY crime_category, DATENAME(WEEKDAY, date_of_occurrence)
ORDER BY crime_category, total_reports DESC;

-- Identifies Peak Crime Hours for Each Category
WITH HourlyReports AS (
    SELECT crime_category, 
           DATEPART(HOUR, time_of_occurrence) AS report_hour, 
           COUNT(report_id) AS total_reports,
           ROW_NUMBER() OVER (PARTITION BY crime_category ORDER BY COUNT(report_id) DESC) AS rn
    FROM processed_bi
    GROUP BY crime_category, DATEPART(HOUR, time_of_occurrence)
)
SELECT crime_category, report_hour, total_reports
FROM HourlyReports
WHERE rn = 1
ORDER BY total_reports DESC;

-- Average Days Before Crime Reported (By Category)
SELECT 
    crime_category, 
    AVG(DATEDIFF(DAY, date_of_occurrence, date_reported)) AS avg_days_before_reported
FROM processed_bi
WHERE date_reported IS NOT NULL AND date_of_occurrence IS NOT NULL
GROUP BY crime_category
ORDER BY avg_days_before_reported DESC;

-- Year and Month-wise Report Count
SELECT 
    YEAR(date_of_occurrence) AS year, 
    MONTH(date_of_occurrence) AS month,
    COUNT(report_id) AS total_reports
FROM processed_bi
GROUP BY YEAR(date_of_occurrence), MONTH(date_of_occurrence)
ORDER BY year ASC, month ASC;

-- Identifying Most Common Crime Category by Area
WITH CrimeRank AS (
    SELECT area_name, 
           crime_category, 
           COUNT(report_id) AS total_reports,
           ROW_NUMBER() OVER (PARTITION BY area_name ORDER BY COUNT(report_id) DESC) AS rank
    FROM processed_bi
    GROUP BY area_name, crime_category
)
SELECT area_name, 
       crime_category AS most_common_crime_category, 
       total_reports
FROM CrimeRank
WHERE rank = 1
ORDER BY area_name;

-- Crime Reports of Sexual Crimes Grouped by Victim's Gender
SELECT victim_sex, 
       crime_category, 
       COUNT(report_id) AS total_reports
FROM processed_bi
WHERE crime_category = 'Sexual Crime'  -- Filter for sexual crimes only
  AND victim_sex != 'unknown'  
GROUP BY victim_sex, crime_category
ORDER BY victim_sex, total_reports DESC;

-- Crime Severity Distribution by Hour of Occurrence
SELECT DATEPART(HOUR, time_of_occurrence) AS hour_of_day,
       part_1_2_crime_severity,
       COUNT(report_id) AS total_reports
FROM processed_bi
GROUP BY DATEPART(HOUR, time_of_occurrence), part_1_2_crime_severity
ORDER BY hour_of_day, total_reports DESC;
