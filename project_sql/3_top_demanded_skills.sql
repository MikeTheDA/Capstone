/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table, similar to query 2
- Identify the top 5 in-demand skills for a data analyst
- Focus on all job postings
- Why? Retrieves the top 5 skills with the highest demand in the job market,
  providing insights into the the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5

/*
Here are some insights based on the demand counts for these skills:

1. **SQL**: This skill has the highest demand with 7,291 mentions. It indicates that SQL is highly sought after and is likely crucial for many data-related roles.

2. **Excel**: With 4,611 mentions, Excel is also in high demand. Its widespread use across various industries shows its continued importance in data analysis and reporting.

3. **Python**: Python has a strong demand count of 4,330, reflecting its significance in data analysis, data science, and automation tasks.

4. **Tableau**: This visualization tool is in demand with 3,745 mentions, emphasizing its role in data visualization and dashboard creation.

5. **Power BI**: With 2,609 mentions, Power BI is also in demand but slightly less than Tableau. It suggests that while important, it might be less ubiquitous than Tableau in the current job market.

Overall, SQL, Excel, and Python are the top skills in demand, with a focus on data analysis, while Tableau and Power BI are valuable for visualization.
*/