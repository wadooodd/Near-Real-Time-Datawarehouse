
DROP schema if exists warehouse;
create schema warehouse;
use warehouse;

-- DIMENSION TABLES
DROP TABLE if exists STORES;
DROP TABLE if exists PRODUCTS;
DROP TABLE if exists SUPPLIERS;
DROP TABLE if exists CUSTOMERS;
DROP TABLE if exists DATES;

-- FACT TABLE
DROP TABLE if exists SALES;

CREATE TABLE STORES(
    STORE_ID VARCHAR(4) PRIMARY KEY NOT NULL,
    STORE_NAME VARCHAR(20) NOT NULL
);


CREATE TABLE PRODUCTS(
    PRODUCT_ID VARCHAR(6) PRIMARY KEY NOT NULL,
    PRODUCT_NAME VARCHAR(30) NOT NULL
    
);


CREATE TABLE SUPPLIERS(
    SUPPLIER_ID VARCHAR(5) PRIMARY KEY NOT NULL,
    SUPPLIER_NAME VARCHAR(30) NOT NULL
);


CREATE TABLE CUSTOMERS(
    CUSTOMER_ID VARCHAR(4) PRIMARY KEY NOT NULL
);


CREATE TABLE DATES(
    TIME_ID VARCHAR(20) PRIMARY KEY NOT NULL, 

    TDATE VARCHAR(20) NOT NULL, --  ddmmyyyy

    DD INTEGER(2) NOT NULL CONSTRAINT DD_CK
        CHECK(DD >=1 AND DD <= 31),

    WEEK INTEGER(2) NOT NULL  CONSTRAINT WEEK_CK 
        CHECK (WEEK >= 1 AND WEEK <= 52),

    MM VARCHAR(10) NOT NULL,

    QTR INTEGER(1) NOT NULL CONSTRAINT QTR_CK
        CHECK(QTR >=1 AND QTR <= 4),

    YYYY INTEGER(4) NOT NULL,

    WEEKDAY VARCHAR(10) NOT NULL CONSTRAINT WEEKDAY_CK 
        CHECK (
            WEEKDAY IN ('SUNDAY','MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY','FRIDAY','SATURDAY')
        )
);



CREATE TABLE SALES(

	TRANSACTION_ID VARCHAR(10) PRIMARY KEY ,
    STORE_ID VARCHAR(4) ,  
    PRODUCT_ID VARCHAR(6) , 
    SUPPLIER_ID VARCHAR(5) , 
    CUSTOMER_ID VARCHAR(4) , 
    TIME_ID VARCHAR(20) ,
    TOTAL_SALE DECIMAL(10,2) , 

    CONSTRAINT fk_STORE_ID FOREIGN KEY (STORE_ID) REFERENCES STORES(STORE_ID),
    CONSTRAINT fk_PROD_ID FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID),
    CONSTRAINT fk_SUPPLIER_ID FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIERS(SUPPLIER_ID),
    CONSTRAINT fk_CUSTOMER_ID FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID),
    CONSTRAINT fk_TIME_ID FOREIGN KEY (TIME_ID) REFERENCES DATES(TIME_ID)
    
);

