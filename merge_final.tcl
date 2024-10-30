load -run test_base_directed
report_metrics -detail -out coverage_base_directed.rpt -metrics all -source on
merge  test_base_directed -out merged_final -initial_model merged_data
load -run merged_final
report_metrics -detail -out merged_final.rpt -metrics all   -source on
# quit
