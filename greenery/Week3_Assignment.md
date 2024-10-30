##### Week 3 Assignment Q/A

### Part 1: 
What is our overall conversion rate?  **63%**
``` sql
SELECT 
    COUNT(DISTINCT CASE WHEN CHECKOUTS > 0 THEN SESSION_ID END) / COUNT(DISTINCT SESSION_ID) AS conversion_rate
FROM 
    DEV_DB.DBT_SDWINDGMAILCOM.FACT_SESSIONS;
```

What is our conversion rate by product?

| Product                | Conversion Rate |
|------------------------|-----------------|
| String of pearls       | 0.609375        |
| Arrow Head             | 0.555556        |
| Cactus                 | 0.545455        |
| ZZ Plant               | 0.539683        |
| Bamboo                 | 0.537313        |
| Rubber Plant           | 0.518519        |
| Monstera               | 0.510204        |
| Calathea Makoyana      | 0.509434        |
| Fiddle Leaf Fig        | 0.500000        |
| Majesty Palm           | 0.492537        |
| Aloe Vera              | 0.492308        |
| Devil's Ivy            | 0.488889        |
| Philodendron           | 0.483871        |
| Jade Plant             | 0.478261        |
| Spider Plant           | 0.474576        |
| Pilea Peperomioides    | 0.474576        |
| Dragon Tree            | 0.467742        |
| Money Tree             | 0.464286        |
| Orchid                 | 0.453333        |
| Bird of Paradise       | 0.450000        |
| Ficus                  | 0.426471        |
| Birds Nest Fern        | 0.423077        |
| Pink Anthurium         | 0.418919        |
| Boston Fern            | 0.412698        |
| Alocasia Polly         | 0.411765        |
| Peace Lily             | 0.409091        |
| Ponytail Palm          | 0.400000        |
| Snake Plant            | 0.397260        |
| Angel Wings Begonia    | 0.393443        |
| Pothos                 | 0.344262        |


Note: I created a periodic snapshot table for weekly trending

``` sql
select 
    name as product,
    div0(converted_sessions,total_sessions) as conversion_rate
from DEV_DB.DBT_SDWINDGMAILCOM.FACT_PRODUCT_SESSIONS_SNAPSHOT_WEEKLY
where week_start_date= (
                        select 
                            max(week_start_date) 
                        from DEV_DB.DBT_SDWINDGMAILCOM.FACT_PRODUCT_SESSIONS_SNAPSHOT_WEEKLY)
order by conversion_rate desc
```
Why might certain products be converting at higher/lower rates than others? 
** I think seasonality would be a driver of conversion rates since certain plants require different growing conditions to thrive.**

### Part 2:
Create a macro to simplify part of a model(s). 
** https://github.com/sdwind/course-dbt/blob/main/greenery/macros/sum_of.sql **

### Part 3:
Add a post hook to your project to apply grants to the role “reporting”. 
** https://github.com/sdwind/course-dbt/blob/main/greenery/macros/grant.sql ** 

### Part 4:
Add calogica/dbt_date to create dim_date
** https://github.com/sdwind/course-dbt/blob/main/greenery/packages.yml **

### Part 5:


### Part 6:
Which products had their inventory change from week 2 to week 3? 
**
Philodendron
Monstera
ZZ Plant
Bamboo
**