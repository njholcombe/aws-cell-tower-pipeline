# Cell Tower Data Pipeline

## Overview
An **ingestion → transformation → storage** pipeline for cell tower data.  
The pipeline automates data collection, applies transformations, and persists results into a target datalake house.

## Architecture
1. **Ingestion**  
   - Data pulled from external sources (e.g., [OpenCellID](https://opencellid.org/)) via REST API.  
   - Orchestrated with AWS Step Functions and EventBridge for scheduling.  
   - Metadata-driven configuration stored in DynamoDB.  

2. **Transformation**  
   - CSV/JSON data is loaded to raw zone.  
   - Deduplication and filtering loaded to curated zone.   

3. **Storage**  
   - Raw, curated, and presentation layer/zones stored in Amazon S3.  
   - Athena external tables provide query access. 

## Components
- **Lambda Functions**: startjob, getjobdetails, Daily_OpenCellID_Ingest, completejob  
- **DynamoDB Metadata Table entries**: job, job details, source details, target details  
- **Step Functions**: sf-intellicell-ingest-etl-dev-weekly-v001
- **EventBridge Rule**: Daily_OpenCellID_Ingest( Scheduling pipeline runs)  
- **Athena/Redshift**: Raw table Curated table  

## Repository Structure
```text
.
├── .github/
│   └── workflows/            # CI/CD workflows
├── config/                   # runtime/env configuration (JSON/YAML)
├── data_contracts/           # schemas, column mappings, DQ rules
├── docs/                     # diagrams and project docs
├── etl/                      # Lambda/Glue code and transforms
├── infra/                    # IaC: CDK/Terraform/CloudFormation
├── orchestration/            # Step Functions, EventBridge, handlers
├── samples/                  # sample data, Athena DDL/CTAS
├── security/                 # IAM policies, KMS config, guardrails
├── tools/                    # local scripts and helpers
├── validate/                 # tests, linters, data validation checks
└── README.md



