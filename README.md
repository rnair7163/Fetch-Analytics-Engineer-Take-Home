# Fetch-Analytics-Engineer-Take-Home
In this repo, I will go through each of the requirements and provide links wherever necessary.

## Task 1 - Review unstructured JSON data and diagram a new structured relational data model
Based on the data exploration performed, I created a relational data model with 4 datasets:-
- users
- receipts
- brands
- receipts_items_list

All the Data Exploration methodologies can be viewed in this [file](https://github.com/rnair7163/Fetch-Analytics-Engineer-Take-Home/blob/main/Data-Exploration_and_Cleaning.ipynb).

Here is the ER Diagram:

![ER_Diagram](https://github.com/rnair7163/Fetch-Analytics-Engineer-Take-Home/assets/14351816/59e4ab9f-87fb-459d-a708-391551d8a74d)

## Task 2 - Generate a query that answers a predetermined business question 
All the queries are added in this [file](https://github.com/rnair7163/Fetch-Analytics-Engineer-Take-Home/blob/main/sql_queries.sql).

## Task 3 - Generate a query to capture data quality issues against the new structured relational data model
Few of the data quality issues were addressed while working on the [new relational data model](https://github.com/rnair7163/Fetch-Analytics-Engineer-Take-Home/blob/main/Data-Exploration_and_Cleaning.ipynb) such as:-
- Dates present in datasets as epochs. I have converted them to 'YYYY-MM-DD' format for ease of readability and analysis.
- Nulls present in a lot of fields. I filled lot of fields in these datasets using 'unknown' or '0.0' (depending on the data type) making sure they would not mislead analysis. But in other cases, I kept them as those more context more from a subject matter expert. Futher explanation have been provided in the filed linked above.



