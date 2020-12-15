import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCard extends StatelessWidget {
  FormCard(
    this._usernameController,
    this._passwordController,
  );

  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
//      height: ScreenUtil().setHeight(500),
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Đăng nhập",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    fontFamily: 'Montserrat',
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
//            Text("Username",
//                style: TextStyle(
//                    fontFamily: "Poppins-Medium",
//                    fontSize: ScreenUtil().setSp(26))),
            TextField(
              controller: _usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
//            Text("PassWord",
//                style: TextStyle(
//                    fontFamily: "Poppins-Medium",
//                    fontSize: ScreenUtil().setSp(26))),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(40),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
