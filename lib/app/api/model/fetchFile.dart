// ignore: file_names
class FecthData {
  Result? result;

  FecthData({this.result});

  FecthData.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  EndDeviceIds? endDeviceIds;
  String? receivedAt;
  UplinkMessage? uplinkMessage;

  Result({this.endDeviceIds, this.receivedAt, this.uplinkMessage});

  Result.fromJson(Map<String, dynamic> json) {
    endDeviceIds = json['end_device_ids'] != null
        ? EndDeviceIds.fromJson(json['end_device_ids'])
        : null;
    receivedAt = json['received_at'];
    uplinkMessage = json['uplink_message'] != null
        ? UplinkMessage.fromJson(json['uplink_message'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (endDeviceIds != null) {
      data['end_device_ids'] = endDeviceIds!.toJson();
    }
    data['received_at'] = receivedAt;
    if (uplinkMessage != null) {
      data['uplink_message'] = uplinkMessage!.toJson();
    }
    return data;
  }
}

class EndDeviceIds {
  String? deviceId;

  EndDeviceIds({this.deviceId});

  EndDeviceIds.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device_id'] = deviceId;
    return data;
  }
}

class UplinkMessage {
  DecodedPayload? decodedPayload;
  String? receivedAt;

  UplinkMessage({this.decodedPayload, this.receivedAt});

  UplinkMessage.fromJson(Map<String, dynamic> json) {
    decodedPayload = json['decoded_payload'] != null
        ? DecodedPayload.fromJson(json['decoded_payload'])
        : null;
    receivedAt = json['received_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (decodedPayload != null) {
      data['decoded_payload'] = decodedPayload!.toJson();
    }
    data['received_at'] = receivedAt;
    return data;
  }
}

class DecodedPayload {
  String? data;

  DecodedPayload({this.data});

  DecodedPayload.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    return data;
  }
}
