import 'package:flutter/material.dart';
import 'package:pattern_test_app/ModalClass/shift_data_list.dart';
import 'package:intl/intl.dart';
import 'package:pattern_test_app/ShiftList/shift_list.dart';

class ShiftDetails extends StatelessWidget {

  final ShiftDataList shiftDetails;

  const ShiftDetails(@required this.shiftDetails);

  @override
  Widget build(BuildContext context) {

    String title = getTitle(shiftDetails.matched.length, shiftDetails.position);

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(title),
            centerTitle: true,
            backgroundColor: Colors.indigo,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Container(
                  height: 40.0,
                  child: new Tab(text: 'PROFESSIONALS'),
                ),
                Container(
                  height: 40.0,
                  child: new Tab(text: 'SHIFT'),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [_professionalsList(shiftDetails), _shiftDetails(context, shiftDetails)],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _professionalsList(ShiftDataList shiftDetails) {

  return ListView.builder(
      itemCount: shiftDetails.matched.length + 1,
      itemBuilder: (context, index) {

        // First Index to Show total nuber of Filled Positions
        if (index == 0) {
          return Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 10, 20),
              child: Text(
                shiftDetails.matched.length.toString() +' FILLED',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade700),
              ));
        }

        // Show Matched Workers
        else {

          //Get Matched Worker
          Match matched = shiftDetails.matched[index-1];

          return Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: matched.pro.avatar.isNotEmpty ? DecorationImage(
                        image: NetworkImage(
                            matched.pro.avatar),
                        fit: BoxFit.fill) : DecorationImage(image: AssetImage('images/profile.jpeg'))),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text((matched.pro.firstName + ' ' + matched.pro.lastName).replaceAll('-', ' '), style: TextStyle(fontSize: 15),))
            ],
          );
        }
      });
}

Widget _shiftDetails(BuildContext context, ShiftDataList shiftDetails) {

  var outputDate = getFormattedDate('yyyy-MM-dd', shiftDetails.dtend.substring(0,10), 'EEEE, MMMM d');

  var outputTimeFrom = getFormattedDate('hh:mm:ss', shiftDetails.dtstart.substring(11,19), 'hh:mm a');
  var outputTimeTo = getFormattedDate('hh:mm:ss', shiftDetails.dtend.substring(11,19), 'hh:mm a');

  // Created 2 List elements to have Details & Instructions
  List _elements = [
    {'section-name': 'DETAILS',
      'date': outputDate,
      'time': '$outputTimeFrom - $outputTimeTo',
      'unpaid-break': shiftDetails.unpaidBreakDuration.toString() + ' minutes',
      'rate': '\$'+(shiftDetails.basePrice/100).toString() + ' / hour',
      'location': shiftDetails.location.address},
    {'section-name': 'INSTRUCTIONS',
      'on-site-contacts': shiftDetails.contacts.first.name,
      'attire': shiftDetails.attire.replaceAll('-', ' ').replaceFirst(shiftDetails.attire[0], shiftDetails.attire[0].toUpperCase()),
      'requirements': shiftDetails.additionalRequirements,
      'attional-instructions': shiftDetails.additionalInstructions},
  ];

return SingleChildScrollView(

  child:   Column(
    children: [
      //Details
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getSectionTitle(_elements.first['section-name']),

          getDetailRow(Icons.calendar_today, 'Date', _elements.first['date']),
          getDetailRow(Icons.timelapse_outlined, 'Time', _elements.first['time']),
          getDetailRow(Icons.av_timer_outlined, 'Unpaid break', _elements.first['unpaid-break']),
          getDetailRow(Icons.attach_money, 'Rate', _elements.first['rate']),

          getMultilineDetailRow(Icons.location_on_rounded, 'Location', _elements.first['location'], (MediaQuery.of(context).size.width - 170)),

        ],
      ),
  
      //Instructions
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getSectionTitle(_elements.last['section-name']),

          getDetailRow(Icons.people_rounded, 'On-site Contacts', _elements.last['on-site-contacts']),
          getDetailRow(Icons.shopping_bag_outlined, 'Attire', _elements.last['attire']),
          getDetailRow(Icons.warning_amber_rounded, 'Requirements', _elements.last['requirements'].join("\n").replaceAll('-', ' ')),

          getMultilineDetailRow(Icons.sticky_note_2_outlined, 'Additional Instructions', _elements.last['attional-instructions'], (MediaQuery.of(context).size.width - 170)),
        ],
      )
    ],
  ),
);
}


//Format Date to convinient Time Format
String getFormattedDate(String inputDateFormat, String inputDate, String outputDateFormat) {

  String value = inputDate;
  var inputFormat = DateFormat(inputDateFormat);
  var formattedDate = inputFormat.parse(value);

  var outputFormat = DateFormat(outputDateFormat);
  var outputDate = outputFormat.format(formattedDate);

  return outputDate;
}

//Reuse same Widget for section Title
Widget getSectionTitle(String sectionTitle){
  return Padding(
    padding: EdgeInsets.fromLTRB(15, 30, 10, 20),
    child: Text(
      sectionTitle,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey.shade600),
    ),
  );
}

//Reuse Same Row Widget for all similar Rows
Row getDetailRow(IconData icon, String title, String subtitle) {
  return Row(
    children: [
      Padding(padding: EdgeInsets.fromLTRB(15, 10, 20, 15),child: Icon(icon, color: Colors.grey.shade600,)),
      Container(
          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              Padding(padding:EdgeInsets.fromLTRB(0, 5, 0, 5) ,child: Text(subtitle, style:  TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.grey.shade600),)),
            ],
          )),
    ],
  );
}

//Reuse same Row Widget to have multiline text to used media query to see it on autolayout
Row getMultilineDetailRow(IconData icon, String title, String subtitle, double width) {
  return Row(
    children: [
      Padding(padding: EdgeInsets.fromLTRB(15, 10, 20, 15),child: Icon(icon, color: Colors.grey.shade600,)),
      Container(
          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              Container(width: width, child: Padding(padding:EdgeInsets.fromLTRB(0, 5, 0, 5) ,child: Text(subtitle, maxLines: 3, style:  TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.grey.shade600),))),
            ],
          )),
    ],
  );
}