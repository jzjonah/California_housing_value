# California housing value
A look into a dataset looking at housing prices in and around major California cities in 1997. each datapoint is based on data for a subdivision within 50 different Californian cities. In this project so far SQL has been used to clean and analyze the data. This includes determining the list of cities that contain above average housing value, above average income level and below average distance to the coast. The main anaylsis came from creating a table that included Cities that were not near any of the major cities in California( Los Angeles, San Franscisco, San Diego, San Jose) and the cities that were some of the closest to these major cities.

The dataset was first loaded into BigQuery where the SQL commands found in data_cleaning_california_housing.sql were used to create columns for average rooms per household, average bedrooms perhousehold and rounded distances to highlighted cities.These are new data points that have not yet been used but will be used in the future parts of this project.

The analysis had two parts to it, the first being looking at the cities as a whole and trying to find the factors most correlated with the rising of housing value, and the second part is looking at the the affect that being near a major city. All the SQL query used in the analysis can be found in data_analysis_California_housing.sql.

The first part looking for the factors msot correlated with the rising of housing value looked at distnace to coast, number of rooms, number of bedrooms, population and income. From these the variables with the strongest coorolation to the increase in housing value was distnace to coast and population. As seen below housing prices has an exponential coorolation with distance from coast and a strong liniar coorolation with income.

![Dashboard 1 (1)](https://github.com/jzjonah/California_housing_value/assets/55960435/bfb04a1b-8fc0-425b-8d3b-a757a137f1be)


The second part of the analysis looks at the coorolation of houseing value compared to distance to major cities. In the dataset it lists the distnaces each city is from Los Angeles, San Diego, San Jose, and San Franscico, so the first part of the analysis is determining the cities are considered close and which cities are not close. To determine the cities that are close I Found the cities that are above average distance away from each city and then determine the cities that are found on each list. This left me with the list of cites of....
1. Del Norte
2. Modac
3. Sierra
4. Siskiyou
5. Tehama
6. Plumas
7. Lassen
8. Humboldt
9. Shasta

To determine the cites that were clsoe to one of the major cities I found the 4 closest cities to each city and grouped them together. The reason for only taking the top 4 is this gave a similar size of data to the cities that were above average distance from all the cities.

1. Santa Clara
2. Venrura
3. Santa Cruz
4. Los Angeles
5. Alameda
6. San Mateo
7. Imperial
8. Orange
9. Riverside
10. San Francisco
11. San Diego
12. San Bernardino
13. Marin

once the lists of cities were gathered the cities data was grouped together to be ready for analysis where it was determined that the proximity to a large effect on housing value as the cities near major cities had a value of $238,673 and cities not near a major city had a housing value of $79,666. This is a 66% difference which shows a substantial difference but can not be determined as causation due to the strong coorolation that exists betweeen income and proximity to a large city. Cities near a larger city had an income a 42% higher than cities not near a larger city, this is a smaller degree than the increase in housing value but causation can not be determined until a larger look at the underlying factors.
![housing compared to major](https://github.com/jzjonah/California_housing_value/assets/55960435/450434c7-1f87-4533-a44c-121cab73caa3)

Overall this project is to show inital competency with the use of SQL for database managment and analysis. The next steps for this project would include getting or creating a dataset with the dat for these cities in a more recent year to see how these trends have changed with time. 
