--what are the top paying skills for a specific role?


select 
	s1.skills,
	round(avg(j1.salary_year_avg),0) as average_salary
from job_postings_fact as j1
inner join 
    skills_job_dim as s2 on s2.job_id=j1.job_id
inner join 
    skills_dim as s1 on s1.skill_id=s2.skill_id
where salary_year_avg is not null and
     job_title_short='Data Analyst'
group by skills
order by average_salary desc
limit 25

