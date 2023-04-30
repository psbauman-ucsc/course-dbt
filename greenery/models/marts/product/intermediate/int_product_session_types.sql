select
    user_id,
    session_id
    {{ events_per_type('events','event_type') }}
from source( 'postgres', 'events' )
group by 1,2
