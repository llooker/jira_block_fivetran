view: sprint_details {
# If you have information embedded in the Sprint Name, extract that data into
# separate columns in this derived table
# Otherwise, it's identical to the Sprint table
derived_table: {
    sql: select *, trim(split_part(name,'-',1)) as release, trim(split_part(name,'-',2)) as sprint, trim(split_part(name,'-',3)) as team from jira.sprint where name ~ 'R[0-9]+\s*-\s*S[0-9]+\s*-\s*.*'
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension_group: start_date {
    type: time
    sql: ${TABLE}.start_date ;;
  }

  dimension_group: end_date {
    type: time
    sql: ${TABLE}.end_date ;;
  }

  dimension_group: complete_date {
    type: time
    sql: ${TABLE}.complete_date ;;
  }

  dimension: board_id {
    type: number
    sql: ${TABLE}.board_id ;;
  }

  dimension: release {
    type: string
    sql: ${TABLE}.release ;;
  }

  dimension: sprint {
    type: string
    sql: ${TABLE}.sprint ;;
  }

  dimension: team {
    type: string
    sql: ${TABLE}.team ;;
  }

  set: detail {
    fields: [
      id,
      name,
      start_date_time,
      end_date_time,
      complete_date_time,
      board_id,
      release,
      sprint,
      team
    ]
  }
}
