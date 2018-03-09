explore: looker_numbers {}

view: looker_numbers {
#   Numbers table used for sprint burndown
derived_table: {
  sql: SELECT
        p0.n
        + p1.n*2
        + p2.n * POWER(2,2)
        + p3.n * POWER(2,3)
        + p4.n * POWER(2,4)
        + p5.n * POWER(2,5)
        + p6.n * POWER(2,6)
        + p7.n * POWER(2,7)
        + p8.n * POWER(2,8)
        + p9.n * POWER(2,9)
        + p10.n * POWER(2,10)
        as number
      FROM
        (SELECT 0 as n UNION SELECT 1) p0,
        (SELECT 0 as n UNION SELECT 1) p1,
        (SELECT 0 as n UNION SELECT 1) p2,
        (SELECT 0 as n UNION SELECT 1) p3,
        (SELECT 0 as n UNION SELECT 1) p4,
        (SELECT 0 as n UNION SELECT 1) p5,
        (SELECT 0 as n UNION SELECT 1) p6,
        (SELECT 0 as n UNION SELECT 1) p7,
        (SELECT 0 as n UNION SELECT 1) p8,
        (SELECT 0 as n UNION SELECT 1) p9,
        (SELECT 0 as n UNION SELECT 1) p10

 ;;
  indexes: ["number"]
  persist_for: "24 hours"
  # For Redshift only
  #distribution_style: all
}

measure: count {
  type: count
  drill_fields: [detail*]
}

dimension: number {
  type: number
  sql: ${TABLE}.number ;;
}

set: detail {
  fields: [number]
}
}
