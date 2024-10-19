##### Week 2 Assignment Q/A

What is our user repeat rate
**80%**  
``` sql
select count_if(is_frequent_buyer)/count(*) 
from  DEV_DB.DBT_SDWINDGMAILCOM.fact_user_orders
where is_buyer = TRUE
``` 
What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?  

Likely to purchase again:
 - If user has purchased more than once
 - Autoship (new data)
 - User has positive social interaction with products (ratings/comments) (new data)

Not likely to purchase again:
 - User has positive social interaction with products (ratings/comments) (new data)
 - User funnel - if sessions drop after page views
 - Refund / order cancellation (new data)

Explain the product mart models you added. Why did you organize the models in the way you did?
I followed the walkthrough.  I didn't want to get ahead of myself building out models based on assumptions which can lead to unnecessary rework.

Tests:
-- Primary keys are not-null and unique
-- Accepted values for event_type

-- If source systems aren't enforcing constraints based on business process, I would 1) alert process owner to prioritize storing constraints properly and 2) add tests for these requirements.
-- I would set up automatic alerting to team and process owners when constraints fail
-- I would explore using data contracts as part of SDLC 

Snapshots:  
Which products had their inventory change from week 1 to week 2? 
I didn't add the proper snapshot config tag to my sql file last week so it didn't run. Fixed it this week so moving forward will be able to check.