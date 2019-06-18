import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provide/provide.dart';
import 'package:work_station/design/loading.dart';
import 'package:work_station/provide/mqtt_message.dart';

Future mqttConnect(BuildContext context, String serverhost, String clientIt,
    int port, String username, String password, List<String> topics) async {
  final MqttClient client = MqttClient(serverhost, clientIt);

  client.useWebSocket = true;
  client.port = port;
  client.logging(on: false);
  client.keepAlivePeriod = 30;

  client.onDisconnected = onDisconnected;
  client.onConnected = onConnected;
  client.onSubscribed = onSubscribed;
  client.pongCallback = pong;
  Loading.client = client;

  final MqttConnectMessage connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueIdWildcard${DateTime.now().millisecondsSinceEpoch}')
      .keepAliveFor(30) // Must agree with the keep alive set above or not set
      .withWillTopic('willtopic') // If you set this you must set a will message
      .withWillMessage('My Will message')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
  print('EXAMPLE::Mosquitto client connecting....');
  client.connectionMessage = connMess;
  try {
    await client.connect(username, password);
  } on Exception catch (e) {
    print('EXAMPLE::client exception - $e');
    client.disconnect();
  }

  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, state is ${client.connectionStatus.state}');
    client.disconnect();
//      exit(-1);
  }

  /// Ok, lets try a subscription or two, note these may change/cease to exist on the broker
  print('topics:${topics.toString()}');

  topics.forEach((topic) => client.subscribe(topic, MqttQos.atMostOnce));

//    const String topic1 = 'ebcon/#'; // Wildcard topic
//    client.subscribe(topic1, MqttQos.atMostOnce);

  client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    final MqttPublishMessage recMess = c[0].payload;
//    print('监听获取到的数据:${recMess.payload.message.toString()}');

//    final String pt =
//        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    Utf8Decoder decode = new Utf8Decoder();
    var data = decode.convert(recMess.payload.message);
    print('data:${data}');

//    print(
//        'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload data is : ${data}');
    String topic = c[0].topic;
    String content = data;
    String val = '${topic}@${content}';
    Provide.value<MqttPublisher>(context).publicMessage(val);
  });

  client.published.listen((MqttPublishMessage message) {
//    print(
//        'EXAMPLE::Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
  });

}

//  /// The unsolicited disconnect callback
void onDisconnected() {
  print('EXAMPLE::OnDisconnected client callback - Client disconnection');

  Loading.client.connect('', '');

}

void onConnected() {
  print(
      'EXAMPLE::OnConnected client callback - Client connection was sucessful');
}

/// Pong callback
void pong() {
  print('EXAMPLE::Ping response client callback invoked');
}

/// The subscribed callback
void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

void mqttUnSubsribed() {}
