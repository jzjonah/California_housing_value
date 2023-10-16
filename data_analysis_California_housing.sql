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
