/*
what are top 10 paying data analyst jobs that are remote?
*/


select 
	job_id,
	j1.company_id,
	job_title_short,
	c1.name as company_name,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date::date
from 
	job_postings_fact as j1
left join company_dim as c1 on c1.company_id=j1.company_id
where 
	job_title_short='Data Analyst' and
	job_location='Anywhere' and
	salary_year_avg is not null
order by 
	salary_year_avg desc
limit 10

