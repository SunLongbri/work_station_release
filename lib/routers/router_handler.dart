import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:work_station/pages/login_page.dart';

Handler loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LoginPage();
    });
