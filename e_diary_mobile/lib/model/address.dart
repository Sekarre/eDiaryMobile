import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String street;
  String city;
  String state;
  String zip;
  String phoneNumber;

  Address(this.street, this.city, this.state, this.zip, this.phoneNumber);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() {
    return 'Address{street: $street, city: $city, state: $state, zip: $zip, phoneNumber: $phoneNumber}';
  }
}