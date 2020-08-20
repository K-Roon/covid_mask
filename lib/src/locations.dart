import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import "package:json_annotation/json_annotation.dart";

part 'locations.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    this.lat,
    this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class Pharmacy {
  Pharmacy({
    this.code,
    this.name,
    this.addr,
    this.type,
    this.lat,
    this.lng,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) =>
      _$PharmacyFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyToJson(this);

  final String code;
  final String name;
  final String addr;
  final String type;
  final double lat;
  final double lng;
}

@JsonSerializable()
class Locations {
  Locations({this.pharmacys});

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Pharmacy> pharmacys;
}

Future<Locations> getPharmacy() async {
  // 약국 위치를 알아내기 위한 URL(최대 500페이지)
  const pharmacyLocationsURL =
      'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/stores/json?page=1&perPage=500';
  print(pharmacyLocationsURL);

  // URL 받아내어 약국의 위치를 알아냄
  final response = await http.get(pharmacyLocationsURL);
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(pharmacyLocationsURL));
  }
}
