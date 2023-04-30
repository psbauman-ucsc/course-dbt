select
    user_id,
    session_id
    {{ events_per_type(ref('stg_postgres__events'),'event_type') }}
from {{ ref('stg_postgres__events') }}
group by 1,2
