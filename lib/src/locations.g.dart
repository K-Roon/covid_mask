part of 'locations.dart';

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return LatLng(
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Pharmacy _$PharmacyFromJson(Map<String, dynamic> json) {
  return Pharmacy(
    code: json['code'] as String,
    name: json['name'] as String,
    addr: json['addr'] as String,
    type: json['type'] as String,
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PharmacyToJson(Pharmacy instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'addr': instance.addr,
      'type': instance.type,
      'lat': instance.lat,
      'lng': instance.lng,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
    pharmacys: (json['pharmacys'] as List)
        ?.map((e) =>
            e == null ? null : Pharmacy.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'pharmacys': instance.pharmacys,
    };
