select * from heartattack;

create table temp like heartattack;

insert temp select * from heartattack;

select * from temp;

-- removing duplicate values
with ff as
{
select * , row_number()over( partition by age, gender, region, income_level, hypertension, diabetes, cholesterol_level, obesity, waist_circumference, family_history, smoking_status, alcohol_consumption, physical_activity, dietary_habits, air_pollution_exposure, stress_level, sleep_hours, blood_pressure_systolic, blood_pressure_diastolic, fasting_blood_sugar,
 cholesterol_hdl, cholesterol_ldl, triglycerides, EKG_results, previous_heart_disease, medication_usage, participated_in_free_screening, heart_attack ) as row_num from temp
 }
 select * from ff where row_num>1;
 
 -- data has no duplicates
 
 -- standardizing data 
 
 select * from temp ;
 
 select distinct waist_circumference from temp;
 
 -- data is already stndadized 
 
 -- finding missig values 
 
SELECT * 
FROM temp
WHERE 
    age IS NULL OR TRIM(age) = '' 
    OR gender IS NULL OR TRIM(gender) = '' 
    OR region IS NULL OR TRIM(region) = '' 
    OR income_level IS NULL OR TRIM(income_level) = '' 
    OR hypertension IS NULL OR TRIM(hypertension) = '' 
    OR diabetes IS NULL OR TRIM(diabetes) = '' 
    OR cholesterol_level IS NULL OR TRIM(cholesterol_level) = '' 
    OR obesity IS NULL OR TRIM(obesity) = '' 
    OR waist_circumference IS NULL OR TRIM(waist_circumference) = '' 
    OR family_history IS NULL OR TRIM(family_history) = '' 
    OR smoking_status IS NULL OR TRIM(smoking_status) = '' 
    OR alcohol_consumption IS NULL OR TRIM(alcohol_consumption) = '' 
    OR physical_activity IS NULL OR TRIM(physical_activity) = '' 
    OR dietary_habits IS NULL OR TRIM(dietary_habits) = '' 
    OR air_pollution_exposure IS NULL OR TRIM(air_pollution_exposure) = '' 
    OR stress_level IS NULL OR TRIM(stress_level) = '' 
    OR sleep_hours IS NULL OR TRIM(sleep_hours) = '' 
    OR blood_pressure_systolic IS NULL OR TRIM(blood_pressure_systolic) = '' 
    OR blood_pressure_diastolic IS NULL OR TRIM(blood_pressure_diastolic) = '' 
    OR fasting_blood_sugar IS NULL OR TRIM(fasting_blood_sugar) = '' 
    OR cholesterol_hdl IS NULL OR TRIM(cholesterol_hdl) = '' 
    OR cholesterol_ldl IS NULL OR TRIM(cholesterol_ldl) = '' 
    OR triglycerides IS NULL OR TRIM(triglycerides) = '' 
    OR EKG_results IS NULL OR TRIM(EKG_results) = '' 
    OR previous_heart_disease IS NULL OR TRIM(previous_heart_disease) = '' 
    OR medication_usage IS NULL OR TRIM(medication_usage) = '' 
    OR participated_in_free_screening IS NULL OR TRIM(participated_in_free_screening) = '' 
    OR heart_attack IS NULL OR TRIM(heart_attack) = '';
    
    -- there are no null values 
    
select* from temp;

-- from online research the diastolic bp is not as much directly related to heart attack as systolic

alter table temp drop column blood_pressure_diastolic;

update temp set sleep_hours = round(sleep_hours,0)
;

-- EDA

-- from online reasearch the cholestrol hdl < 40 and cholestrol hal>130 increae risk of heart attack 

alter table temp add column cholestrol_affect int;
 
 update temp set cholestrol_affect = 0;
 
 update temp set cholestrol_affect = 1 where cholesterol_hdl <40 or cholesterol_ldl>130;
 
 select * from temp where triglycerides > 200;
 
 alter table temp drop column waist_circumference;
  
 alter table temp add column Triglyceride_risk int ;
 
 update temp set Triglyceride_risk =0;
 
 select * from temp ; 
 
 update temp set Triglyceride_risk = 1 where triglycerides >200 ;
 
 alter table temp add Cholesterol_risk int;
 
update temp set Cholesterol_risk =0;

update temp set Cholesterol_risk=1 where cholesterol_level >230;

select count(heart_attack), gender from temp group by gender;

select * from temp ;

select count(heart_attack),hypertension from temp 
where heart_attack=1
group by hypertension;

select count(heart_attack), region from temp 
WHERE heart_attack=1 group by region;

select count(region),region from temp where heart_attack=1 group by region;

-- data containe more input for urban place as compare to rural so we consider the percentages 

select count(region),region from temp group by region ;

select * from temp where hypertension=1 and obesity=1 and Triglyceride_risk=1 and Cholesterol_risk =1;

select count(heart_attack),income_level from temp
 group by income_level;

select count(heart_attack),income_level from temp
where heart_attack=1
group by income_level;

select count(heart_attack),smoking_status from temp group by smoking_status ;

select count(heart_attack),smoking_status from temp group by smoking_status order by smoking_status;

select count(heart_attack),smoking_status from temp where heart_attack=1 group by smoking_status order by smoking_status ;

select count(heart_attack),alcohol_consumption
from temp group by alcohol_consumption order by alcohol_consumption;

select count(heart_attack),alcohol_consumption
from temp where heart_attack=1 group by alcohol_consumption order by alcohol_consumption;

select * from temp;

select  count(heart_attack),dietary_habits from temp group by dietary_habits order by dietary_habits;

select  count(heart_attack),dietary_habits from temp where heart_attack=1 group by dietary_habits order by dietary_habits;

select  count(heart_attack),air_pollution_exposure from temp group by air_pollution_exposure order by air_pollution_exposure;

select  count(heart_attack),air_pollution_exposure from temp where heart_attack=1 group by air_pollution_exposure order by air_pollution_exposure;

-- done till here 

select count(region),region from temp group by region order by region;

select count(region),region from temp where heart_attack=1 group by region order by region  ;

select  region ,income_level, count(heart_attack) from temp  where heart_attack=1 group by region,income_level order by region;

select  count(heart_attack),stress_level from temp group by stress_level order by stress_level;

select  count(heart_attack),stress_level from temp where heart_attack=1 group by stress_level order by stress_level;	

select * from temp;

with cf as (
select count(hypertension),stress_level as have_hp from temp  where hypertension=1 and heart_attack=1 group by stress_level
)
select count(hypertension) doesnot_havehp,stress_level,have_hp from cf;

select region,avg(sleep_hours),count(heart_attack) from temp where heart_attack=1 group by region;

select  count(heart_attack),sleep_hours from temp where heart_attack=1 group by sleep_hours order by sleep_hours;

select count(heart_attack),stress_level from temp where heart_attack=1 group by stress_level;

select avg(blood_pressure_systolic),avg(triglycerides),sleep_hours from temp group by sleep_hours;

select avg(sleep_hours),income_level,count(heart_attack) from temp group by income_level;

select* from temp;

select EKG_results,count(heart_attack) from temp where heart_attack=1 group by EKG_results;

select count(EKG_results) from temp group by EKG_results;

select distinct EKG_results from temp;

select count(heart_attack) from temp where EKG_results='Abnormal';

select count(heart_attack),EKG_results ,heart_attack from temp where EKG_results='Abnormal'
group by heart_attack;

select * from temp;

select hypertension , avg(sleep_hours),count(heart_attack) from temp group by hypertension;

select count(hypertension) from temp where hypertension=0;

alter table temp add column ht int;

update temp set ht=heart_attack;

select * from temp ;