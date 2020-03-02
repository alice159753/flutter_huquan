import 'package:flutter/services.dart';

class LogUtils {
  static const perform = const MethodChannel("android_log");

  /**
   * android中有5种级别的log，分别为：
   * 1.v(verbose)：任何信息都会输出
   * 2.i(info)：输出提示信息
   * 3.e(error)：输出错误信息
   * 4.d(debug)：输出调试信息
   * 5.w(warning)：输出警告信息
   **/

  static void v(String tag, String message) {
    perform.invokeMethod('logV', {'tag': tag, 'msg': message});
  }

  static void d(String tag, String message) {
    perform.invokeMethod('logD', {'tag': tag, 'msg': message});
  }

  static void i(String tag, String message) {
    perform.invokeMethod('logI', {'tag': tag, 'msg': message});
  }

  static void w(String tag, String message) {
    perform.invokeMethod('logW', {'tag': tag, 'msg': message});
  }

  static void e(String tag, String message) {
    perform.invokeMethod('logE', {'tag': tag, 'msg': message});
  }
}