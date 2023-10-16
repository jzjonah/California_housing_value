--adding a average rooms in a house column
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.California_Hosuing_Cities as
SELECT *,
Round(Tot_rooms/households,2) As average_rooms
From `testingproject-398915.California_Housing.California_Hosuing_Cities` 

--Adding a average bedrooms in a house column
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.California_Hosuing_Cities as
SELECT *,
Round(Tot_Bedrooms/households,2) As average_bedrooms
From `testingproject-398915.California_Housing.California_Hosuing_Cities` 

--sorting the dataset from median house value largest to smallest
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.California_Hosuing_Cities as
SELECT *,
From `testingproject-398915.California_Housing.California_Hosuing_Cities`
ORDER BY
  Median_House_Value desc

--adding in collumns that are the distances to the stated places rounded to the nearest 10km
CREATE OR REPLACE TABLE testingproject-398915.California_Housing.California_Hosuing_Cities as
SELECT *,
ROUND(Distance_to_coast/5000)*5 as Rounded_Distance_To_Coast,
ROUND(Distance_to_LA/5000)*5 as Rounded_Distance_To_LA,
ROUND(Distance_to_SanDiego/5000)*5 as Rounded_Distance_To_SanDiego,
ROUND(Distance_to_SanFrancisco/5000)*5 as Rounded_Distance_To_SanFrancisco,
ROUND(Distance_to_SanJose/5000)*5 as Rounded_Distance_To_SanJose
From `testingproject-398915.California_Housing.California_Hosuing_Cities`

