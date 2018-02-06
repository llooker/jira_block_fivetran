view: project {
  sql_table_name: JIRA.PROJECT ;;

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

  dimension: project_category_id {
    type: number
    sql: ${TABLE}.PROJECT_CATEGORY_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, component.count, issue_project_history.count, version.count]
  }
}
