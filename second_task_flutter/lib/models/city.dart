import 'package:json_annotation/json_annotation.dart';
part 'city.g.dart';

@JsonSerializable()
class City {
  int id;
  String name;
  String postcode;
  String emblem;

  City({this.id, this.name, this.postcode, this.emblem});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
