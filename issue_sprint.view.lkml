  view: issue_sprint {
    sql_table_name: JIRA.ISSUE_SPRINT ;;

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
      sql: ${TABLE}._FIVETRAN_SYNCED ;;
    }

    dimension: pk {
      type: number
      hidden: yes
      primary_key: yes
      sql: CONCAT(${TABLE}.ISSUE_ID,' ',${TABLE}.SPRINT_ID) ;;
    }

    dimension: issue_id {
      type: number
      # hidden: yes
      sql: ${TABLE}.ISSUE_ID ;;
    }

    dimension: sprint_id {
      type: number
      # hidden: yes
      sql: ${TABLE}.SPRINT_ID ;;
    }

    measure: count {
      type: count
      drill_fields: [issue.id, issue.epic_name, sprint.id, sprint.name]
    }
  }
