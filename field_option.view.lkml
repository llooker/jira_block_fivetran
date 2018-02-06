view: field_option {
  sql_table_name: JIRA.FIELD_OPTION ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      issue_custom_checkbox.count,
      issue_custom_checkbox_history.count,
      issue_custom_select_history.count,
      issue_multi_select_list.count,
      issue_multi_select_list_history.count
    ]
  }
}
