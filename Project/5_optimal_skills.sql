--what are the optimal skills which have both demand and good pay?

--simple method
select
	s1.skills,
	count(s1.skill_id) as demand,
	round(avg(j1.salary_year_avg),0) as avg_salary
from job_postings_fact as j1
inner join 
    skills_job_dim as s2 on s2.job_id=j1.job_id
inner join 
    skills_dim as s1 on s2.skill_id=s1.skill_id
where job_title_short='Data Analyst' and
      j1.salary_year_avg is not null
group by s1.skills
having count(s1.skill_id)>10
order by avg_salary desc,
         demand desc



--alternative method using CTE'S

with demand as(--cte 1
  select 
    s1.skill_id,
	s1.skills,
	count(s2.skill_id) as number
from job_postings_fact as j1
inner join 
    skills_job_dim as s2 on j1.job_id=s2.job_id
inner join 
    skills_dim as s1 on s1.skill_id=s2.skill_id
where j1.job_title_short='Data Analyst' and
j1.salary_year_avg is not null
group by s1.skill_id
),

top_paying as (--cte 2
select 
    s1.skill_id,
	s1.skills,
	round(avg(j1.salary_year_avg),0) as average_salary
from job_postings_fact as j1
inner join 
    skills_job_dim as s2 on s2.job_id=j1.job_id
inner join 
    skills_dim as s1 on s1.skill_id=s2.skill_id
where salary_year_avg is not null and
     job_title_short='Data Analyst'
group by s1.skill_id
)

select 
	demand.skill_id,
	demand.skills,
	demand.number,
	top_paying.average_salary
from demand
inner join 
    top_paying on demand.skill_id=top_paying.skill_id
where demand.number>10
order by top_paying.average_salary desc,
         demand.number desc
	     



