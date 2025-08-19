from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def write_file():
    with open('/tmp/data.txt', 'w') as f:
        f.write("This is the dataset written by Producer DAG.")

with DAG(
    dag_id='producer_dag',
    start_date=datetime(2023, 1, 1),
    schedule=None,          # ✅ Airflow 2.9+ (instead of schedule_interval)
    catchup=False,
    tags=['example'],
) as dag:

    write_task = PythonOperator(
        task_id='write_file_task',
        python_callable=write_file
    )
