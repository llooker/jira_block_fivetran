  view: version {
    sql_table_name: JIRA.VERSION ;;

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.ID ;;
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
      sql: ${TABLE}._FIVETRAN_SYNCED ;;
    }

    dimension: archived {
      type: yesno
      sql: ${TABLE}.ARCHIVED ;;
    }

    dimension: description {
      type: string
      sql: ${TABLE}.DESCRIPTION ;;
    }

    dimension: name {
      type: string
      sql: ${TABLE}.NAME ;;
    }

    dimension: overdue {
      type: yesno
      sql: ${TABLE}.OVERDUE ;;
    }

    dimension: project_id {
      type: number
      # hidden: yes
      sql: ${TABLE}.PROJECT_ID ;;
    }

    dimension_group: release {
      type: time
      timeframes: [
        raw,
        date,
        week,
        month,
        quarter,
        year
      ]
      convert_tz: no
      datatype: date
      sql: ${TABLE}.RELEASE_DATE ;;
    }

    dimension: released {
      type: yesno
      sql: ${TABLE}.RELEASED ;;
    }

    dimension_group: start {
      type: time
      timeframes: [
        raw,
        date,
        week,
        month,
        quarter,
        year
      ]
      convert_tz: no
      datatype: date
      sql: ${TABLE}.START_DATE ;;
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
        project.id,
        project.name
      ]
    }
  }
