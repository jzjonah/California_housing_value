-- create table of the averages of the whole dataset
CREATE TABLE testingproject-398915.California_Housing.dataset_averages as
SELECT 
  avg(Median_House_Value) as avg_housing_value,
  avg(Median_Income)*10000 as avg_income,
  avg(Distance_to_coast) as avg_distance_to_coast,
  avg(Distance_to_LA) as avg_distance_to_LA,
  avg(Distance_to_SanDiego) as avg_distance_to_SanDiego,
  avg(Distance_to_SanJose) as avg_distance_to_SanJose,
  avg(Distance_to_SanFrancisco) as avg_distance_to_SanFrancisco
 FROM `testingproject-398915.California_Housing.California_Hosuing_Cities` 

 --Get a list of cities that have an above average house value
 CREATE TABLE testingproject-398915.California_Housing.above_average_house_value as
SELECT  
  City,
  avg(Median_House_Value) as avg_house_value
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
where Median_House_Value >206855
group by
City
order by
  avg_house_value desc

--Get a list of cities that have an above average income
CREATE TABLE testingproject-398915.California_Housing.above_average_income as
SELECT  
  City,
  avg(Median_Income)*10000 as avg_income
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
HAVING avg(Median_Income)*10000 >38706
order by
  avg_income desc
--Get a list of the cities that have a below average distance to the coast
CREATE TABLE testingproject-398915.California_Housing.bellow_average_distance_to_coast as
SELECT  
  City,
  avg(Rounded_Distance_To_Coast) as avg_distance_to_coast
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
HAVING avg(Rounded_Distance_To_Coast) < 40509
order by
  avg_distance_to_coast asc


--Get a list of the cities that all were above average income, above average housing value and below average distance to coast
CREATE TABLE testingproject-398915.California_Housing.afluent_cities_near_coast as
SELECT  
  *
FROM(
  SELECT
  below_distance.City
  FROM `testingproject-398915.California_Housing.above_average_house_value` as above_value
  INNER JOIN `testingproject-398915.California_Housing.above_average_income` as above_income
  ON above_income.City = above_value.City
  INNER JOIN `testingproject-398915.California_Housing.bellow_average_distance_to_coast` as below_distance
  ON below_distance.City = above_value.City
) 


--create a table with the 25 cities the fearthest from San Francisco
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.fearthest_from_SanFrancisco as
SELECT  
  City,
  avg(Rounded_Distance_To_SanFrancisco) as avg_distance_to_SanFrancisco
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
order by
  avg_distance_to_SanFrancisco desc
LIMIT 25

--create a table with the 25 cities the fearthest from San Jose
CREATE TABLE testingproject-398915.California_Housing.fearthest_from_SanJose as
SELECT  
  City,
  avg(Rounded_Distance_To_Sanjose) as avg_distance_to_SanJose
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
order by
  avg_distance_to_SanJose desc
LIMIT 25

--create a table with the 25 cities the fearthest from San Diego
CREATE TABLE testingproject-398915.California_Housing.fearthest_from_SanDiego as
SELECT  
  City,
  avg(Rounded_Distance_To_SanDiego) as avg_distance_to_SanDiego
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
order by
  avg_distance_to_SanDiego desc
LIMIT 25

--create a table with the 25 cities the fearthest from LA
CREATE TABLE testingproject-398915.California_Housing.fearthest_from_LA as
SELECT  
  City,
  avg(Rounded_Distance_To_LA) as avg_distance_to_LA
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
order by
  avg_distance_to_LA desc
LIMIT 25


-- a grouping of all the cities that are the fearthest from one of the major cities
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.fearthest_from_Major_cities as
SELECT  
  *
FROM(
  SELECT
  DISTINCT COALESCE(LA.City, SanDiego.City, SanFrancisco.City, SanJose.City) AS City,
  avg_distance_to_LA,
  avg_distance_to_SanDiego
  avg_distance_to_SanFrancisco,
  avg_distance_to_SanJose,
  FROM `testingproject-398915.California_Housing.fearthest_from_LA` as LA
  FULL OUTER JOIN `testingproject-398915.California_Housing.fearthest_from_SanDiego` as SanDiego
  ON LA.City = SanDiego.City
  FULL OUTER JOIN `testingproject-398915.California_Housing.fearthest_from_SanFrancisco` as SanFrancisco
  ON LA.City = SanFrancisco.City
  FULL OUTER JOIN `testingproject-398915.California_Housing.fearthest_from_SanJose` as SanJose
  ON LA.City = SanJose.City
) 

--Above call resulted in some parts where the avgerage distance datapoints were not grouped together. The bottom call properly groups all the data for the cities
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.fearthest_from_Major_cities as
SELECT  
  City,
  AVG(avg_distance_to_LA) AS avg_distance_to_LA,
  AVG(avg_distance_to_SanDiego) AS avg_distance_to_SanDiego,
  AVG(avg_distance_to_SanFrancisco) AS avg_distance_to_SanFrancisco,
  AVG(avg_distance_to_SanJose) AS avg_distance_to_SanJose
FROM `testingproject-398915.California_Housing.fearthest_from_Major_cities`
GROUP BY
City
--the data was filtered to find the cities that were above average distance away from each major city and then in call below they lists were joined to only hold the cities that 
--was above average distance away from all major cities.
-- a grouping of all the cities that are the fearthest from one of the major cities
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.cities_above_average_distance_from_all_cities as
SELECT  
  *
FROM(
  SELECT
  DISTINCT COALESCE(LA.City, SanDiego.City, SanFrancisco.City, SanJose.City) AS City,
  avg_distance_to_LA,
  avg_distance_to_SanDiego
  avg_distance_to_SanFrancisco,
  avg_distance_to_SanJose,
  FROM `testingproject-398915.California_Housing.fearthest_from_LA` as LA
  INNER JOIN `testingproject-398915.California_Housing.fearthest_from_SanDiego` as SanDiego
  ON LA.City = SanDiego.City
  INNER JOIN `testingproject-398915.California_Housing.fearthest_from_SanFrancisco` as SanFrancisco
  ON LA.City = SanFrancisco.City
  INNER JOIN `testingproject-398915.California_Housing.fearthest_from_SanJose` as SanJose
  ON LA.City = SanJose.City
) 
--This proccess will be repeated to find the info on the closest cities to major cities. From there the other data in the dataset will be used to compared 
--to see any trends.
--The repeated calls are as fallows
--while looking for cities that are close to major cities i filtered for the top four because when they are grouped together I will not only be looking for cities that 
-- are listed in all lists and instead will be using the comnbination of all of them. This helps the number of datapoints for both datasets be close in size.

--create a table with the 15 cities the closest to San Francisco
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.closest_to_SanFrancisco as
SELECT
  City,
  avg(Rounded_Distance_To_SanFrancisco) as avg_distance_to_SanFrancisco
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
order by
  avg_distance_to_SanFrancisco 
LIMIT 4

--create a table with the 15 cities the closest to San Jose
CREATE TABLE testingproject-398915.California_Housing.closest_to_SanJose as
SELECT  
  City,
  avg(Rounded_Distance_To_Sanjose) as avg_distance_to_SanJose
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
order by
  avg_distance_to_SanJose 
LIMIT 4

--create a table with the 15 cities the closest to San Diego
CREATE TABLE testingproject-398915.California_Housing.closest_to_SanDiego as
SELECT  
  City,
  avg(Rounded_Distance_To_SanDiego) as avg_distance_to_SanDiego
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
order by
  avg_distance_to_SanDiego 
LIMIT 4

--create a table with the 15 cities the closest to LA
CREATE TABLE testingproject-398915.California_Housing.closest_to_LA as
SELECT  
  City,
  avg(Rounded_Distance_To_LA) as avg_distance_to_LA
FROM `testingproject-398915.California_Housing.California_Hosuing_Cities`
group by
City
order by
  avg_distance_to_LA 
LIMIT 4


--grouping the tables together
-- a grouping of all the cities that are the fearthest from one of the major cities
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.closest_to_Major_cities as
SELECT  
  *
FROM(
  SELECT
  DISTINCT COALESCE(LA.City, SanDiego.City, SanFrancisco.City, SanJose.City) AS City,
  avg_distance_to_LA,
  avg_distance_to_SanDiego,
  avg_distance_to_SanFrancisco,
  avg_distance_to_SanJose,
  FROM `testingproject-398915.California_Housing.closest_to_LA` as LA
  FULL OUTER JOIN `testingproject-398915.California_Housing.closest_to_SanDiego` as SanDiego
  ON LA.City = SanDiego.City
  FULL OUTER JOIN `testingproject-398915.California_Housing.closest_to_SanFrancisco` as SanFrancisco
  ON LA.City = SanFrancisco.City
  FULL OUTER JOIN `testingproject-398915.California_Housing.closest_to_SanJose` as SanJose
  ON LA.City = SanJose.City
) 

CREATE OR REPLACE TABLE testingproject-398915.California_Housing.closest_to_Major_cities as
SELECT  
  City,
  AVG(avg_distance_to_LA) AS avg_distance_to_LA,
  AVG(avg_distance_to_SanDiego) AS avg_distance_to_SanDiego,
  AVG(avg_distance_to_SanFrancisco) AS avg_distance_to_SanFrancisco,
  AVG(avg_distance_to_SanJose) AS avg_distance_to_SanJose
FROM `testingproject-398915.California_Housing.closest_to_Major_cities`
GROUP BY
City

--below is combining the avg_distance columns into one. this process was needed to be done this way as some cities made the list for closest cities for multiple cites
--therefore at some points the values needed to be averaged
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.closest_to_Major_cities as
  SELECT 
    City,
    (
    COALESCE(avg_distance_to_LA, 0) + 
    COALESCE(avg_distance_to_SanFrancisco, 0) + 
    COALESCE(avg_distance_to_SanDiego, 0) + 
    COALESCE(avg_distance_to_SanJose, 0)
) / (
    CASE 
        WHEN avg_distance_to_LA IS NOT NULL THEN 1 
        ELSE 0 
    END +
    CASE 
        WHEN avg_distance_to_SanFrancisco IS NOT NULL THEN 1 
        ELSE 0 
    END +
    CASE 
        WHEN avg_distance_to_SanDiego IS NOT NULL THEN 1 
        ELSE 0 
    END +
    CASE 
        WHEN avg_distance_to_SanJose IS NOT NULL THEN 1 
        ELSE 0 
    END
) AS average_result
FROM `testingproject-398915.California_Housing.closest_to_Major_cities`
--After this is done I now have a list of cities that are far from all major cities as well as a list of cities that are close to a major city. these will now be used to 
--see if any diffences can be found within the housing market for these two groupings of types of cities.

--adding city data averages this was done for the cities close to major cities as well
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.cities_above_average_distance_from_all_cities as
SELECT
  Closest.City,
  cities.avg_housing_value,
  cities.avg_income,
  cities.avg_distance_to_coast,
  cities.avg_distance_to_LA,
  cities.avg_distance_to_SanDiego,
  cities.avg_distance_to_SanJose,
  cities.avg_distance_to_SanFrancisco
 FROM `testingproject-398915.California_Housing.dataset_City_averages` as cities
 INNER JOIN  `testingproject-398915.California_Housing.cities_above_average_distance_from_all_cities` as closest
 ON closest.City = cities.City


--add column to each table saying whether they are clsoe to a city or not (done for both)
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.closest_to_Major_cities as
SELECT
  *,
  TRUE as close_to_city
 FROM `testingproject-398915.California_Housing.closest_to_Major_cities` as closest
