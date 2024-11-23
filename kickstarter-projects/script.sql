-- Create a table in the database that matches the columns of the csv file
CREATE TABLE ksprojects (
    ID SERIAL PRIMARY KEY,
    name TEXT,
    category TEXT,
    main_category TEXT,
    goal NUMERIC,
    pledged NUMERIC,
    state TEXT,
    backers INT
);

-- Import the data from the csv file 
COPY ksprojects (ID, name, category, main_category, goal, pledged, state, backers)
FROM '/Users/macpro/Documents/Git-Repos/data-analysis-with-sql/kickstarter-projects/ks-projects.csv'
DELIMITER ','
CSV HEADER;

-- Return first 5 rows, including all the columns from the ksprojects table
SELECT * FROM ksprojects LIMIT 5;