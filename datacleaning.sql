select * from retail_store_sales ;

# creating a copy of the real data set 

CREATE TABLE `c1` (
  `Transaction ID` text,
  `Customer ID` text,
  `Category` text,
  `Item` text,
  `Price Per Unit` double DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Total Spent` double DEFAULT NULL,
  `Payment Method` text,
  `Location` text,
  `Transaction Date` text,
  `Discount Applied` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert c1 select * from retail_store_sales;

select * from c1;

# data cleaning steps 
#1. remove duplicate 
#2. standardize the data 
#3.Discount Applied
#4. remove any unnecesary column 

#1. removing duplicates 
 
 with dup_cte as( select * , row_number() over ( partition by `Transaction ID`, `Customer ID`, Category, Item, `Price Per Unit`, Quantity, `Total Spent`, `Payment Method`, Location, `Transaction Date`, `Discount Applied`) as row_num from c1 )select * from dup_cte where row_num>1 ;
 
 # trying a new method to find duplicates 
 
 select `Transaction ID`, `Customer ID`, Category, Item, `Price Per Unit`, Quantity, `Total Spent`, `Payment Method`, Location, `Transaction Date`, `Discount Applied` , count(*) as row_count from c1 group by `Transaction ID`, `Customer ID`, Category, Item, `Price Per Unit`, Quantity, `Total Spent`, `Payment Method`, Location, `Transaction Date`, `Discount Applied` HAVING COUNT(*) > 1;
 
 # no duplicates found ence the data is duplicate free 
 
 # standadizing data 
 
 use data_cleaning ; 
 
 SELECT * from c1 ; 
 
 SELECT DISTINCT `Price Per Unit` from c1; 
 
 DESC c1 ; 
 
select `Price Per Unit` ,  ceiling(`Price Per Unit` ) from c1 ;

# creating a seprate col for rounded up price per unit and keepin the orginal data 

alter table c1 add column rounded_price_per_unti int;

update c1 set rounded_price_per_unti= ceiling(`Price Per Unit`);

select * from c1 ; 

select DISTINCT Quantity from c1 order by Quantity; 

SELECT DISTINCT `Total Spent` from c1; 

select `Total Spent` , ceiling(`Total Spent`) from c1 ;

alter table c1 add column rounded_ttlspent int ;

updat	e c1 set rounded_ttlspent = ceiling(`Total Spent`);

select * from c1 ; 

select DISTINCT `Transaction Date` from c1; 

# tranction date column date format was corect but it was acknowledged as text by sql we will change it to date 

alter table c1 modify `Transaction Date` date ; 

select DISTINCT `Discount Applied` from c1 ; 

# data succesfully standadized 

#3. removing null VALUES 

SELECT * from c1 where `Price Per Unit` is null or `Price Per Unit`='' or `Quantity` is null or `Quantity` ='' or `Payment Method` is null or `Payment Method` ='' or `Location`is null or `Location` ='' or `Discount Applied` is null or `Discount Applied` ='' ;


update c1 set `Discount Applied`=NULL where `Discount Applied`='';

SELECT * from c1 where `Discount Applied1`='' ;

# null vales dealt with 

#4. removing unnecasry col 

SELECT * from c1 ;

SELECT  DISTINCT `Customer ID` from c1;  

# no unnecasy col found 

#---------------------------------EDA--------------------------------#



