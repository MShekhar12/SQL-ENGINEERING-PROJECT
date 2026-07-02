/*retrieve the top 10 skills with the highest demand in the remote job market,
providing insights into the most valuable skills for data engineers seeking remote work?
*/
SELECT sd.skills, count(jpf.*) AS demand_count
From job_postings_fact AS jpf 
    inner join skills_job_dim AS sjd 
    ON jpf.job_id=sjd.job_id
    inner JOIN skills_dim AS sd 
    on sjd.skill_id = sd.skill_id 
Where jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = true
Group BY sd.skills
order by demand_count desc
LIMIT 10;


/*
Here's the breakdown of the most demanded skills for data engineers:
SQL and Python are by far the most in-demand skills, with around 29,000 job postings each - nearly double the next c...
Cloud platforms round out the top skills, with AWS leading at ~18,000 postings, followed by Azure at ~14,000.
Apache Spark completes the top 5 with nearly 13,000 postings, highlighting the importance of big data processing ski...

Key takeaways:
- SQL and Python remain the foundation for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Java and GCP round out the top 10 most requested skills
_____________________________
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
*/


