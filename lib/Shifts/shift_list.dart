import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:pattern_test_app/ModalClass/shift_data_list.dart';
import '../ShiftDetails/shift_details.dart';

class ShiftList extends StatefulWidget {
  final List<ShiftDataList> shiftList;

  const ShiftList({Key? key, required this.shiftList}) : super(key: key);

  @override
  _ShiftListState createState() {
    return _ShiftListState();
  }
}

class _ShiftListState extends State<ShiftList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shifts'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: SafeArea(
          child: _groupList(widget.shiftList),
        ),
      ),
    );
  }
}

Widget _groupList(List<ShiftDataList> shiftList) {
  return GroupedListView<dynamic, String>(
      elements: shiftList,
      groupBy: (element) {
        final shift = element as ShiftDataList;
        return shift.dtend.substring(0, 10);
      },
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) {
        final shift1 = item1 as ShiftDataList;
        final shift2 = item2 as ShiftDataList;

        return shift2.dtstart.compareTo(shift1.dtstart);
      },
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (String value) {
        var outputDate = getFormattedDate('yyyy-MM-dd', value, 'EEEE, MMMM d');
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
          child: Text(
            outputDate.toUpperCase(),
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade600),
          ),
        );
      },
      itemBuilder: (context, shift) {
        final shiftDetail = shift as ShiftDataList;

        String title =
            getTitle(shiftDetail.matched.length, shiftDetail.position);

        var outputDate1 = getFormattedDate(
            'hh:mm:ss', shiftDetail.dtstart.substring(11, 19), 'hh:mm a');
        var outputDate2 = getFormattedDate(
            'hh:mm:ss', shiftDetail.dtend.substring(11, 19), 'hh:mm a');

        String positionsFilledOpen;

        // Check if all positions are filled or still open
        if (shiftDetail.slots == shiftDetail.matched.length) {
          positionsFilledOpen = shiftDetail.slots.toString() + ' Filled';
        } else {
          positionsFilledOpen = shiftDetail.slots.toString() +
              ' Filled' +
              ' ᐧ ' +
              shiftDetail.availableSlots.toString() +
              ' Open';
        }

        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ShiftDetails(shiftDetail);
                },
              ),
            );
          },
          contentPadding: EdgeInsets.fromLTRB(20, 5, 10, 10),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.indigo,
                radius: 20,
                child: Icon(
                  Icons.people_rounded,
                  color: Colors.white,
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            '$outputDate1 - $outputDate2',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey.shade600),
                          )),
                      Text(
                        positionsFilledOpen,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey.shade600),
                      )
                    ],
                  )),
              Spacer(
                flex: 1,
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        );
      });
}

String getTitle(int length, String fromTitleString) {
  String title = length.toString() +
      ' ' +
      fromTitleString
          .replaceAll('-', ' ')
          .replaceFirst(fromTitleString[0], fromTitleString[0].toUpperCase());
  if (title.endsWith('line')) {
    title += ' workers';
  } else if (title.endsWith('r')) {
    title += 's';
  }

  return title;
}
