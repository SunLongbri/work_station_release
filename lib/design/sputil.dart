import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';
import 'dart:async';
import 'dart:convert';

// Shared Preference 工具类
class SpUtil {
  static SpUtil _singleton;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // 保持本地实例直到完全初始化。
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
  }

  SpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> putObject(String key, Object value) {
    _isNull();
    return _prefs.setString(key, value == null ? "" : json.encode(value));
  }

  static Map getObject(String key) {
    _isNull();
    String _data = _prefs.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  static Future<bool> putObjectList(String key, List<Object> list) {
    _isNull();
    List<String> _dataList = list?.map((value) {
      return json.encode(value);
    })?.toList();
    return _prefs.setStringList(key, _dataList);
  }

  static List<Map> getObjectList(String key) {
    _isNull();
    List<String> dataList = _prefs.getStringList(key);
    return dataList?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }

  static Future<bool> putString(String key, String value) {
    _isNull();
    return _prefs.setString(key, value);
  }

  static String getString(String key, {String defValue: ''}) {
    _isNull();
    return _prefs.getString(key) ?? defValue;
  }



  static void _isNull() {
    if (_prefs == null) {
      return null;
    }
  }
}
