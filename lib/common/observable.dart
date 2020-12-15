import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Notification {
  String temp;
  String light;
  String waterTemp;
  String ph;
  String ec;

  Notification({this.temp, this.light, this.waterTemp, this.ph, this.ec});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      temp: json['temp'],
      light: json['light'],
      ec: json['ec'],
      ph: json['ph'],
      waterTemp: json['waterTemp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'light': light,
        'ec': ec,
        'ph': ph,
        'waterTemp': waterTemp,
      };
}

class Observable {
  Sink<List<Notification>> onMessChanged;
  Stream<List<Notification>> state;

  static final Observable _singleton = Observable._internal();

  factory Observable() {
    return _singleton;
  }

  Observable._internal() {
    final onMessChanged = PublishSubject<List<Notification>>();

    state = onMessChanged
        .distinct()
        .debounceTime(const Duration(milliseconds: 250))
        .switchMap<List<Notification>>(
            (List<Notification> term) => _search(term));
    //     .startWith();
    this.onMessChanged = onMessChanged;
    this.state = state;
  }

  static Stream<List<Notification>> _search(List<Notification> term) async* {
    yield term;
  }

  void dispose() {
    onMessChanged.close();
  }
}
