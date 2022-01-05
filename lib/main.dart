import 'package:flutter/material.dart';
import 'package:pattern_test_app/Networking/Networking.dart';
import 'Networking/Networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'ShiftList/shift_list.dart';

void main() {
  runApp(MaterialApp(
    home: Loading(),
  ));
}

class Loading extends StatefulWidget {

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.indigo,
            size: 100,
          ),
        ),
      );
  }

  void getData() async {
    Networking network = Networking();
    var shiftList = await network.getData(shiftList_url);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ShiftList(shiftList: shiftList,);
    }));
  }

}
