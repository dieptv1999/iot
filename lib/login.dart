import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'services/auth.dart';
import 'widgets/home.dart';
import 'widgets/login_cart.dart';
import 'widgets/social_icons.dart';

class LoginView extends StatefulWidget {
  static String routeName = 'login';

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginView> {
  IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
  IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
  IconData googlePlus = IconData(0xe902, fontFamily: "CustomIcons");
  IconData linkedin = IconData(0xe903, fontFamily: "CustomIcons");

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSelected = true;

  RegExp exp = new RegExp('');
  RegExp expPass = new RegExp('[A-Za-z0-9]{6,19}\$');

  final snackBar = SnackBar(
    content: Text('Tên đăng nhập hoặc mật khẩu sai!'),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  );

  TextEditingController _usernameController;
  TextEditingController _passwordController;

  void _loginUser(String username, String password, context) async {
    // thực hiện đăng nhập
    if (!exp.hasMatch(username) || !expPass.hasMatch(password)) {
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      print('abc');
      bool resp = await AuthService().login(username, password);
      if (resp) {
        SharedPreferences storage = await SharedPreferences.getInstance();
        storage.setString('email', username);
        storage.setString('pwd', password);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, ModalRoute.withName("/"));
      } else
        _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(100),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  _fillRemember() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("email")) {
      _usernameController.text = prefs.getString("email");
      _passwordController.text = prefs.getString("pwd");
    }
  }

  @override
  void initState() {
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _fillRemember();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/image_01.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(child: Image.asset("assets/image_02.png"))
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/logo2.png",
                        width: ScreenUtil().setWidth(110),
                        height: ScreenUtil().setHeight(110),
                      ),
                      Text("IOT",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil().setSp(46),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(180),
                  ),
                  FormCard(_usernameController, _passwordController),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("Nhớ đăng nhập",
                              style: TextStyle(
                                  fontSize: 14, fontFamily: "Poppins-Medium"))
                        ],
                      ),
                      InkWell(
                        child: Container(
                          width: ScreenUtil().setWidth(300),
                          height: ScreenUtil().setHeight(95),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _loginUser(
                                  _usernameController.text,
                                  _passwordController.text,
                                  context,
                                );
                              },
                              child: Center(
                                child: Text("Đăng nhập",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Liên hệ chúng tôi",
                          style: TextStyle(
                              fontSize: 15.0, fontFamily: "Poppins-Medium")),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(35),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        colors: [
                          Color(0xFF102397),
                          Color(0xFF187adf),
                          Color(0xFF00eaf8),
                        ],
                        iconData: facebook,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFFff4f38),
                          Color(0xFFff355d),
                        ],
                        iconData: googlePlus,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF17ead9),
                          Color(0xFF6078ea),
                        ],
                        iconData: twitter,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF00c6fb),
                          Color(0xFF005bea),
                        ],
                        iconData: linkedin,
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
