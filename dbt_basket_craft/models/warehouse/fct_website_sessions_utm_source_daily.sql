WITH stg_website_sessions AS (
   SELECT * FROM {{ ref('stg_website_sessions') }}
),
fct_website_sessions_utm_source_daily AS (
   SELECT
       DATE(website_session_created_at) AS website_session_day,
        utm_source,
        COUNT(website_session_id) AS sessions,
        SUM(is_repeat_session)::INT AS repeat_sessions,
        ROUND((SUM(is_repeat_session)::NUMERIC / COUNT(website_session_id)) * 100, 2) AS repeat_session_pct
   FROM stg_website_sessions
   GROUP BY DATE(website_session_created_at), utm_source
   ORDER BY website_session_day, utm_source
)
SELECT * FROM fct_website_sessions_utm_source_daily