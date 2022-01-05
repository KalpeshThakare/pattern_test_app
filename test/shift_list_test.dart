import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_test_app/ModalClass/shift_data_list.dart';
import 'package:pattern_test_app/ShiftList/shift_list.dart';
import 'Mock Classes/mock_shift_data_list.dart';


void main () {

  testWidgets('Shift list test', (WidgetTester tester) async {

    List<ShiftDataList> shiftDataList = [MockShiftDataList()];

    // Build the app and trigger a frame.
    await tester.pumpWidget(ShiftList(shiftList: shiftDataList));


    expect(find.text('ShiftList'), findsOneWidget);


    // Verify that after passing mock screen has 1 widget.

    expect(find.byIcon(Icons.people_rounded), findsNWidgets(1));

    expect(find.text('1 Position'), findsNWidgets(1));
    expect(find.text('04:00 PM - 12:30 AM'), findsNWidgets(1));
    expect(find.text('0 Filled ᐧ 0 Open'), findsNWidgets(1));

    expect(find.byIcon(Icons.arrow_forward_ios), findsNWidgets(1));

    // Tap the arrow icon.
    await tester.tap(find.byIcon(Icons.arrow_forward_ios));
    await tester.pump();

  });

}