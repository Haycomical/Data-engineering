from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def read_file():
    with open('/tmp/data.txt', 'r') as f:
        data = f.read()
        print("Content of the file:", data)

with DAG(
    dag_id='consumer_dag',
    start_date=datetime(2023, 1, 1),
    schedule=None,          # ✅ Airflow 2.9+ (instead of schedule_interval)
    catchup=False,
    tags=['example'],
) as dag:

    read_task = PythonOperator(
        task_id='read_file_task',
        python_callable=read_file
    )
