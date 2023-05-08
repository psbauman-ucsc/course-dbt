# Part 1. dbt Snapshots

## Which products had their inventory change from week 3 to week 4? 

### Query:

```
select distinct name 
from dev_db.dbt_psbaumanucscedu.products_snapshot 
where dbt_valid_from > to_date('2023-04-30') 
order by 1;
```

### Results:

```
Bamboo
Monstera
Philodendron
Pothos
String of pearls
ZZ Plant
```

## Which products had the most fluctuations in inventory? 

### Query:

```
with total_changes as (
   select name, count('x') as total_rows
   from dev_db.dbt_psbaumanucscedu.products_snapshot 
   group by 1
   order by 2 desc
)
select name, total_rows from total_changes
where total_rows = (
   select max(mx.total_rows)
   from total_changes as mx
)
order by 1

```

### Results:

```
NAME.             TOTAL_ROWS
Monstera          4
Philodendron      4
Pothos            4
String of pearls  4
```


## Did we have any items go out of stock in the last 3 weeks?  

### Query:

```
select distinct name 
from dev_db.dbt_psbaumanucscedu.products_snapshot
where inventory < 1;
```

### Results:

```
String of pearls
Pothos
```

# Part 2. Modeling challenge

The model product/intermediate/int_product__session_types can be used as the source for these

## How are our users moving through the product funnel?

```
select 
round((sum(total_add_to_cart) / sum(total_page_view))*100,2) as pct_funnel_view_to_cart
, round((sum(total_checkout) / sum(total_page_view))*100,2) as pct_funnel_view_to_checkout
, round((sum(total_checkout) / sum(total_add_to_cart))*100,2) as pct_funnel_cart_to_checkout
from int_product__session_types
```

While 52.7% of sessions funnel from a page view to adding inventory to their cart, only 19.29% of these views eventually funnel to a checkout. Funnel from cart to checkout is 36.61%.

## Which steps in the funnel have largest drop off points?

```
select 
100 - round((sum(total_add_to_cart) / sum(total_page_view))*100,2) as pct_dropoff_view_to_cart
, 100 - round((sum(total_checkout) / sum(total_page_view))*100,2) as pct_dropoff_view_to_checkout
, 100 - round((sum(total_checkout) / sum(total_add_to_cart))*100,2) as pct_dropoff_cart_to_checkout
from int_product__session_types
```

The low conversion rate from cart to checkout causes a large dropoff from page view to checkout, which sits at 80.71%

# 3A. dbt next steps for you

Our institution will be tackling student census reporting as the first major snowflake/dbt project, revamping a process that is currently confusing, labor intensive, and the result of non-standardized aggregation from disparate data sources. I'll be managing the team of developers who will be tasked with writing a clean model structure (probably mostly the stg and int models, though they may assist/validate the dims & facts) to join and aggregate some pretty complex data sets from our student information system. We're all very familiar with git branching and proficient in SQL querying our raw tables. As more users begin to build out models, we'll need to have regular code reviews, scheduled dbt tests, and cloudformation alerts for model failures. We'll also need to write some post-hook data obfuscation for our non-production environments since these models will contain sensitive information on students.

I can foresee the temptation to over-use macros in cases where models weren't structured properly, and while CTEs are convenient, we'll need to keep an eye on the performance of "dbt run" and analyze places where a more difficult query without CTE may be more performant. 

