# Near Real Time Datawarehouse prototype Using Mesh Join Algorithm
This project covers the implementation and analysis of near real time Data Warehouse prototype for Metro shopping store.

# Project Overview
Metro is one of the biggest supermarkets and has many branches spreading across Pakistan. It generates tons of transaction data and information. With this data we can create a data warehouse for analyzing their business information. To achieve the analysis goal, we need to build a near-real-time warehouse. 
The aim of this project is to create a data warehouse with 10,000 transaction records, 100 products and 50 customers. As the data from the transaction data is incomplete, we need to get some information from master data tables like details of product, supplier and customer. To do that we need to join the master data tables with transaction data and for joining we need to implement the extended Mesh Join algorithm. The MESHJOIN (Mesh Join) algorithm was introduced by Polyzotis in 2008 with objective of implementing the Stream- Relation join operation in the transformation phase of ETL. 

# Pseudocode
While (true):
	Read transaction_data (50 tuples)
	Add to hash table
	Add join attribute to queue
	Load master data partitions
	Compare master data partitions with hash table
	If match:
		 Aggregate and add to DW
	If queue. is full ():
		Dequeue ()
		Remove corresponding records form hash table
	
Note: in our case we have limited transaction data i.e.,10,000, so we will apply a check in our algorithm i.e., if the transaction limit reaches to 10,000 and completes all comparisons and the queue becomes empty then we break our loop.  

# How to Copile
Follow the below instructions in order:

Step 1: Create the java project in eclipse using provided project file.
Step 2: Add two external JAR files present in lib folder to your java project.
Step 3: Create schema using Transactional _ MasterData Generator.sql file in mysql workbench.
Step 4: Create star schema of warehouse using warehouse.sql in mysql workbench.
Step 5: Compile the java project named warehouse (src/warehouse/*) which contains meshJoin code in connection.java file and main.java file.
	Enter the below details when required. 
        Username: root
        Password: root
	On entering correct details, the database will be connected and ETL process will start.
Step 6: On completion of compilation, the star schema warehouse in mysql workbench will be populated.
Step 7: Apply OLAP queries on the created warehouse schema using queries.sql file.


