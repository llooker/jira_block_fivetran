view: issue_custom_date_time_history {
  sql_table_name: JIRA.ISSUE_CUSTOM_DATE_TIME_HISTORY ;;

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: issue_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.ISSUE_ID ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}.TIME ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.VALUE ;;
  }

  measure: count {
    type: count
    drill_fields: [issue.id, issue.epic_name]
  }
}
