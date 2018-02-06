view: issue_custom_select_history {
  sql_table_name: JIRA.ISSUE_CUSTOM_SELECT_HISTORY ;;

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: field_option_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.FIELD_OPTION_ID ;;
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

  measure: count {
    type: count
    drill_fields: [issue.id, issue.epic_name, field_option.id, field_option.name]
  }
}
