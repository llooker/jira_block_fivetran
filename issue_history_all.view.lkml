# This PDT is used to produce a single list of all historical changes in issues
# It is used for displaying a complete list of the history of an issue in
# the Issue Details Dashboard.
# It is made by Unioning together all of the history tables
# Each table has an additional hard coded value aliased as "changed"
# to indicate the value that was changed

# The examples below are to be used as a template and will not
# match the history tables in your installation

view: issue_history_all {
  derived_table: {
    datagroup_trigger: fivetran_datagroup
    sql: -- History tables for single value fields
      select ph."issue_id", ph."time", p."name", 'Project' as "changed" from jira.issue_project_history ph
      LEFT OUTER JOIN jira.project p on ph.project_id = p.id
      UNION
      select sh."issue_id", sh."time", fo."name", 'Severity' as "changed" from jira.issue_severity_history sh
      LEFT OUTER JOIN jira.field_option fo on sh.field_option_id = fo.id
      UNION
      select toh."issue_id", toh."time", u."name", 'Technical Owner' as "changed" from jira.issue_technical_owner_history toh
      LEFT OUTER JOIN jira.user u on toh.user_id = u.id
      -- History tables for multi-value fields
      UNION
      select bh."issue_id", bh."time", bh."value", 'Browser History' as "changed" from jira.issue_browser_s_history bh
      UNION
      select cih."issue_id", cih."time", cih."value", 'Customer Impacted' as "changed" from jira.issue_customer_s_impacted_history cih
      UNION
      select erh."issue_id", erh."time", fo."name", 'Op Equipment Request' as "changed" from jira.issue_op_equipment_request_history erh
      LEFT OUTER JOIN jira.field_option fo on erh.field_option_id = fo.id
      UNION
      select trh."issue_id", trh."time", fo."name", 'Op Tools Request' as "changed" from jira.issue_op_tools_request_history trh
      LEFT OUTER JOIN jira.field_option fo on trh.field_option_id = fo.id
       ;;
    indexes: ["issue_id", "time"]
    # For Redshift only
    #distribution_style: all
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: issue_id {
    type: number
    sql: ${TABLE}.issue_id ;;
  }

  dimension_group: time {
    type: time
    sql: ${TABLE}.time ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  dimension: changed {
    type: string
    sql: ${TABLE}.changed ;;
  }

  set: detail {
    fields: [issue_id, time_time, value, changed]
  }
}
