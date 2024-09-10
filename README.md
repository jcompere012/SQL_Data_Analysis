--read me--

# Introduction

    Dive into the data job market! Focusing on data analyst roles, this project explores top-paying jobs, in -demand skills, and where high demand meets high salary in data analytic

SQL queries? Chekc them out here: [project_sql folder](/projects_sql/)

## Tools I Used

- **SQL**: The main tool use for my analysis allowing me to query the database
- **PostgreSQL**: The chosen database management system
- **Visual Studio Code**: Database management and executing SQL queries
- **GIT & GitHub**: Essential for version control and sharing my SQL scripts and analysis.

## The Analysis

To identify the high-paying jobs roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
   SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

What skill are required for the top-paying data analyst jobs?

```sql
WITH top_paying_jobs AS(

SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT top_paying_jobs.*,
        skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```

what are the most in-demand skills for data analysts?

```sql
SELECT skills,
    COUNT(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = true
GROUP BY skills
ORDER BY demand_count DESC
Limit 5
```

what are the most optimal skills to learn?

```sql
SELECT skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg)) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = true
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,
    demand_count DESC
Limit 25;
```

With each query it allowed me to popular the most on demand skill to find, learn and find the best opportunities for data analytic roles.
