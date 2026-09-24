-- ================================================================
-- Netflix content analysis — Full SQL Pipeline
-- Full SQL Pipeline: Import -> Clean -> Transform -> Analysis
-- ================================================================


-- ================================================================
-- SECTION 1: Database & Staging Table Setup
-- ================================================================
CREATE DATABASE NetflixData;

-- From dropdown select the netflix database
-- Raw staging table (populated via SSMS Import Wizard
-- from the netflix_titles CSV, sourced from Kaggle)
CREATE TABLE netflix_titles (
    show_id VARCHAR(10),
    type VARCHAR(20),
    title NVARCHAR(300),
    director NVARCHAR(300),
    cast_members NVARCHAR(1000),
    country NVARCHAR(300),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(20),
    listed_in NVARCHAR(300),
    description NVARCHAR(1000)
);
-- Data loaded via Workbench Table Data Import Wizard.

 
-- ================================================================
-- SECTION 2: Data Cleaning & Preparation
-- ================================================================
-- Validate imported data
select * from netflix_titles;
select top 10 * from netflix_titles;
select count(*) from netflix_titles;


-- creating and updating the cleaned date in a required data format
select date_added, TRY_CONVERT(date,LTRIM(rtrim (date_added)),107) as converted_date
from netflix_titles;

alter table netflix_titles add date_added_clean date;
update netflix_titles set date_added_clean=TRY_CONVERT(date,LTRIM(rtrim (date_added)),107);


-- Check failed conversions
select count(*) as rowss , 
SUM(case
when date_added is not null and date_added_clean is null then 1 else 0
end)as failed_conversions
from netflix_titles;

--Fixing the duration field by creating duration_minutes,duration_seasons and updating it according to its type
alter table netflix_titles add duration_minutes int;
alter table netflix_titles add duration_seasons int;

update netflix_titles set duration_minutes = case
when 
type ='Movie' then TRY_CAST(replace (duration,'min','') as int)
else null
end;

UPDATE netflix_titles
SET duration_season = 
    CASE 
     WHEN type = 'TV Show' 
     THEN TRY_CAST(REPLACE(REPLACE(duration, ' Seasons', ''), ' Season', '') AS INT)
      ELSE NULL
    END;


-- Identifying and fixing the mismatched fields
SELECT show_id, title, type, rating, duration 
FROM netflix_titles 
WHERE rating LIKE '%min%' OR rating LIKE '%Season%';

update netflix_titles set duration = rating, rating = 'unknown'
where show_id in ('s5542','s5795','s5814');

update netflix_titles set duration_minutes = TRY_CAST(replace(duration,'min','')as int)
where show_id in ('s5542','s5795','s5814');

SELECT COUNT(DISTINCT show_id) FROM netflix_titles;


-- Handling NULL values in key fields
select count(*) from  netflix_titles 
where director is null;

select count(*) from  netflix_titles 
where [cast] is null;

select count(*) from  netflix_titles 
where country is null;

update netflix_titles set director= COALESCE(director,'unknown');
update netflix_titles set [cast] = COALESCE([cast],'unknown') ;
update netflix_titles set country =  COALESCE(country,'unknown'); 


-- Checking the cause of the mismatch between SQL and Power BI(edge-case text formatting)
SELECT show_id, title, country 
FROM netflix_titles 
WHERE country = ',' OR country LIKE '%,,%' OR LEN(TRIM(country)) = 0;


