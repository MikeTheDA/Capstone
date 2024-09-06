/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of job location
- Why? It reveals how different skills impact salary levels for Data Analysts 
  and helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25

/*
From the list of top-paying skills for data analysts, several insights and trends can be identified:

1. Big Data and Cloud Computing Dominance
PySpark tops the list with an impressive average salary of $208,172. PySpark is essential for working with big data and distributed computing, reflecting the increasing demand for large-scale data processing.
Databricks and GCP (Google Cloud Platform) also feature among the high-paying skills, emphasizing the value of cloud-based and scalable data platforms in data analytics.

2. Version Control and Collaboration Tools
Bitbucket and GitLab appear near the top with salaries exceeding $150,000, highlighting the importance of version control systems and collaboration in modern data analytics workflows.
These tools are crucial for maintaining and sharing code, making them a sought-after skill in team environments.

3. Database Management and Querying
Couchbase and PostgreSQL reflect the importance of both NoSQL and traditional relational databases in the data analyst role.
Elasticsearch also appears, showing that knowledge of search and query engines is valuable for handling large-scale data retrieval and indexing.

4. AI/ML and Data Science Libraries
Pandas, Jupyter, Numpy, and Scikit-learn represent core tools in data science, with strong demand for analysts who can work with machine learning and data manipulation libraries.
DataRobot, an AI/ML automation tool, signals that expertise in ML platforms is becoming highly valued.

5. Programming and Automation
Swift and Golang are higher than expected for a data analyst role, indicating that programming languages, typically associated with app and backend development, are becoming part of a data analyst’s toolkit for automation or specialized computation.
Scala also appears on the list, often used in big data frameworks such as Apache Spark.

6. DevOps and Infrastructure Knowledge
Kubernetes, Jenkins, and Airflow are tools related to DevOps and automation, showing the trend toward data engineers and analysts needing to manage data pipelines and continuous integration/continuous deployment (CI/CD) systems.
Mastering these tools implies higher responsibility for managing infrastructure and workflow automation.

7. Business Intelligence Tools
MicroStrategy and Watson highlight the importance of business intelligence platforms, allowing data analysts to translate data insights into business strategies.
Twilio and Notion suggest a rise in the integration of communication platforms and project management tools within the data environment.

8. Key Trends
The highest-paying skills are not just data analysis-focused but also span DevOps, software engineering, and cloud architecture.
Data analysts are expected to have a diverse skill set, extending beyond traditional SQL and Python into tools for automation, collaboration, and machine learning.
Cloud and big data tools dominate the top-paying skills, reflecting the industry's shift towards cloud-native architectures and large-scale data processing.
This suggests that data analysts looking to maximize their earning potential should focus on acquiring cloud computing, big data, machine learning, and infrastructure management skills alongside traditional data analytics techniques.
*/