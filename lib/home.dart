import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot/services/data.dart';
import 'package:iot/widgets/InfomationCart.dart';
import 'package:iot/common/observable.dart' as observable;
import 'package:iot/widgets/control_modal.dart';
import 'package:iot/widgets/page.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "HomeScreen";

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen> {
  int _curr = 0;
  PageController controller=PageController();
  List<Widget> _list=<Widget>[
    new Center(child:new Pages(type: 1,)),
    new Center(child:new Pages(type: 2,)),
    new Center(child:new Pages(type: 3,)),
    new Center(child:new Pages(type: 4,))
  ];

  _showDashBoard(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ControlModal(),
    );
  }

  @override
  void initState() {
    DataService().onListenServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var init = new observable.Notification(
        temp: '32', light: '320', waterTemp: '312', ph: '33', ec: '34');
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Text('Trang chủ'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 90,
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: StreamBuilder(
                stream: observable.Observable().state,
                initialData: [
                  init,
                ],
                builder: (ctx, snap) {
                  if (snap.hasData) {
                    observable.Notification data = snap.data[0];
                    print(data);
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InfoCart(
                            value: data.temp,
                            icon: Icon(FontAwesomeIcons.temperatureHigh),
                            type: 'Nhiệt độ',
                          ),
                          InfoCart(
                            value: data.light,
                            icon: Icon(FontAwesomeIcons.solidLightbulb),
                            type: 'Ánh sáng',
                          ),
                          InfoCart(
                            value: data.waterTemp,
                            icon: Icon(FontAwesomeIcons.tint),
                            type: 'Nhiệt độ nước',
                          ),
                          InfoCart(
                            value: data.ph,
                            icon: Image.asset('assets/ph.png'),
                            type: 'PH',
                          ),
                          InfoCart(
                            value: data.ec,
                            icon: Image.asset('assets/ec.png'),
                            type: 'EC',
                          ),
                        ],
                      ),
                    );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                },
              ),
            ),
          ),
          Expanded(
            child: PageView(
              children: _list,
              scrollDirection: Axis.horizontal,

              // reverse: true,
              // physics: BouncingScrollPhysics(),
              controller: controller,
              onPageChanged: (num) {
                setState(() {
                  _curr = num;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.tachometerAlt),
                  onPressed: () {
                    _showDashBoard(context);
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.signOutAlt),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
