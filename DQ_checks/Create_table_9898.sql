CREATE TABLE `advanced-analytics-278408.user__rubini_riccardo.9898__pipelines_target_landing_zone_metadata`
(
  analysis_date         DATE OPTIONS(description="Date when the monitoring check has run (generated at runtime)"),
  analysis_date_time    DATETIME OPTIONS(description="Date-time when the monitoring check has run (generated at runtime)"),
  project_id            STRING OPTIONS(description="Part (1) of the unique ID of the table monitored (project.dataset.table)"),
  dataset_id            STRING OPTIONS(description="Part (2) of the unique ID of the table monitored (project.dataset.table)"),
  table_id              STRING OPTIONS(description="Part (3) of the unique ID of the table monitored (project.dataset.table)"),
  
  complete_table_id     STRING OPTIONS(description="the unique ID of the table monitored (project.dataset.table)"),
  table_code            STRING OPTIONS(description="Table internal code (XXYY) where XX identify the source system code and YY identify the increasing number of pipelines created from that system, making the XXYY code unique. "),
  is_to_be_monitored    BOOL OPTIONS(description="Flag that indicates if this table need to be taken into account into the automatic monitoring"),
  current_development_status STRING OPTIONS(description="Status of development for this pipeline in a scale that goes from a manual import to a Factory manage ingestion fully automated and monitored"),
  current_development_status_id STRING OPTIONS(description="Status of development for this pipeline in a scale that goes from a manual import to a Factory manage ingestion fully automated and monitored"),
  source_system_id      STRING OPTIONS(description="Source system from which data are extracted (ID) - should be coherent with first 2 digit of the pipeline code"),
  source_system_name    STRING OPTIONS(description="Source system from which data are extracted (name)"),
  source_system_ownership_type STRING OPTIONS(description="Source system ownership could be either Internal (meaning Swarovski managed) or external (meaning managed by a third party data provider)"),
  extraction_tool       STRING OPTIONS(description="Tool used for data extraction from (A) source system to (B) landing zone in GCP"),
  extraction_script     STRING OPTIONS(description="Reference to the script/procedure used to extract the data"),
  extraction_is_scheduled BOOL OPTIONS(description="Flag that indicates if the data extraction is somehow scheduled (could be on a fix time or trigger based)"),
  extraction_schedule_pattern STRING OPTIONS(description="Indicates either the CRON pattern (0 8 * * *) - or specify the trigger (TRIGGER-<Trigger_Type>)"),
  landing_zone          STRING OPTIONS(description="Indicates which is the landing zone (either GCS or BQ)"),
  landing_zone_path     STRING OPTIONS(description="Indication of where precisly the landing zone is located (either BQ table ID or GCS radix path) "),
  landing_zone_form     STRING OPTIONS(description="Indication of which form the data arrives in the landing zone (mix of format and raw/clean status))"),
  loading_tool          STRING OPTIONS(description="Tool used for data loading - and eventually cleansing - from (A) landing zone to (B) consumption BQ table in GCP"),
  load_script           STRING OPTIONS(description="Reference to the script/procedure used to load/cleanse the data"),
  load_is_scheduled     BOOL OPTIONS(description="Flag that indicates if the data loading is somehow scheduled (could be on a fix time or trigger based)"),
  load_schedule_pattern STRING OPTIONS(description="Indicates either the CRON pattern (0 8 * * *) - or specify the trigger (TRIGGER-<Trigger_Type>)"),
  load_form             STRING OPTIONS(description="Indication of which form the data arrives in the final BQ table (with or without DX applied:common naming/types - data cleansing - descriptions - ...)"),
  
  --bucket metadata
  
  bucket_id             STRING OPTIONS(description="Bucket id"),
  bucket_name           STRING OPTIONS(description="Bucket name"),
  bucket_created        STRING OPTIONS(description="Creation date of the bucket"),
  bucket_location       STRING OPTIONS(description="Regional location where data are stored"),
  bucket_location_type  STRING OPTIONS(description="Type of storage of the bucket, Regiona/Multi-Regional"),
  bucket_storage_class  STRING OPTIONS(description="Storage class for the bucket"),

  --info about the bucket structure and files within 

  file_path_policy_respected                BOOL OPTIONS(description="Checks the correct form of the path structure, i.e. source_system/pipeline_code/pipeline_version/year"),
  file_path_source_system                   STRING OPTIONS(description=""),
  file_path_pipeline_code                   STRING OPTIONS(description=""),
  file_path_pipeline_code_distinct_versions INT64 OPTIONS(description="Counts the number of version for each pipeline"),
  file_path_pipeline_code_distinct_versions_sizes STRING OPTIONS(description="Contains one or more arrays with the path and the size of files contained in it"),
  file_path_pipeline_code_checked_version   STRING OPTIONS(description=""), --TODO: check what this is and the type needed
  file_number_in_landing_zone_path          INT64 OPTIONS(description=""),
  file_size_in_landing_zone_path            FLOAT64 OPTIONS(description=""),
  file_oldest_creation_datetime             TIMESTAMP OPTIONS(description=""),
  file_newest_creation_datetime             TIMESTAMP OPTIONS(description=""),
  
  file_name_policy_respected            BOOL OPTIONS(description="Checks that there are four info separated by double underscore in the file name"),
  file_name_pipeline_code_info          STRING OPTIONS(description=""),
  file_name_pipeline_name_info          STRING OPTIONS(description=""),
  file_name_pipeline_windowframe_info   STRING OPTIONS(description=""),
  file_name_pipeline_history_min_info   STRING OPTIONS(description=""),
  file_name_pipeline_history_max_info   STRING OPTIONS(description=""),
  files_period_covered                  STRING OPTIONS(description="List of array containing each for each date the size and the number of files processed"),
  files_period_missing_between_min_max  STRING OPTIONS(description="Arrays containing the number of files missing and the missing dates"),
  warning_flag_status                   STRING OPTIONS(description="This filed can assume the following values: GREEN/YELLOW/RED according to the update frequency of the file itself (daily,weekly,monthly) and the difference between the current datetime of the function run and the creation datetime of the last file")
)
OPTIONS(
  description="Main metadata information - This table is periodically updated with metadata information (number of files, last update, last date point within the data, distinct ID within the data) so to help track possible issues un data updates that works automatically, directly on target table (thus where data are consumed by PROD use-cases and/or use-cases developments)",
  labels=[("usage", "prod"), ("team", "da-dle"), ("updates_type", "automatically")]
);