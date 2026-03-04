{% macro generate_surrogate_key(field_list) %}

    {% set fields = [] %}
    {% for field in field_list %}
        {% set _ = fields.append("COALESCE(CAST(" ~ field ~ " AS VARCHAR), 'null')") %}
    {% endfor %}

    MD5(
        CONCAT(
            {{ fields | join(", '-', ") }}
        )
    )

{% endmacro %}


{% macro cents_to_dollars(column_name, scale=2) %}
    ROUND({{ column_name }} / 100, {{ scale }})
{% endmacro %}


{% macro date_spine(start_date, end_date) %}
    SELECT
        GENERATE_SERIES(
            '{{ start_date }}'::DATE,
            '{{ end_date }}'::DATE,
            INTERVAL '1 day'
        )::DATE AS date_day
{% endmacro %}


{% macro safe_divide(numerator, denominator) %}
    CASE
        WHEN {{ denominator }} = 0 OR {{ denominator }} IS NULL THEN NULL
        ELSE {{ numerator }} / {{ denominator }}
    END
{% endmacro %}