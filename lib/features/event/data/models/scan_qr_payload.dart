class ScanQrPayload {
  final String? token;
  final String? Latitude;
  final String? Longitude;
  const ScanQrPayload({this.token, this.Latitude, this.Longitude});
  ScanQrPayload copyWith({String? token, String? Latitude, String? Longitude}) {
    return ScanQrPayload(
        token: token ?? this.token,
        Latitude: Latitude ?? this.Latitude,
        Longitude: Longitude ?? this.Longitude);
  }

  Map<String, Object?> toJson() {
    return {'token': token, 'Latitude': Latitude, 'Longitude': Longitude};
  }

  static ScanQrPayload fromJson(Map<String, Object?> json) {
    return ScanQrPayload(
        token: json['token'] == null ? null : json['token'] as String,
        Latitude: json['Latitude'] == null ? null : json['Latitude'] as String,
        Longitude:
            json['Longitude'] == null ? null : json['Longitude'] as String);
  }

  @override
  String toString() {
    return '''ScanQrPayload(
                token:$token,
Latitude:$Latitude,
Longitude:$Longitude
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is ScanQrPayload &&
        other.runtimeType == runtimeType &&
        other.token == token &&
        other.Latitude == Latitude &&
        other.Longitude == Longitude;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, token, Latitude, Longitude);
  }
}
