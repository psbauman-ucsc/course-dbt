{% macro events_per_type(table_name, type_column) %} 

    {% set event_types = dbt_utils.get_column_values(table_name, type_column) %}

    {% for event_type in event_types %}
        , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) AS total_{{ event_type }}
    {% endfor %}

{% endmacro %} 