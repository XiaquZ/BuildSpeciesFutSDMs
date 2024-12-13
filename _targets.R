# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
library(clustermq)

## Settings for clustermq
options(
  clustermq.scheduler = "slurm",
  clustermq.template = "./cmq.tmpl" # if using your own template
)

# Set target options:
tar_option_set(
  resources = tar_resources(
    clustermq = tar_resources_clustermq(template = list(
      job_name = "auto-sdms",
      per_cpu_mem = "8000mb",
      n_tasks = 1,
      per_task_cpus = 36,
      walltime = "20:00:00"
    ))
  )
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# tar_source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
tar_plan(
  tar_target(tile_paths,
             list.files(
               "D:/Output/fut_SDMs/species_tiles/",
               full.names = TRUE
             )),
  # Make future species distributions
  tar_target(BuildFutVRT,
             Build_VRT(tile_paths),
             pattern = map(tile_paths)
  )
)
