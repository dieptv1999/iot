import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contants.dart';
import '../common/globals.dart' as globals;

class AuthService {
  Future<bool> login(uname, pwd) async {
    var bytes1 = utf8.encode(uname + pwd);
    var digest1 = sha256.convert(bytes1);
    Response<dynamic> resp;
    Dio dio = new Dio();
    print(Contants.IP_LIVE + ':' + Contants.PORT + "/api/users/login");
    resp = await dio
        .post(Contants.IP_LIVE + ':' + Contants.PORT + "/api/users/login", data: {
      "email": uname,
      "password": digest1.toString(),
    });
    if (resp.statusCode == 200) {
      globals.Globals().accessToken = resp.data['data']['token'];
      return true;
    }
    return false;
  }
}
