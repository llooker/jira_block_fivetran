view: status {
  sql_table_name: JIRA.STATUS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: status_category_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.STATUS_CATEGORY_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, status_category.id, status_category.name, issue_status_history.count]
  }
}
