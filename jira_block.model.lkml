connection: "snowflake_demo"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: jira_block_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: jira_block_default_datagroup
