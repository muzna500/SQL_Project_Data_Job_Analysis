/*
Question: What are the top=paying data Analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on jon posting  with specified salaies (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment opportunities 
across all over world.
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact