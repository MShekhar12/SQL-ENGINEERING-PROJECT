/*What are highest paying data skills for data engineers?
calculate Median
focus on remote positions 
include skill frequency to add both salary and demand
*/
SELECT sd.skills,
    median(salary_year_avg) AS Mediansalary, 
    count(jpf.*) AS demand_count
From job_postings_fact AS jpf 
    inner join skills_job_dim AS sjd 
    ON jpf.job_id=sjd.job_id
    inner JOIN skills_dim AS sd 
    on sjd.skill_id = sd.skill_id 
Where jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = true
Group BY sd.skills
Having count(jpf.*)>100
order by Mediansalary desc
LIMIT 25;


/*
Here's a breakdown of the highest-paying skills for Data Engineers:

Key Insights:
- Rust remains the top-paying skill at $210K median salary, though demand is still relatively limited (232 postings)
- Terraform and Golang both have high median salaries at $184K, with strong demand (Terraform: 3,248 postings; Golang: 912 postings)
- Other notable skills with both high pay and moderate-to-high frequency include:
  - Spring: $175.5K median salary (364 postings)
  - Neo4j: $170K median salary (27 postings)
  - GDPR: $169.6K median salary (582 postings)
  - GraphQL: $167.5K median salary (445 postings)
  - Kubernetes: $150.5K median salary (6,202 postings)
  - Airflow: $150K median salary (9,996 postings)
- Butbucket, Ruby, Redis, Ansible, and Jupyter all appear in the top 25 for pay, each with hundreds of postings.
- Most skills on the list are no longer extreme statistical outliers with just a handful of postings; instead, many

Takeaway: While the very top-paying skill (Rust) still has less demand than major cloud and data tools, most of the

┌────────────┬──────────────┬──────────────┐
│   skills   │ Mediansalary │ demand_count │
│  varchar   │    double    │    int64     │
├────────────┼──────────────┼──────────────┤
│ rust       │     210000.0 │          232 │
│ terraform  │     184000.0 │         3248 │
│ golang     │     184000.0 │          912 │
│ spring     │     175500.0 │          364 │
│ neo4j      │     170000.0 │          277 │
│ gdpr       │     169615.5 │          582 │
│ zoom       │     168437.5 │          127 │
│ graphql    │     167500.0 │          445 │
│ mongo      │     162250.0 │          265 │
│ fastapi    │     157500.0 │          204 │
│ bitbucket  │     155000.0 │          478 │
│ django     │     155000.0 │          265 │
│ crystal    │     154223.5 │          129 │
│ c          │     151500.0 │          444 │
│ atlassian  │     151500.0 │          249 │
│ typescript │     151000.0 │          388 │
│ kubernetes │     150500.0 │         4202 │
│ airflow    │     150000.0 │         9996 │
│ css        │     150000.0 │          262 │
│ node       │     150000.0 │          179 │
│ ruby       │     150000.0 │          736 │
│ redis      │     149000.0 │          605 │
│ vmware     │    148798.25 │          136 │
│ ansible    │    148798.25 │          475 │
│ jupyter    │     147500.0 │          400 │
└────────────┴──────────────┴──────────────┘

*/

