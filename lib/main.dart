import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provide/provide.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/splash_page.dart';
import 'package:work_station/provide/mqtt_message.dart';
import 'package:work_station/routers/application.dart';

import './pages/login_page.dart';
import 'design/loading.dart';
import 'routers/routes.dart';

void main() {
  var mqttPulisher = MqttPublisher();
  var providers = Providers();

  providers..provide(Provider<MqttPublisher>.value(mqttPulisher));

  initializeDateFormatting()
      .then((_) => runApp(ProviderNode(child: MyApp(), providers: providers)));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Loading.ctx = context;
    //初始化
    final router = Router();
    //配置
    Routes.configureRoutes(router);
    //静态化
    Application.router = router;
    return MaterialApp(
      title: 'work_station',
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) =>
            LoginPage(title: 'Flutter Demo Home Page'),
        '/IndexPage': (BuildContext context) => IndexPage(),
      },
    );
  }
}
