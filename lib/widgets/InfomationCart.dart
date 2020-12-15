import 'package:flutter/material.dart';

class InfoCart extends StatelessWidget {
  final String value;
  final String type;
  final Widget icon;

  const InfoCart({Key key, this.value, this.type, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                padding: EdgeInsets.only(right: 4),
                child: icon,
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 19,
                ),
              ),
            ],
          ),
          Text(
            type,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
