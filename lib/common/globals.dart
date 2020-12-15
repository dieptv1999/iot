class Globals {
  static final Globals _singleton = Globals._internal();
  String accessToken;

  factory Globals() {
    return _singleton;
  }

  Globals._internal();
}
