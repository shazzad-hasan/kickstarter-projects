-- Pull the relevant columns from the ksprojects table that will allow us to assess a project's result 
-- based on its main category, amount of money set as a goal, number of backers, and amount of money pledged. 
-- Return just the first 10 rows.

SELECT main_category, goal, backers, pledged
 FROM ksprojects
LIMIT 10; 

-- Expand your query to keep the records where the project state is either 
-- 'failed', 'canceled', or 'suspended'.
SELECT main_category, goal, backers, pledged
 FROM ksprojects
 WHERE state IN ('failed', 'canceled', or 'suspended')
LIMIT 10; 

-- Expand your query to find which of these projects had at least 100 backers and at least $20,000 pledged
SELECT main_category, backers, pledged, goal
FROM ksprojects
WHERE state IN ('failed', 'canceled', 'suspended') 
  AND backers >= 100 
  AND pledged >= 20000
LIMIT 10;

-- Sort the results by the following 2 fields:
-- 1. Main category sorted in ascending order
-- 2. A calculated field called pct_pledged, which divides pledged by goal. Sort this field in descending order. 
-- (Add pct_pledged to the SELECT clause, too.)
-- Modify your query so that only projects in a failed state are returned.
SELECT main_category, backers, pledged, goal, pledged/goal AS pct_pledged
FROM ksprojects
 WHERE state IN ('failed')
   AND backers >= 100 
   AND pledged >= 20000
 ORDER BY main_category ASC, pct_pledged DESC
 LIMIT 10;

-- Create a field funding_status that applies the following logic based on the percentage of amount pledged to campaign goal:
-- If the percentage pledged is greater than or equal to 1, then the project is "Fully funded".
-- If the percentage pledged is between 75% and 100%, then the project is "Nearly funded".
-- If the percentage pledged is less than 75%, then the project is "Not nearly funded".
SELECT main_category, backers, pledged, goal,
       pledged / goal AS pct_pledged,
       CASE
         WHEN pledged / goal >= 1 THEN 'Fully funded'
         WHEN pledged / goal > 0.75 AND pledged / goal < 1 THEN 'Nearly funded'
         WHEN pledged / goal <= 0.75 THEN 'Not nearly funded'
       END AS funding_status
FROM ksprojects
WHERE state IN ('failed')
  AND backers >= 100 
  AND pledged >= 20000
  AND goal > 0
ORDER BY main_category, pct_pledged DESC
LIMIT 10;

-- Save the cleaned dataset
COPY ksprojects TO '/Users/macpro/Documents/Data Analytics/Data Analysis with SQL/analyzing-kickstarter-projects/ksprojects_cleaned.csv' CSV HEADER;

