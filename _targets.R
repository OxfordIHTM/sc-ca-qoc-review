# Seychelles Cancer Quality of Care literature search --------------------------


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Microsoft OneDrive interface setup ----
onedrive_targets <- tar_plan(
  tar_target(
    name = onedrive,
    command = get_business_onedrive()
  )
)


## Data targets ----
data_targets <- tar_plan(
  tar_target(
    name = sids_list,
    command = get_sids()
  ),
  tar_target(
    name = sids_islands,
    command = sids_list$island
  ),
  tar_target(
    name = extraction_matrix_data_file,
    command = onedrive_download_item(
      onedrive = onedrive, src = "Extraction_matrix_1.xlsx",
      dest = "data-raw/extraction_matrix.xlsx", overwrite = TRUE
    ),
    format = "file"
  ),
  tar_target(
    name = extraction_matrix_data,
    command = readxl::read_xlsx(
      path = extraction_matrix_data_file,
      range = "A1:AE24"
    )
  )
)


## Processing targets
processing_targets <- tar_plan(
  
)


## Analysis targets
analysis_targets <- tar_plan(
  
)


## Output targets
output_targets <- tar_plan(
  
)


## Reporting targets
report_targets <- tar_plan(
  tar_quarto(
    name = data_review_report,
    path = "reports/sc-ca-qoc-data-review.qmd",
    working_directory = here::here()
  )
)


## Deploy targets
deploy_targets <- tar_plan(
  
)


## List targets
all_targets()
