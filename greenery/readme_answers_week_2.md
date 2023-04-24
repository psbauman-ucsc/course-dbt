## What is our user repeat rate?

```
with total_orders as (
  select user_id, count(order_id) as order_count
  from dev_db.dbt_psbaumanucscedu.f_orders group by 1
),
main as (
  select count( case when order_count >1 then user_id end) as repeat_customers,
  count(distinct user_id) as total_customers
  from total_orders
)
select round((repeat_customers/total_customers) * 100,2) as repeat_rate
from main;
```

79.84 % repeat rate

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? 

### Repeats
- Users who have received their orders < X delivery time
- Users who have received their orders close to the estimated_delivery value

### Lost
- Users with short session times
- Users with delivery dates exceeding estimated date

## Explain the product mart models you added. Why did you organize the models in the way you did?

Products: Tried to create flattened rows of page_view -> order information, since page_view events don't have order_id's
Core: Similar concept, flattening out checkout/shipping events with order info

Experimented with a base layer for addresses and users, combining them into one staging model since users->addresses is a one-to-one relationship and most queries for users will usually want their bio-demo data

I ran out of time, but think I *should* have created dimensions before building the facts, which ended up having too much join logic that should have been abstracted into re-usable dims

### Tests

Added basic uniqueness, non-null, and relationship verification at the stg layer. I'm less clear on how thorough tests need to be at the intermediate layer and beyond.

Probably need to add some sanity checks on dates (received < ordered), and potential null order_id's on the stg_postgres__events model where event_type = 'checkout'

### Which products had their inventory change from week 1 to week 2? 

```
select name from dev_db.dbt_psbaumanucscedu.products_snapshot where dbt_valid_to is not null;
```
- Pothos
- Philodendron
- Monstera
- String of pearls

