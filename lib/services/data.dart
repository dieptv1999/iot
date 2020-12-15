import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:iot/common/observable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../common/globals.dart' as globals;
import 'contants.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  onListenServer() async {
    IO.Socket socket = IO.io(Contants.IP_LIVE + ':' + Contants.PORT);
    socket.onConnect((_) {
      socket.emit(
          'topic', {'message': 'Farm', 'token': globals.Globals().accessToken});
    });
    socket.on('Farmdata', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
  }

  sendStateDevice(Notification noti) async {
    final privateKey =
        await parseKeyFromFile<RSAPrivateKey>('assets/certs/privateKey.pem');
    final publicKey =
        await parseKeyFromFile<RSAPublicKey>('assets/certs/publicKey.pem');
    final signer = Signer(RSASigner(RSASignDigest.SHA256,
        publicKey: publicKey, privateKey: privateKey));
    print(signer.sign(jsonEncode(noti)).base64);
    print(jsonEncode(noti));
    Response<dynamic> resp;
    Dio dio = new Dio();
    print(Contants.IP_LIVE + ':' + Contants.PORT + "/api/device/control");
    dio.options.headers['auth-token']=globals.Globals().accessToken;
    resp = await dio.post(
      Contants.IP_LIVE + ':' + Contants.PORT + "/api/device/control",
      data: {
        "data": jsonEncode(noti),
        "signature": signer.sign(jsonEncode(noti)).base64,
      },
    );
    if (resp.statusCode == 200) {
      print("success");
    } else {
      print('fail');
    }
  }
}
