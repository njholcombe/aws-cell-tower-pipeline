# Data Lake Metadata Schema

This document defines the metadata control-plane tables that govern jobs, datasets, sources, and targets in the data lake.

---
MD_JOBS
Comment: Holds high-level job definitions, linking sources, targets, and datasets.

MD_JOBS_DET
Comment: Stores detailed runtime parameters for each job (e.g., S3 bucket names, tokens, expected headers).

MD_JOB_CONFIG
Comment: Stores configuration and trigger details for jobs (e.g., EventBridge rule names, Step Function names, status flags).

MD_JOB_EXECUTION
Comment: Tracks every execution instance of a job, including start time, end time, and status.

MD_DATASETS
Comment: Defines datasets managed in the data lake, including dataset identifiers, database/table names, and status.

MD_SRC
Comment: Master list of sources feeding the data lake, including source name and enabled flag.

MD_SRC_DET
Comment: Key-value details for each source (e.g., auth type, connection info, endpoints).

MD_TGT
Comment: Master list of targets in the data lake (e.g., Raw, Curated, Results zones).

MD_TGT_DET
Comment: Key-value details for each target (e.g., S3 bucket paths, formats, permissions).
