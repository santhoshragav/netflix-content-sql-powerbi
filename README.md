# Netflix Content Analysis — SQL & Power BI Dashboard

## Overview 
	This project analyzes Netflix's content( movies and TV shows) real data sourced from Kaggle, this project imports raw data into sql server, cleaning and transforming it and building a multipage interactive dashboards.

## Data source
	This project uses data sourced from Kaggle (Netflix Movies and TV shows) which contains 8807 titles with Country, Rating, Cast, Type, date added, release year, duration, genre, and description.

## Tools used
	SSMS - Importing, cleaning and transformations.
	Power BI- Creating data model, Power query transformations, Multiple dashboards and DAX measures.

## Data Cleaning & Preparation
	-Converted 'date_added' into proper data format as 'date_added_clean'.
	-Split the mixed 'duration' field 'duration minutes' for Movies and 'duration seasons' for TV shows.
	- Replaced missing values in `director`, `cast`, and `country` with "Unknown" to preserve row completeness.
	-Identified 3 rows with column shift data error and corrected it (duration values misplaced in the `rating` field), relabeling them as "Not Rated".
	-Split multi-value fields such as genre, country into individual rows by delimiting in power query editor.
	- Verified data integrity post-transformation by comparing unique title counts between the source SQL table and the transformed Power BI model, identifying and correcting an aggregation bug (Count vs. Count Distinct) caused by the row-splitting process.

## Dashboard structure
	-Overview- contains the Core statistics (total titles, movies, TV shows and country-wise breakdown).
	-Genre Breakdown — top genres by title count, split by content type.
	-Trends Over Time— content added to the platform by year, and original release year distribution.
	-Deep Dive — a searchable, filterable table of individual titles with country and rating slicers.
	-Runtime Analysis — total content runtime (minutes) by genre and by country.

## Key Business Insights
	-Netflix content has an exponential growth between 2016-2019 and there's a slight dip after 2019.
	-International movies, Dramas and Comedies are the top genre by title count.
	-United States and India together has the largest share of runtime, though United states leads in the title count in a wide margin.
	-TV-MA and TV-14 lead the ratings list, reflecting strong consumption among mature and teenage audiences.
	-Most content on the platform was originally released between 2015 and 2020, indicating a preference for relatively recent titles.

## Limitations
	- The dataset does not include actual viewership or watch-time data — all "duration" figures represent content runtime, not audience engagement.
	- A small number of rows (~5, under 0.1% of the dataset) show minor discrepancies between the source SQL table and the transformed Power BI model, due to edge-case text formatting in the `country` field during row-splitting. This does not materially affect the analysis or insights presented.

## Conclusion
	-This project demonstrates the complete data analytics workflow from Importing data from csv, SQL based cleaning and transforming to building interactive multipage dashboards. It reflects practical skills in handling one to many text fields(genre, country) , DAX measures and data validation- catching and correcting the aggregation bugs during development,rather than presenting numbers without verification.




	
