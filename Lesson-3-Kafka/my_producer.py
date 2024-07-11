from confluent_kafka import Producer
from clickhouse_driver import Client
import pandas as pd
import json

config = {
    'bootstrap.servers': 'localhost:29092',
    'client.id': 'simple-producer'
}

producer = Producer(**config)


with open(f"/Users/mulyukov/Documents/WB work/GitLab/keys/wb_key_ch.json") as json_file:
    credentials = json.load(json_file)

client = Client(credentials['server'][0]['host'],
                user=credentials['server'][0]['user'],
                password=credentials['server'][0]['password'],
                port=credentials['server'][0]['port'],
                verify=False,
                database='default',
                settings={"numpy_columns": False, 'use_numpy': False},
                compression=True)

def delivery_report(err, msg):
    if err is not None:
        print(f"Message delivery failed: {err}")
    else:
        print(f"Message delivered to {msg.topic()} [{msg.partition()}] at offset {msg.offset()}")

def send_message(data):
    try:
        # Асинхронная отправка сообщения
        producer.produce('test_topic_json', data.encode('utf-8'), callback=delivery_report)
        producer.poll(0)
    except BufferError:
        print(f"Local producer queue is full ({len(producer)} messages awaiting delivery): try again")

if __name__ == '__main__':
    data = client.execute('select shk_id, chrt_id from default.SHKonPlace limit 100')
    for i in range(len(data)):
        data_tuple = data[i]
        json_string = str({"shk_id": data_tuple[0], "chrt_id": data_tuple[1]})
        send_message(json_string)
    producer.flush()