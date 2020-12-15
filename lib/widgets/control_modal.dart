import 'package:flutter/material.dart';
import 'package:iot/services/data.dart';
import 'package:iot/common/observable.dart' as observable;

class ControlModal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ControlModalState();
  }
}

class ControlModalState extends State<ControlModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Thiết bị',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(

                  ),
                  color: Colors.teal[100],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Heed not the rabble'),
                  color: Colors.teal[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Sound of screams but the'),
                  color: Colors.teal[300],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Revolution is coming...'),
                  color: Colors.teal[500],
                ),
                Container(),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.88,
            child: RaisedButton(
              onPressed: () {},
              child: Text('Tắt tất cả các thiết bị'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    DataService().sendStateDevice(new observable.Notification(
      temp: '32',
      waterTemp: '40',
      ph: '45',
      ec: '21',
      light: '356',
    ));
    super.initState();
  }
}
