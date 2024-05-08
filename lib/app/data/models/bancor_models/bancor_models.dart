// To parse this JSON data, do
//
//     final bancorApi = bancorApiFromJson(jsonString);

import 'dart:convert';

// List<BancorApi> bancorApiFromJson(String str) => List<BancorApi>.from(json.decode(str).map((x) => BancorApi.fromJson(x)));

// String bancorApiToJson(List<BancorApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BancorApiModels {
    final int? id;
    final String? nama;
    final String? alamat;
    final String? noHp;
    final String? gambarJasaBancor;
    final double? longitude;
    final double? latitude;
    final String? harga;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    BancorApiModels({
        this.id,
        this.nama,
        this.alamat,
        this.noHp,
        this.gambarJasaBancor,
        this.longitude,
        this.latitude,
        this.harga,
        this.createdAt,
        this.updatedAt,
    });

    factory BancorApiModels.fromJson(Map<String, dynamic> json) => BancorApiModels(
        id: json["id"],
        nama: json["nama"],
        alamat: json["alamat"],
        noHp: json["noHp"],
        gambarJasaBancor: json["gambarJasaBancor"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        harga: json["harga"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alamat": alamat,
        "noHp": noHp,
        "gambarJasaBancor": gambarJasaBancor,
        "longitude": longitude,
        "latitude": latitude,
        "harga": harga,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
