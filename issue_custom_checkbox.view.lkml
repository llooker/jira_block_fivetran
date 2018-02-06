view: issue_custom_checkbox {
  sql_table_name: JIRA.ISSUE_CUSTOM_CHECKBOX ;;

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

  measure: count {
    type: count
    drill_fields: [issue.id, issue.epic_name, field_option.id, field_option.name]
  }
}
