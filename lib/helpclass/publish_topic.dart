import 'package:mqtt_client/mqtt_client.dart';
import 'package:work_station/design/loading.dart';

//发布topic的content
class PublishTopic {
  final String topic;
  final String content;

  PublishTopic.pubisher(this.topic, this.content);

  void send() {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(content);
    Loading.client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload);
    print('发布 ${topic} ,内容为: ${content} 完毕 ... ');
  }
}
