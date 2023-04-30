select
    user_id,
    session_id
    {{ events_per_type(source( 'postgres', 'events' ), 'event_type') }}
from {{ table }} 
group by 1,2
