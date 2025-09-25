
# Freelancer Market Performance

Interactive Tableau dashboard exploring freelancer **rates**, **experience**, **skills**, and **geography**.

**Live dashboard**
➡️ https://public.tableau.com/views/global_freelancers_project/GlobalFreelancerMarketOverview?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

[![Open dashboard](images/dashboard.png)](https://hmt864.github.io/Global_freelancer_project/)


## Tableau Dashboard – What’s inside
- KPIs: Avg hourly rate, avg age, avg rating, number of freelancers
- Skill ranking by client satisfaction
- Experience vs. rate (distribution + trend by skill)
- Country view: map (rate heat + workforce size) and summary stats
- Demographics: age histogram, gender proportion

---

## Data & Cleaning
  
- **Cleaned dataset:** [`global_freelancers_cleaned.csv`](global_freelancers_cleaned.csv)  
- **SQL cleaning script:** [`data_cleaning.sql`](data_cleaning.sql)

**The Cleaning workflow**
- Standardized categorical fields and trimmed strings
  - Standardizing gender into F and M based on the distinct gender values<br><br>
    <img src="images/p1.png" alt="Alt Text" width="600" height="600">
  - Unified and converted hourly_rate_usd from non-numeric characters with "$" sign or "USD" in prefix to numeric numbers<br><br>
    <img src="images/p6.png" alt="Alt Text" width="600" height="600">
  - Standardizing multiple statuses of is_active (eg, 0, 'N', 'False', 'yes') to two statuses, "Y" and "N"<br><br>
    <img src="images/p8.png" alt="Alt Text" width="600" height="600">
  - Client satisfaction was unified and changed from, for example, "40" or "40%" to a numerical value (0.4).<br><br>
    <img src="images/p9.png" alt="Alt Text" width="600" height="600">
- Median imputation for missing numerics
  - The reason for using the median rather than the mean is that the median can prevent the influence of potential outliers.<br><br>
    <img src="images/p11.png" alt="Alt Text" width="600" height="600">
- Duplicate checks with window functions
  - Ensure the same person won't be registered multiple times<br><br>
    <img src="images/p10.png" alt="Alt Text" width="600" height="600">
---

