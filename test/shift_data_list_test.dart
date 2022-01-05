
import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_test_app/ModalClass/shift_data_list.dart';

import 'Mock Classes/mock_shift_data_list.dart';

void main () {

  ShiftDataList shiftDataList = MockShiftDataList();

  test('test shift Data - position', () {
    expect(shiftDataList.position, 'position');
  });

  test('test shift Data - dtstart', () {
    expect(shiftDataList.dtstart, '2021-11-09T16:00:00.000Z');
  });

  test('test shift Data - dtend', () {
    expect(shiftDataList.dtend, '2021-11-10T00:30:00.000Z');
  });

  test('test shift Data - timezone', () {
    expect(shiftDataList.timezone, 'timezone');
  });

  test('test shift Data - unpaidBreakDuration', () {
    expect(shiftDataList.unpaidBreakDuration, 0);
  });

  test('test shift Data - locationName', () {
    expect(shiftDataList.locationName, 'locationName');
  });

  test('test shift Data - slots', () {
    expect(shiftDataList.slots, 0);
  });

  test('test shift Data - attire', () {
    expect(shiftDataList.attire, 'attire');
  });

  test('test shift Data - additionalInstructions', () {
    expect(shiftDataList.additionalInstructions, 'additionalInstructions');
  });

  test('test shift Data - additionalRequirements', () {
    expect(shiftDataList.additionalRequirements, ['additionalRequirements']);
  });

  test('test shift Data - contacts', () {

    // Mock Contact Length should be 1
    expect(shiftDataList.contacts.length, 1);


    Contact mockContact = shiftDataList.contacts.first;

    expect(mockContact.name, 'name');
    expect(mockContact.phone, 'phone');
    expect(mockContact.createdAt, 'createdAt');
  });

  test('test shift Data - matched', ()
  {
    // Mock Contact Length should be 1
    expect(shiftDataList.matched.length, 1);

    Match mockMatch = shiftDataList.matched.first;

    //Should not be null
    expect(mockMatch, isNotNull);

    Pro mockPro = mockMatch.pro;
    //Should not be null
    expect(mockPro, isNotNull);

    expect(mockPro.id, 'id');
    expect(mockPro.avatar, '');
    expect(mockPro.firstName, 'firstName');
    expect(mockPro.lastName, 'lastName');

  });

  test('test shift Data - location', () {

    Location mockLocation = shiftDataList.location;
    //Should not be null
    expect(mockLocation, isNotNull);

    expect(mockLocation.name, 'name');
    expect(mockLocation.address, 'address');
    expect(mockLocation.timezone, 'timezone');

  });

  test('test shift Data - availableSlots', () {
    expect(shiftDataList.availableSlots, 0);
  });

  test('test shift Data - basePrice', () {
    expect(shiftDataList.basePrice, 0);
  });

  test('test shift Data - currency', () {
    expect(shiftDataList.currency, 'currency');
  });
}