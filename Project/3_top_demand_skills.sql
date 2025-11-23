
--what are the indemand skills for any job_role?

with top_skills as(   --cte
	select 
		s2.skill_id,
		count(*) as skill_count
	from 
		job_postings_fact as j1
	inner join skills_job_dim as s2 on s2.job_id=j1.job_id
	where j1.job_title_short='Data Analyst'
	group by skill_id
	order by skill_count desc)

select 
	s1.skills,
	t1.skill_count
	
from skills_dim as s1
inner join top_skills as t1 on t1.skill_id=s1.skill_id
order by t1.skill_count desc
limit 5


--ALTERNATIVE


select 
	s1.skills,
	count(s2.skill_id) as number
	
from job_postings_fact as j1
inner join skills_job_dim as s2 on j1.job_id=s2.job_id
inner join skills_dim as s1 on s1.skill_id=s2.skill_id
where j1.job_title_short='Data Analyst' and j1.job_country='India'
group by s1.skills
order by number desc
limit 5