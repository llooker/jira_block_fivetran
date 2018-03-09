explore: looker_calendar {}

view: looker_calendar {
#   Daily calendar used for sprint burndown chart
#   Replace the hard coded date with the correct SQL
#   For your database for choosing a date that is approx
#   3 years in the past
derived_table: {
  persist_for: "24 hours"
  # For redshift
  #distribution_style: all
  sql: SELECT
          DATEADD(day,CAST(numbers.number AS INT), '2013-01-01') as series_date
      FROM ${looker_numbers.SQL_TABLE_NAME} AS numbers ;;
  indexes: ["series_date"]
  }

  dimension_group: series_date {
    type: time
    timeframes: [raw,date,month,quarter,year]
    sql: ${TABLE}.series_date ;;
  }
}
