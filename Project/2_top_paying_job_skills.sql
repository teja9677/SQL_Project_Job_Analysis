/*
what are the top paying job and their respective skills?
*/

with top_pay as (
select 
	j1.job_id,
	job_title,
	job_title_short,
	c1.name as company_name,
	salary_year_avg
	
from 
	job_postings_fact as j1
left join company_dim as c1 on c1.company_id=j1.company_id

where 
	job_title_short='Data Analyst' and
	job_location='Anywhere' and
	salary_year_avg is not null
order by 
	salary_year_avg desc
limit 10)


select 
	t1.job_id,
	t1.job_title,
	t1.job_title_short,
	t1.company_name,
	s1.skills,
	t1.salary_year_avg
	
from top_pay as t1
inner join skills_job_dim as s2 on s2.job_id=t1.job_id
inner join skills_dim as s1 on s1.skill_id=s2.skill_id
order by t1.salary_year_avg desc



