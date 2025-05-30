# Introdution
Dive into Data job market! this project focus on Data Analyst job, in-demand skills, and high demand jobs with high salary.

SQL queries? Check them out: [project_sql folder](/project_sql/)

Data taken from [SQL Course](https://www.youtube.com/watch?v=7mz73uXD9DA)

### The question i wnated to answe through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills require for these top paying jobs?
3. What skills are more in-demand for Data Analyst
4. Which skills are associated with higher salary?
5. What are the most optimal skills to learn?


# Tools I used

Following are the tools i used to analyze my questions:

- **SQL** : To query database
- **PostgreSQL** : to choose databse mangement system
- **Visual Studio** : To Excuting SQL queries
- **Git & GitHub** : To share SQL query and project

# The Analysis
Every query checks the different aspects of Data Analyst Job Market.

### 1. Top Paying Data Analyst Jobs

In this query, I filtered the Data Analyst jobs with hightest salary in any location.

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
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

🔍 Sample Insights
- Highest-paying role: Data Analyst at Mantys – $650,000/year
- Most common titles include Data Analyst, Director, and Principal Data Analyst
- All roles are remote-friendly and full-time, making them ideal for flexible work setups.

### 2. Skills for Top Paying Jobs

This dataset presents a detailed overview of high-paying data analytics job listings, with a focus on the technical skills required for each role. 

```sql
WITH top_paying_jobs AS (

SELECT 
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
```

#### 🗂️ Dataset Features

Each record in the dataset represents a combination of a job posting and an individual skill required for that position. This structure allows for flexible skill-based analysis.

#### 🔍 Sample Insights
- 💼 Highest-paying job: Associate Director - Data Insights at AT&T, paying $255,829.50/year

- 🔧 Top skills in demand include:
sql, python, tableau, r, aws, azure, power bi, excel, pandas, snowflake

- 🏢 Companies featured: AT&T, Pinterest, UCLA Health, SmartAsset, Inclusively, Motional, and others

💡 Use Cases
This dataset can be used for:

- Identifying in-demand data skills and their associated salary ranges
- Creating dashboards to visualize salary vs. skill trends
- Building recommendation systems for job seekers based on skill sets
- Training machine learning models to predict salary based on job title and skills

![Top Skills](Graphs\2_Top_skills.png)
*Bar Graph represting top skills. It is generated by Chat GPT*

### 3. In-Demand Skills for Data Analysts

These skills are essential for data professionals and reflect current industry needs across analytics, business intelligence, and data engineering roles.

| Skills | Demand Count |
|--------|--------------|
|SQL     |7291          |
|Excel   |4611          |
|Python  |4330          |
|Tableau |3745          |
|Power Bi|2609          |


```sql
SELECT 
  skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_title_short = 'Data Analyst' AND
  job_work_from_home = True
GROUP BY
  skills
ORDER BY
  demand_count DESC
LIMIT 5;
```
These are foundational tools in data analytics, engineering, and visualization, and represent core competencies employers are looking for.

### 4. Skills based on Salary

While some skills are in high demand, others command exceptionally high salaries due to specialization and niche expertise. Here are the top 10 highest-paying skills based on job listings:

| Skill       | Avg. Salary (USD) |
| ----------- | ----------------- |
| SVN         | \$400,000         |
| Solidity    | \$179,000         |
| Couchbase   | \$160,515         |
| DataRobot   | \$155,486         |
| Go (Golang) | \$155,000         |
| MXNet       | \$149,000         |
| dplyr       | \$147,633         |
| VMware      | \$147,500         |
| Terraform   | \$146,734         |
| Twilio      | \$138,500         |

🧠 These skills may appear less frequently in job listings but are highly valued due to their specialized applications in blockchain (e.g., Solidity), MLOps (e.g., DataRobot, Terraform), and scalable infrastructure (e.g., VMware, Twilio).

```sql
SELECT 
  skills,
  ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 10;
```
### 5. Most Optimal Skills to Learn
The following skills stand out for their balance between demand and compensation. These tools and technologies appear frequently in job listings and offer strong earning potential for data professionals, engineers, and analysts:
| Skill      | Demand Count | Avg. Salary (USD) |
| ---------- | ------------ | ----------------- |
| Python     | 236          | \$101,397         |
| Tableau    | 230          | \$99,288          |
| R          | 148          | \$100,499         |
| SAS        | 63           | \$98,902          |
| Looker     | 49           | \$103,795         |
| Oracle     | 37           | \$104,534         |
| Snowflake  | 37           | \$112,948         |
| SQL Server | 35           | \$97,786          |
| Azure      | 34           | \$111,225         |
| AWS        | 32           | \$108,317         |
*Table made with ChatGPT*

🔍 Other notable skills include Go, Hadoop, BigQuery, Java, and Redshift, all offering six-figure averages and consistent job postings.

📊 This mix of data platforms, programming languages, and cloud tools reflects current hiring trends and the growing need for professionals skilled in both data engineering and analytics platforms.


```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING 
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

# What I Learned

- **Advanced SQL Querying** : I deepened my understanding of SQL by writing complex queries to extract meaningful insights from structured datasets, including aggregations, filtering, and multi-table joins.
- **Data Aggregation & Grouping** : I learned how to use GROUP BY, COUNT(), and AVG() functions effectively to analyze skill demand and average salaries across different technologies.
- **Subqueries & CTEs**: I practiced using subqueries and Common Table Expressions (CTEs) to simplify complex logic and make queries more readable and maintainable.
- **Data-Driven Decision Making**: This project helped me understand how SQL can be used to support real-world business decisions—like identifying high-demand or high-paying skills in the tech job market.
- **Performance Optimization** : I became more aware of how to write efficient queries that reduce processing time, especially when working with large datasets.

                                                        