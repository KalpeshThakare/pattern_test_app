import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_test_app/Networking/Networking.dart';


Future<void> main () async {

  Networking network = Networking();

  test('test networking shift data list success result for correct url', () {
    var shiftList = network.getData(shiftList_url);
    expect(shiftList, isNotNull);
  });

  test('test networking shift data list failure result for wrong url', () {
    var shiftList = network.getData('https://www.google.com');
    expect(shiftList, isNotNull);
  });

}