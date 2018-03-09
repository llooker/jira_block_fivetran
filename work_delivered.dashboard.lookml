- dashboard: work_delivered
  title: Work Delivered
  layout: newspaper
  elements:
  - title: Work Delivered Over Time
    name: Work Delivered Over Time
    model: jira_block
    explore: sprint
    type: looker_column
    fields:
    - issue.resolved_date
    - issue.total_story_points
    fill_fields:
    - issue.resolved_date
    sorts:
    - issue.resolved_date
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: cumulative_points
      label: Cumulative points
      expression: running_total(${issue.total_story_points})
      value_format:
      value_format_name:
      _kind_hint: measure
    query_timezone: America/New_York
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    point_style: circle
    series_types:
      cumulative_points: area
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: issue.total_story_points
        name: Total Story Points
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: cumulative_points
        name: Cumulative points
    listen:
      Issue Resolved: issue.is_issue_resolved
      Issue Resolved Date: issue.resolved_date
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: Issue Resolved Date
    title: Issue Resolved Date
    type: field_filter
    default_value: 30 days
    model: jira_block
    explore: sprint
    field: issue.resolved_date
    listens_to_filters: []
    allow_multiple_values: true
    required: false
  - name: Issue Resolved
    title: Issue Resolved
    type: field_filter
    default_value: 'Yes'
    model: jira_block
    explore: sprint
    field: issue.is_issue_resolved
    listens_to_filters: []
    allow_multiple_values: true
    required: false
