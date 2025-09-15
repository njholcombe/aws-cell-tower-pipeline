# Data Lake Metadata Schema

This document defines the metadata control-plane tables that govern jobs, datasets, sources, and targets in the data lake.

---

## MD_JOBS
Registry of all jobs defined in the data lake environment.  
Stores high-level job identifiers, names, descriptions, and ownership details to provide a catalog of available workloads.

---

## MD_JOBS_DET
Stores parameter and configuration values required for job execution.  
Each record links to a job via `job_id` and captures key/value pairs such as bucket names, tokens, and runtime arguments.

---

## MD_JOBCONFIG
Holds control metadata for orchestration of jobs.  
Defines operational settings such as trigger sources (e.g., EventBridge rules), execution bindings (Step Function names), status flags, and scheduling metadata to dynamically control workflow behavior.

---

## MD_JOB_EXECUTION
Tracks runtime instances of jobs.  
Each record corresponds to one execution, recording `execution_id`, `job_id`, start/end timestamps, and current status (`STARTED`, `COMPLETED`, `FAILED`) to support monitoring and auditing.

---

## MD_DATASETS
Catalog of datasets managed in the lakehouse.  
Maps dataset identifiers to database/schema, logical table names, target storage identifiers, and lifecycle status, forming the central registry for available data assets.

---

## MD_SRC_CTRL
Metadata control table for registered data sources.  
Defines whether a source is enabled, source identifiers, and source names to support ingestion management.

---

## MD_TGT_CTRL
Metadata control table for registered targets.  
Defines target identifiers, storage locations (e.g., S3 buckets), target types, and status flags to manage curated/bronze/silver/gold zones.

---

## MD_SRC_DET
Captures detailed configuration for each source.  
Includes authentication parameters, connection details, and other attributes required to fetch data from external systems.

---

## MD_TGT_DET
Captures detailed configuration for each target.  
Defines file formats, partitioning schemes, or transformation rules, enabling controlled delivery of datasets into specific zones.

---

## MD_SRC_TGT_CTRL
Defines mappings between sources and targets.  
Describes relationships such as ingestion flow (e.g., *“OpenCellID raw feed lands in Raw Zone”*), linking a `source_id` to a `target_id` with descriptive relationship metadata.
