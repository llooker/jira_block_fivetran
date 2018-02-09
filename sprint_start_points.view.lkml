view: sprint_start_points {
#   The total number of story points assigned to this sprint on day 1, which is used
#   for burndown.  This calculation isn't entirely accurate as it's possible that an
#   existing issue could be assigned to this sprint after the first day
  derived_table: {
    sql: SELECT sprint.id, sprint.name, sum(issue.story_points) as start_points
      FROM jira.sprint AS sprint
      JOIN jira.issue_sprint AS issue_sprint
         ON sprint.id = issue_sprint.sprint_id
      JOIN jira.issue AS issue
         ON issue_sprint.issue_id = issue.id
      WHERE issue.created <= sprint.start_date
      GROUP BY sprint.id, sprint.name
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

  dimension: start_points {
    type: number
    sql: ${TABLE}.start_points ;;
  }

  set: detail {
    fields: [id, name, start_points]
  }
}
