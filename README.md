# Cell Tower Data Pipeline

## Overview
This project implements an **ingestion → transformation → storage** pipeline for cell tower data.  
The pipeline automates data collection, applies transformations, and persists results into a target data lake or warehouse.

## Architecture
1. **Ingestion**  
   - Data pulled from external sources (e.g., [OpenCellID](https://opencellid.org/)) via REST API.  
   - Orchestrated with AWS Step Functions and EventBridge for scheduling.  
   - Metadata-driven configuration stored in DynamoDB.  

2. **Transformation**  
   - Raw CSV/JSON data is normalized and cleaned.  
   - Deduplication and filtering applied.  
   - Curated zone created for downstream analytics.  

3. **Storage**  
   - Raw, curated, and results zones stored in Amazon S3.  
   - Athena external tables provide query access.  
   - (Optional) Data can be loaded into a warehouse (e.g., Redshift).  

## Components
- **Lambda Functions**: Ingestion, transformation, error handling  
- **DynamoDB Metadata Tables**: Job configuration, source/target control, execution tracking  
- **Step Functions**: Orchestration of jobs with retry and error handling  
- **EventBridge**: Scheduling pipeline runs  
- **Athena/Redshift**: Query layer  

## Repository Structure
```text
aws-cell-tower-pipeline/
├── lambdas/         # Python Lambda source
├── sql/             # DDL/DML for Athena and Redshift
├── stepfunctions/   # State machine JSON definitions
├── docs/            # Architecture diagrams and notes
└── README.md


