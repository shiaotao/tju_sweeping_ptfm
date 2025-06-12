# sweeping/mqtt_client.py
import paho.mqtt.client as mqtt
import json

# MQTT 代理地址和端口配置
MQTT_BROKER = "broker.emqx.io"  # 替换为你的 MQTT 代理地址
MQTT_PORT = 1883  # 替换为你的 MQTT 代理端口

def on_connect(client, userdata, flags, rc):
    print("Connected to MQTT Broker with result code " + str(rc))
    client.subscribe("vehicle/#")

def on_message(client, userdata, msg):
    topic = msg.topic
    payload = msg.payload.decode('utf-8')
    print(f"Received message '{payload}' on topic '{topic}'")

# 封装 MQTT 客户端初始化逻辑
def initialize_mqtt_client():
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message
    client.connect(MQTT_BROKER, MQTT_PORT, 60)
    client.loop_start()
    return client
