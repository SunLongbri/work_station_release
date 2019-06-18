import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'router_handler.dart';

class Routes {
  static String root = '/';
  static String loginPage = '/login_page';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('没有发现这个路由方法 ... ');
    });
    router.define(loginPage, handler: loginHandler);
  }
}
