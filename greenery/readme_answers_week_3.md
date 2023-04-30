## What is our overall conversion rate?

**Raw query:**

```
with sessions as (
select 
count(session_id) as total_sessions 
from DEV_DB.DBT_PSBAUMANUCSCEDU.INT_PRODUCT__SESSION_TYPES
),
purchase_events as (
select
count(session_id) as checkout_sessions 
from DEV_DB.DBT_PSBAUMANUCSCEDU.INT_PRODUCT__SESSION_TYPES
where total_checkout > 0
)
select
round((p.checkout_sessions / s.total_sessions)*100,2) as global_conversion_rate
from purchase_events as p, sessions as s
```

**Results:**

62.46%


## What is our conversion rate by product?

SQL def for DIM_PRODUCT__CONVERSION:

```

with view_events as (
  select product_id, 
  count(distinct session_id) as view_sessions 
  from {{ ref('int_product__views') }}
  group by product_id
),

purchase_events as (
  select product_id,
  product_name,
  count(session_id) as checkout_sessions 
  from {{ ref('int_product__checkouts' ) }}
  group by product_id, product_name
)

select p.product_id,
p.product_name,
round((p.checkout_sessions / v.view_sessions)*100,2) as conversion_rate
from purchase_events as p, view_events as v
where p.product_id = v.product_id


```

Results:

```
select product_name, conversion_rate from DEV_DB.DBT_PSBAUMANUCSCEDU.DIM_PRODUCT__CONVERSION order by 2;

Pothos              34.43
Angel Wings Begonia 39.34
Snake Plant         39.73
Ponytail Palm       40
Peace Lily          40.91
Alocasia Polly      41.18
Boston Fern         41.27
Pink Anthurium      41.89
Birds Nest Fern     42.31
Ficus               42.65
Bird of Paradise    45
Orchid              45.33
Money Tree          46.43
Dragon Tree         46.77
Pilea Peperomioides 47.46
Spider Plant        47.46
Jade Plant          47.83
Philodendron        48.39
Devil's Ivy         48.89
Aloe Vera           49.23
Majesty Palm        49.25
Fiddle Leaf Fig     50
Calathea Makoyana   50.94
Monstera            51.02
Rubber Plant        51.85
Bamboo              53.73
ZZ Plant            53.97
Cactus              54.55
Arrow Head          55.56
String of pearls    60.94
```


### Which products had their inventory change from week 2 to week 3? 

```
select distinct name from dev_db.dbt_psbaumanucscedu.products_snapshot where dbt_valid_to > to_date('2023-04-24');
```

Results:

```
Pothos
Philodendron
Monstera
String of pearls
ZZ Plant
Bamboo
```