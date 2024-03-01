select * from hrdata

select sum(employee_count) as employee_count from hrdata
--where education = 'High School'
--where department = 'R&D'
where education_field = 'Medical'

select count(attrition) from hrdata
where attrition = 'Yes'and department = 'R&D' and education_field= 'Medical'
and education = 'High School'

select round (((select count(attrition) from hrdata where attrition = 'Yes'and department ='Sales' ) /
sum(employee_count))*100, 2) from hrdata
where department ='Sales'

select sum(employee_count)-(select count(attrition) from hrdata where attrition= 'Yes'
						   and gender = 'Male')
from hrdata where gender = 'Male'

select round(Avg(age),0)as Avg_age from hrdata

--attrition by gender

select gender, count (attrition) from hrdata
where attrition = 'Yes' and education = 'High School' 
group by gender
order by count(attrition) desc

--departement wise attrition

select department, count(attrition), 
round((cast(count(attrition) as numeric)
	 / (select count(attrition) from hrdata where attrition= 'Yes' and gender = 'Female'))*100, 2) as pct 
from hrdata
where attrition ='Yes' and gender = 'Female'
group by department
order by count(attrition) desc

--no of emo by age --
select age , sum(employee_count) from hrdata
where department = 'R&D'
group by age
order by age

--education field wise --
select education_field, count(attrition) from hrdata
where attrition = 'Yes'-- and department = 'Sales'
group by education_field
order by count(attrition) desc

-- attrition rate by age group--

select age_band, gender, count(attrition),
round( (cast(count(attrition) as numeric)/
(select count(attrition) from hrdata where attrition='Yes' ))*100, 2) as pct
from hrdata
where attrition= 'Yes'
group by age_band, gender 
order by age_band, gender

--job satisfaction rating--

select * 
from crosstab(
	'select job_role,job_satisfaction, sum(employee_count)
	from hrdata
	group by job_role, job_satisfaction
	order by job_role, job_satisfaction'
	 )as ct(job_role varchar(50),one numeric, two numeric, three numeric, four numeric)
order by job_role;

CREATE EXTENSION IF NOT EXISTS tablefunc;

select age_band, gender, sum(employee_count) from hrdata
group by age_band,gender
order by age_band, gender desc
 
