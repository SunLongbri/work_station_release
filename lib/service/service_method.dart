import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/helpclass/Utils.dart';
import 'package:work_station/pages/net_error_page.dart';

import 'service_url.dart';

//用户登陆,不带token
Future request(context, url, formData) async {
  Response response;
  try {
    print('开始获取数据  ......   ');
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/json');
    dio.options.connectTimeout = 15000;
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print("else响应码为!");
      throw Exception('后端接口异常!');
    }
  } catch (e) {
    throw Exception('服务器端异常:${e}');
  }
}

//工位请求,订单请求，预约记录，用户登出，带token,获取灯控人是否离开
Future seatRequest(context, url, {formData}) async {
  Response response;
  String token = '';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('counter');
  try {
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/json');
    dio.options.headers["Authorization"] = 'token_${token.toString()}';
    dio.options.connectTimeout = 15000;
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('访问异常:${response.statusCode}');
    }
  } catch (e) {
    if (Utils.errorNumber == 0) {
      print('不再进入网络错误页面:${Utils.errorNumber}');
      Utils.errorNumber++;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NetErrorPage()));
    }
    throw Exception('服务器端异常：${e}!');
  }
}

//get获取用户信息
Future getUserInfo(context, url, token, {formData}) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = 'token_${token.toString()}';
    dio.options.contentType = ContentType.parse('application/json');
    dio.options.connectTimeout = 15000;
    if (formData == null) {
      response = await dio.get(servicePath[url]);
    } else {
      response = await dio.get(servicePath[url]);
    }
    if (response.statusCode == 200) {
//      print('返回的数据为：${response.data}');
      return response.data;
    } else {
      print('使用Get方法获取服务器异常:响应码为:${response.statusCode}');
    }
  } catch (e) {
    if (Utils.errorNumber == 0) {
      Utils.errorNumber++;
      print('不再进入网络错误页面:${Utils.errorNumber}');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NetErrorPage()));
    }
    print('获取用户信息,当前异常为:${e.toString()}');
    return print(e);
  }
}

//不带参数的get请求
Future getRequest(String url, String sessionId) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.headers['sessionId'] = sessionId;
    dio.options.contentType = ContentType.parse('application/json');
    dio.options.connectTimeout = 15000;
    response = await dio.get(servicePath[url]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print('不带参数的get请求 异常:响应码:${response.statusCode}');
    }
  } catch (e) {
    print('不带参数的get请求抛出异常，异常为:${e}');
  }
}

//带参数的post请求
Future postRequest(String url, formData, String sessionId) async {
  print('postRequest:Url --->  ${servicePath[url]}  formData ---->  ${formData}  sessionId ----> ${sessionId}');
  try {
    Response response;
    Dio dio = Dio();
    dio.options.headers['sessionId'] = sessionId;

    dio.options.contentType = ContentType.parse('application/json');
    dio.options.connectTimeout = 15000;
    response = await dio.post(servicePath[url],data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print('带参数的post请求异常:响应码为:${response.statusCode}');
    }
  } catch (e) {
    print('带参数的post请求抛出异常，异常为:${e}');
  }
}
