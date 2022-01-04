
class ShiftDataList {
  final String position;
  final String dtstart;
  final String dtend;
  final String timezone;
  final int unpaidBreakDuration;
  final String locationName;
  final int slots;
  final String attire;
  final String additionalInstructions;
  final List<String> additionalRequirements;
  final List<Contact> contacts;
  final List<Match> matched;
  final Location location;
  final int availableSlots;
  final int basePrice;
  final String currency;

  const ShiftDataList({
    required this.position,
    required this.dtstart,
    required this.dtend,
    required this.timezone,
    required this.unpaidBreakDuration,
    required this.locationName,
    required this.slots,
    required this.attire,
    required this.additionalInstructions,
    required this.additionalRequirements,
    required this.contacts,
    required this.matched,
    required this.location,
    required this.availableSlots,
    required this.basePrice,
    required this.currency
  });

  factory ShiftDataList.fromJson(Map<String, dynamic> json) {

    final contactsData = json['contacts'] as List<dynamic>;
    final contactsList = contactsData.map((contactsData) => Contact.fromJson(contactsData)).toList();

    final matchedData = json['matched'] as List<dynamic>;
    final matchedList = matchedData.map((matchedData) => Match.fromJson(matchedData)).toList();

    final location = json['location'] as dynamic;
    final locationData = Location.fromJson(location);

    return ShiftDataList(
        position: json['position'] as String,
        dtstart: json['dtstart'] as String,
        dtend: json['dtend'] as String,
        timezone: json['timezone'] as String,
        unpaidBreakDuration: json['unpaidBreakDuration'] as int,
        locationName: json['locationName'] as String,
        slots: json['slots'] as int,
        attire: json['attire'] as String,
        additionalInstructions: json['additionalInstructions'] as String,
        additionalRequirements: new List<String>.from(json['additionalRequirements']),
        contacts: contactsList,
        matched: matchedList,
        location: locationData,
        availableSlots: json['availableSlots'] as int,
        basePrice: json['basePrice'] as int,
        currency: json['currency'] as String
    );
  }
}


class Contact {

  const Contact({ required this.name, required this.phone, required this.createdAt});

  final String name;
  final String phone;
  final String createdAt;

  factory Contact.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final phone = data['phone'] as String;
    final createdAt = data['createdAt'] as String;

    return Contact(name: name, phone: phone, createdAt: createdAt);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'createdAt': createdAt
    };
  }
}

class Match {

  const Match({ required this.pro,});

  final Pro pro;

  factory Match.fromJson(Map<String, dynamic> data) {
    final pro = data['pro'] as dynamic;
    final proData = Pro.fromJson(pro);

    return Match(pro: proData);
  }

  Map<String, dynamic> toJson() {
    return {
      'pro': pro,
    };
  }
}

class Pro {

  const Pro({ required this.id, required this.avatar, required this.firstName, required this.lastName});

  final String id;
  final String avatar;
  final String firstName;
  final String lastName;


  factory Pro.fromJson(Map<String, dynamic> data) {

    final id = data['id'] as String;

    final avatar = data['avatar'] as String?;
    final finalavatar = avatar != null ? avatar : "";

    final firstName = data['firstName'] as String;
    final lastName = data['lastName'] as String;

    return Pro(id: id, avatar: finalavatar, firstName: firstName, lastName: lastName);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'firstName': firstName,
      'lastName': lastName
    };
  }
}

class Location {

  const Location({ required this.name, required this.address, required this.timezone});

  final String name;
  final String address;
  final String timezone;

  factory Location.fromJson(Map<String, dynamic> data) {

    final name = data['name'] as String;
    final address = data['address'] as String;
    final timezone = data['timezone'] as String;

    return Location(name: name, address: address, timezone: timezone);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'timezone': timezone,
    };
  }
}