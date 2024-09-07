/*
Question: What are the most optimal skills to learn (aka it's in high demand AND a high-paying skill)?
- Identify skills in high demand that are associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salary),
  offering strategic insights for career development in data analysis
*/

-- 1st query demonstrating the use of CTEs

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
),  average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25

-- 2nd query, more concise with the same results as 1st query

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.skill_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*
Here are some key insights from the dataset:

1. **Top-paying skills**:  
   The highest-paying skill is "Go" with an average salary of $115,320, followed by "Confluence" at $114,210, and "Hadoop" at $113,193.

2. **High demand vs. salary**:  
   "Python" has the highest demand with 236 job openings but a relatively lower average salary of $101,397 compared to less in-demand skills like "Go" or "Confluence."

3. **Top demand skills**:  
   "Python" (236 jobs), "R" (148 jobs), "Tableau" (230 jobs), and "SAS" (63 jobs) are the most in-demand skills.

4. **Lower-paying yet popular skills**:  
   Despite high demand, skills like "Tableau" ($99,288) and "SAS" ($98,902) have lower average salaries compared to high-demand but higher-paying skills.

5. **Skill demand variance**:  
   While "Looker" has a high demand (49 jobs), its average salary is only $103,795. Similarly, "Azure" (34 jobs) pays $111,225, showing a balance between demand and compensation.

6. **Specialized skills**:  
   Niche skills like "BigQuery" (13 jobs) and "Snowflake" (37 jobs) command higher salaries ($109,654 and $112,948, respectively) compared to more general skills like "Java" ($106,906) and "NoSQL" ($101,414).

7. **Skills with balanced demand and salary**:  
   "AWS" (32 jobs) with a salary of $108,317 and "SQL Server" (35 jobs) at $97,786 are examples of skills with both decent demand and competitive salaries.

These insights reflect the relationship between demand and salary for various technical skills, highlighting where specialized knowledge commands a premium.
*/
