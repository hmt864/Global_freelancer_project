CREATE TABLE freelancers_staging AS (SELECT * FROM freelancers);

SELECT * FROM freelancers_staging;

SELECT DISTINCT gender
FROM freelancers_staging;

--Standardize the gender with F for female and M for male
SELECT gender, UPPER(LEFT(gender, 1))
FROM freelancers_staging;

UPDATE freelancers_staging
SET gender = UPPER(LEFT(gender, 1));


SELECT DISTINCT country
FROM freelancers_staging;

SELECT country, TRIM(country)
FROM freelancers_staging;
--Remove possible leading or trailing space in country
UPDATE freelancers_staging
SET country = TRIM(country);

SELECT DISTINCT "language"
FROM freelancers_staging
ORDER BY language;

UPDATE freelancers_staging
SET "language" = TRIM("language");


SELECT DISTINCT primary_skill
FROM freelancers_staging
ORDER BY primary_skill;

UPDATE freelancers_staging
SET primary_skill = TRIM(primary_skill);


SELECT DISTINCT hourly_rate_usd
FROM freelancers_staging
ORDER BY hourly_rate_usd;

--Standardize the hourly_rate_usd with numeric number
SELECT hourly_rate_usd, CAST(LTRIM(hourly_rate_usd, '$USD') AS NUMERIC)
FROM freelancers_staging
ORDER BY 1;

UPDATE freelancers_staging
SET hourly_rate_usd = LTRIM(hourly_rate_usd, '$USD';

ALTER TABLE freelancers_staging
ALTER COLUMN hourly_rate_usd TYPE NUMERIC
USING hourly_rate_usd::numeric;
							
							
SELECT DISTINCT is_active
FROM freelancers_staging;
--Standardize is_active in 'Y' and 'N'
SELECT is_active,
	CASE 
		WHEN LOWER(is_active) IN ('y', 'true', '1', 'yes') THEN 'Y'
		WHEN LOWER(is_active) IN ('n', 'false', '0', 'no') THEN 'N'
		ELSE NULL
	END AS is_active_clean
FROM freelancers_staging;
							
UPDATE freelancers_staging
SET is_active = CASE 
		WHEN LOWER(is_active) IN ('y', 'true', '1', 'yes') THEN 'Y'
		WHEN LOWER(is_active) IN ('n', 'false', '0', 'no') THEN 'N'
		ELSE NULL
	END;

SELECT DISTINCT client_satisfaction
FROM freelancers_staging;
							
SELECT client_satisfaction, 
	ROUND(CAST(RTRIM(client_satisfaction, '%') AS NUMERIC)/ 100.0, 2)
FROM freelancers_staging;
							
UPDATE freelancers_staging
SET client_satisfaction = ROUND(CAST(RTRIM(client_satisfaction, '%') AS NUMERIC)/ 100.0, 2);

ALTER TABlE freelancers_staging
ALTER COLUMN client_satisfaction TYPE NUMERIC
USING client_satisfaction::NUMERIC;

UPDATE freelancers_staging
SET name = TRIM(name);

SELECT * FROM freelancers_staging;

-- Check potential duplicate records
WITH duplicate_cte AS (
	SELECT name, gender, age, country, language, primary_skill, years_of_experience, hourly_rate_usd, rating, is_active, client_satisfaction,
	ROW_NUMBER()OVER(
		PARTITION BY name, gender, age, country, language
	) AS row_num
	FROM freelancers_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;


SELECT * 
FROM freelancers_staging
WHERE name IS NULL 
	OR gender IS NULL
	OR age IS NULL 
	OR country IS NULL 
	OR language IS NULL 
	OR primary_skill IS NULL
	OR years_of_experience IS NULL
	OR hourly_rate_usd IS NULL
	OR rating IS NULL
	OR is_active IS NULL 
	OR client_satisfaction IS NULL

--Understand the amount of NULL values for each column
SELECT COUNT(*) AS c_all, 
	COUNT(name) AS c_name, 
	COUNT(gender) AS c_gender, 
	COUNT(age) AS c_age, 
	COUNT(country) AS c_country, 
	COUNT(language) AS c_language, 
	COUNT(primary_skill) AS c_primaary_skill, 
	COUNT(years_of_experience) AS c_years_of_experience, 
	COUNT(hourly_rate_usd) AS c_hourly_rate_usd, 
	COUNT(rating) AS c_rating, 
	COUNT(is_active) AS c_is_active, 
	COUNT(client_satisfaction) AS c_client_satisfaction
FROM freelancers_staging;

--Copy the table for median imputation and potential remove operations.
CREATE TABLE freelancers_staging2 AS (SELECT * FROM freelancers_staging);
SELECT * FROM freelancers_staging2;


WITH Median_values AS (
	SELECT 
	PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY age) AS MedianDisc_age, 
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY years_of_experience) AS MedianCont_years_of_experience,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY hourly_rate_usd) AS MedianCont_hourly_rate_usd,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY rating) AS MedianCont_rating
	FROM freelancers_staging2
)
UPDATE freelancers_staging2
SET 
    age = COALESCE(freelancers_staging2.age, Median_values.MedianDisc_age),
    years_of_experience = COALESCE(freelancers_staging2.years_of_experience, Median_values.MedianCont_years_of_experience),
    hourly_rate_usd = COALESCE(freelancers_staging2.hourly_rate_usd, Median_values.MedianCont_hourly_rate_usd),
    rating = COALESCE(freelancers_staging2.rating, Median_values.MedianCont_rating)
FROM Median_values;
SELECT * FROM freelancers_staging2;


