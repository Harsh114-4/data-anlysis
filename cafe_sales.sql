create table d1 like dirty_cafe_sales ; 

insert d1  select * from dirty_cafe_sales ; 

select * from d1 ;

# finding duplicate values if they exist 

select `Transaction ID`, Item, Quantity, `Price Per Unit`, `Total Spent`, `Payment Method`, Location, `Transaction Date` , count(*) as dup_c from d1 group by `Transaction ID`, Item, Quantity, `Price Per Unit`,`Total Spent`,`Payment Method`, Location, `Transaction Date` having dup_c>1 ;

with cte_d as ( select * , ROW_NUMBER() over (partition by  `Transaction ID`, Item, Quantity, `Price Per Unit`, `Total Spent`, `Payment Method`, Location) row_num from d1 ) select * from cte_d where row_num >1 ;

# no dup values found 

# standadizing data 

select * from d1 ; 

select `Transaction ID` , count(*) from d1 GROUP BY `Transaction ID` having count(*)>1 ;

 select distinct Item from d1 ; 
 
 select * from d1 where Item like 'UNKNOWN' or '' or 'ERROR';
 
 select DISTINCT Quantity from d1 ;
 
 select distinct `Price Per Unit` from d1 ; 
 
 select  (`Quantity`*`Price Per Unit`) as spent , `Total Spent` from d1 where  (`Quantity`*`Price Per Unit`) = `Total Spent`; 
 
update d1  set `Total Spent`= (`Quantity`*`Price Per Unit`) where `Total Spent` in  ('ERROR', 'UNKNOWN' , '');


ALTER TABLE d1
MODIFY `Total Spent` DOUBLE;

desc d1 ; 

select * from d1 ; 

select distinct `Payment Method` from d1 ; 

select distinct Location from d1 ;  

select distinct `Transaction Date` from d1 ; 

update d1 set `Payment Method` = null where `Payment Method` in ('ERROR', 'UNKNOWN' , '');

update d1 set Item = null where Item in ('ERROR', 'UNKNOWN' , '');

update d1 set `Transaction Date` = null where `Transaction Date` in ('ERROR', 'UNKNOWN' , '');

update d1 set Location  = null where Location  in ('ERROR', 'UNKNOWN' , '');

# DEALING WITH NULLS 
 
 SELECT * FROM d1 ; 	
 
 select * from d1 where `Item` is null and `Payment Method` is null and `Location` is null ; 
 
 delete from d1 where `Item` is null and `Payment Method` is null and `Location` is null;
 
 delete from d1 where Item is null ; 
 
UPDATE d1 SET `Transaction Date` = STR_TO_DATE(`Transaction Date`, '%Y-%m-%d');

alter table d1 MODIFY `Transaction Date` DATE ; 

desc d1 ; 

SELECT * FROM D1 ;
SELECT COUNT(DISTINCT `Transaction ID`) , COUNT(Item) FROM D1 ;

# REMOVING UNNNECASRY COLUMN S
# NO UNNECASSRY COLUMNS FOUND 

# EDA 

select * from d1 ;

select Item , sum(`Total Spent`) ttl from d1 GROUP BY Item ; 

select Item , count(Item) from d1  group by Item ; 

select distinct Item,`Price Per Unit` from d1 ;

select `Payment Method` , count(`Payment Method`) from d1 group by `Payment Method` ; 

SELECT `Location` , SUM(`Total Spent`) from d1  group by Location;

select MIN(`Transaction Date`) , max(`Transaction Date`) from d1 ; 

select * from d1 ; 

with m_d1 as ( select * , 	substring(`Transaction Date`,6 ,2) as months from d1 ) select months from m_d1 group by months order by months;

 with m_d1 as ( select * , 	substring(`Transaction Date`,6 ,2) as months from d1 ) select months , COUNT(`Price Per Unit`) ttl from m_d1 group by months order by ttl ;

 with m_d1 as ( select * , 	substring(`Transaction Date`,6 ,2) as months from d1 ) select months , Item , count(Item) from m_d1 group by months , Item order by months ;
 
  with m_d1 as ( select * , 	substring(`Transaction Date`,6 ,2) as months from d1 ) select months , Item , count(Item) i from m_d1 group by months,Item having months=12 order by i ;
  
  with m_d1 as ( select * , 	substring(`Transaction Date`,6 ,2) as months from d1 ) select months , Location, count(Location) from m_d1 group by months , Location having months =1  ;
  
  alter table d1  add column months int ;
  
  update d1 set months=substring(`Transaction Date`,6 ,2);
  
  select * from d1 ; 
  
