view: status {
  sql_table_name: jira.status ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: status_category_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.status_category_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, status_category.name, status_category.id, issue_status_history.count]
  }
}
