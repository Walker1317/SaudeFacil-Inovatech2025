// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmergencyRequest {

  String id;
  String address;
  double lat;
  double lgn;
  DateTime date;

  EmergencyRequest({
    required this.id,
    required this.address,
    required this.lat,
    required this.lgn,
    required this.date,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'lat': lat,
      'lgn': lgn,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory EmergencyRequest.fromMap(Map<String, dynamic> map) {
    return EmergencyRequest(
      id: map['id'] as String,
      address: map['address'] as String,
      lat: map['lat'] as double,
      lgn: map['lgn'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmergencyRequest.fromJson(String source) => EmergencyRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
