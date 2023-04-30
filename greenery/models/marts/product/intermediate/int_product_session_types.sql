select
    user_id,
    session_id
    {{ events_per_type(source( 'postgres', 'events' ), 'event_type') }}
from source( 'postgres', 'events' )
group by 1,2
