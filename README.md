
# Freelancer Market Performance

Interactive Tableau dashboard exploring freelancer **rates**, **experience**, **skills**, and **geography**.

**Live dashboard:** <div class='tableauPlaceholder' id='viz1758512269625' style='position: relative'><noscript><a href='#'><img alt='Global Freelancer Market Overview ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;gl&#47;global_freelancers_project&#47;GlobalFreelancerMarketOverview&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='global_freelancers_project&#47;GlobalFreelancerMarketOverview' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;gl&#47;global_freelancers_project&#47;GlobalFreelancerMarketOverview&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='zh-TW' /><param name='filter' value='publish=yes' /></object></div> <script type='text/javascript'> var divElement = document.getElementById('viz1758512269625'); var vizElement = divElement.getElementsByTagName('object')[0]; if ( divElement.offsetWidth > 800 ) { vizElement.style.minWidth='1500px';vizElement.style.maxWidth='1600px';vizElement.style.width='100%';vizElement.style.minHeight='877px';vizElement.style.maxHeight='977px';vizElement.style.height=(divElement.offsetWidth*0.75)+'px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.minWidth='1500px';vizElement.style.maxWidth='1600px';vizElement.style.width='100%';vizElement.style.minHeight='877px';vizElement.style.maxHeight='977px';vizElement.style.height=(divElement.offsetWidth*0.75)+'px';} else { vizElement.style.width='100%';vizElement.style.height='2227px';} var scriptElement = document.createElement('script'); scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js'; vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
---

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
- Converted rate/percent fields to numeric
- Median imputation for missing numerics
- Duplicate checks with window functions


---



