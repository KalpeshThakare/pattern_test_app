
import 'package:pattern_test_app/ModalClass/shift_data_list.dart';

class MockShiftDataList extends ShiftDataList {

  MockShiftDataList() : super(
      position: 'position',
      dtstart: '2021-11-09T16:00:00.000Z',
      dtend: '2021-11-10T00:30:00.000Z',
      timezone: 'timezone',
      unpaidBreakDuration: 0,
      locationName: 'locationName',
      slots: 0,
      attire: 'attire',
      additionalInstructions: 'additionalInstructions',
      additionalRequirements: ['additionalRequirements'],
      contacts: [Contact(name: 'name', phone: 'phone', createdAt: 'createdAt')],
      matched: [Match(pro: Pro(id: 'id', avatar: '', firstName: 'firstName', lastName: 'lastName')),],
      location: Location(name: 'name', address: 'address', timezone: 'timezone'),
      availableSlots: 0,
      basePrice: 0,
      currency: 'currency'
  );
}