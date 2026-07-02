/* What are the most optimal skills for data engineers?(i.e. keeping in mind both skills and salary)
create a ranking column that combines demand count and median salary to identify the most valuable skills*/

SELECT sd.skills,
    ROUND(median(salary_year_avg),0) AS Mediansalary, 
    count(jpf.*) AS demand_count,
    Round(ln(count(jpf.*)),1) AS ln_demand_count, 
    ROUND(median(salary_year_avg)*ln(count(jpf.*))/1_000_000,2) AS optimal_rank
From job_postings_fact AS jpf 
    Inner join skills_job_dim AS sjd 
    ON jpf.job_id=sjd.job_id
    Inner JOIN skills_dim AS sd 
    on sjd.skill_id = sd.skill_id 
Where jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = true
AND jpf.salary_year_avg IS NOT NULL
Group BY sd.skills
Having count(jpf.*)>100
order by optimal_rank desc
LIMIT 25;

/*
/*
Here's a breakdown of the most optimal skills for Data Engineers, based on both high demand and high salaries:

Top Skills by Optimal Score:
- Terraform leads the list with a $184K median salary and 193 postings, resulting in the highest overall "optimal score" of 0.97.
- Python and SQL dominate demand (over 1,100 postings each), with strong median salaries of $135K and $130K, respectively.
- AWS (783 postings, $137K median), Spark (503 postings, $140K median), and Airflow (386 postings, $150K median) offer a strong balance of demand and salary.
- Kafka offers high compensation ($145K median) and solid demand (292 postings).
- Tools like Snowflake, Azure, and Databricks each have 250–475 postings and median salaries between $128K–$135.5K.
- Java, Scala, Git, Redshift, GCP, and Hadoop also provide a balanced mix of demand and salary.
- Kubernetes has one of the highest salaries at $150.5K, but lower demand than Python, SQL, AWS, and Spark.
- PySpark, Docker, MongoDB, Go, R, GitHub, and BigQuery appear further down the list because their demand counts are comparatively lower.



┌────────────┬──────────────┬──────────────┬─────────────────┬──────────────┐
│   skills   │ Mediansalary │ demand_count │ ln_demand_count │ optimal_rank │
│  varchar   │    double    │    int64     │     double      │    double    │
├────────────┼──────────────┼──────────────┼─────────────────┼──────────────┤
│ terraform  │     184000.0 │          193 │             5.3 │         0.97 │
│ python     │     135000.0 │         1133 │             7.0 │         0.95 │
│ sql        │     130000.0 │         1128 │             7.0 │         0.91 │
│ aws        │     137320.0 │          783 │             6.7 │         0.91 │
│ airflow    │     150000.0 │          386 │             6.0 │         0.89 │
│ spark      │     140000.0 │          503 │             6.2 │         0.87 │
│ kafka      │     145000.0 │          292 │             5.7 │         0.82 │
│ snowflake  │     135500.0 │          438 │             6.1 │         0.82 │
│ azure      │     128000.0 │          475 │             6.2 │         0.79 │
│ java       │     135000.0 │          303 │             5.7 │         0.77 │
│ scala      │     137290.0 │          247 │             5.5 │         0.76 │
│ kubernetes │     150500.0 │          147 │             5.0 │         0.75 │
│ git        │     140000.0 │          208 │             5.3 │         0.75 │
│ databricks │     132750.0 │          266 │             5.6 │         0.74 │
│ redshift   │     130000.0 │          274 │             5.6 │         0.73 │
│ gcp        │     136000.0 │          196 │             5.3 │         0.72 │
│ nosql      │     134415.0 │          193 │             5.3 │         0.71 │
│ hadoop     │     135000.0 │          198 │             5.3 │         0.71 │
│ pyspark    │     140000.0 │          152 │             5.0 │          0.7 │
│ mongodb    │     135750.0 │          136 │             4.9 │         0.67 │
│ docker     │     135000.0 │          144 │             5.0 │         0.67 │
│ go         │     140000.0 │          113 │             4.7 │         0.66 │
│ r          │     134775.0 │          133 │             4.9 │         0.66 │
│ github     │     135000.0 │          127 │             4.8 │         0.65 │
│ bigquery   │     135000.0 │          123 │             4.8 │         0.65 │
└────────────┴──────────────┴──────────────┴─────────────────┴──────────────┘

Key takeaway:
The best skills to learn for a Data Engineer role are not just the highest-paying ones. The strongest combination of salary and job demand comes from Python, SQL, AWS, Airflow, Spark, Kafka, Snowflake, and Azure. Terraform ranks first due to its very high salary,
but Python and SQL are the safer foundational skills because they have far more job postings.

*/
