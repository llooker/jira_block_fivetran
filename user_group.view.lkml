view: user_group {
  sql_table_name: JIRA.USER_GROUP ;;

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: group_name {
    type: string
    sql: ${TABLE}.GROUP_NAME ;;
  }

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [group_name, user.id, user.name]
  }
}
