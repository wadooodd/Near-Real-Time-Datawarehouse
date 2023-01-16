# Near Real Time Datawarehouse prototype Using Mesh Join Algorithm
This project covers the implementation and analysis using OLAP of near real time Data Warehouse prototype for Metro shopping store.

## Project Overview
Metro is one of the biggest supermarkets and has many branches spreading across Pakistan. It generates tons of transaction data and information. With this data we can create a data warehouse for analyzing their business information. To achieve the analysis goal, we need to build a near-real-time warehouse. 
The aim of this project is to create a data warehouse with 10,000 transaction records, 100 products and 50 customers. As the data from the transaction data is incomplete, we need to get some information from master data tables like details of product, supplier and customer. To do that we need to join the master data tables with transaction data and for joining we need to implement the extended Mesh Join algorithm. The MESHJOIN (Mesh Join) algorithm was introduced by Polyzotis in 2008 with objective of implementing the Stream- Relation join operation in the transformation phase of ETL. 

## File Information
* Project-DS3003.pdf: contains detailed description of project
* src: contains java code for implementation of mesh join
* lib: contains external JAR files to validate imports in java code
* projectReport: contains detailed project report and results achieved
* queries.sql: contains OLAP queries for analysis of warehouse
* Transactional _ MasterData Generator.sql: contains initial database schema
* warehouse.sql: contains the star schema created

## How to Copile
Follow the below instructions in order:
1. Create the java project in eclipse using provided project file.
2. Add two external JAR files present in lib folder to your java project.
3. Create schema using Transactional _ MasterData Generator.sql file in mysql workbench.
4. Create star schema of warehouse using warehouse.sql in mysql workbench.
5. Compile the java project named warehouse (src/warehouse/*) which contains meshJoin code in connection.java file and main.java file.
	Enter the below details when required. 
        Username: root
        Password: root
	On entering correct details, the database will be connected and ETL process will start.
6. On completion of compilation, the star schema warehouse in mysql workbench will be populated.
7. Apply OLAP queries on the created warehouse schema using queries.sql file.


