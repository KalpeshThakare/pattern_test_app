import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pattern_test_app/ModalClass/shift_data_list.dart';

class Networking {

  List<ShiftDataList> finalShiftList = <ShiftDataList>[];

  Future<List<ShiftDataList>> getData() async {

    Uri url = Uri.parse('https://099f998e-8348-4d04-83b6-891462df8f52.mock.pstmn.io/shifts');

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      final parsedJson = jsonDecode(data);

      final shiftList = parsedJson['data'] as List<dynamic>;

      finalShiftList = shiftList != null
          ? shiftList.map((reviewData) => ShiftDataList.fromJson(reviewData))
          .toList()
          : <ShiftDataList>[];

      return finalShiftList;
    } else {
      print(response.statusCode);
      return <ShiftDataList>[];
    }
  }

}