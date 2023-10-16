# California_housing_value
A look into a dataset looking at housing prices in and around major California cities in 1997. each datapoint is based on data for a subdivision within 50 different Californian cities. In this project so far SQL has been used to clean and analyze the data. This includes determining the list of cities that contain above average housing value, above average income level and below average distance to the coast.

The dataset was first loaded into BigQuery where the SQL commands found in data_cleaning_california_housing.sql were used to create columns for average rooms per household, average bedrooms perhousehold and rounded distances to highlighted cities.These are new data points that have not yet been used but will be used in the future parts of this project.

After that was complete the SQL Commands found in Data_analysis.sql where used to first determine which cities had above average housing values, above average income and below average distance to the coast. the list of these cities were saved within their own tables and a multiple inner join was used to find the cities that that were in all three tables and these cities were considered to be the afluent cities near the coast.
The afluent cities near the coast were found to be:
1. San Mateo
2. Los Angeles
3. Orange
4. San Francisco
5. Santa Cruz
6. Contra Costa
7. Martin
8. Ventura
9. Santa Clara
10. Santa Barbra

Overall this project is to show inital competency with the use of SQL for database managment and analysis. 
