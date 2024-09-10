/* Answer: What are the top skills based on salary?
 -Look at the average salary associated with each skills for data analyst postions
 - Focuses on role with specified salaries, regardless of location
 - Why? it reveals how different skills impact salary level for data analyst and helps identify the most financially rewrading skills to acquire or improve */
SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
Limit 20