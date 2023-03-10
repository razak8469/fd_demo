from airflow import DAG
from airflow.providers.apache.beam.operators.beam import BeamRunPythonPipelineOperator

def ingest_data(dag: DAG, **kwargs) -> BeamRunPythonPipelineOperator:
    BATCH_PIPELINE_CODE = kwargs.get('BATCH_PIPELINE_CODE')
    TEMP_LOCATION = kwargs.get('TEMP_LOCATION')
    STAGING_LOCATION = kwargs.get('STAGING_LOCATION')
    REGION = kwargs.get('REGION')
    
    ingest_data_task = BeamRunPythonPipelineOperator(
        task_id = "ingest_data_task",
        runner="DataflowRunner",
        py_file=BATCH_PIPELINE_CODE,
        pipeline_options={
            "temp_location": TEMP_LOCATION,
            "staging_location": STAGING_LOCATION,
        },
        py_requirements=["apache-beam[gcp]==2.40.0"],
        py_interpreter='python3',
        py_system_site_packages=False,
        dataflow_config={
            "job_name": "pkl-data-ingestion",
            "location": REGION,
            "wait_until_finished": False,
        },
    )
    return ingest_data_task
