import 'dart:convert';
import 'dart:typed_data';

import 'package:azlistview/azlistview.dart';

class ContactInfo extends ISuspensionBean {
  String name;
  String? phone;
  Uint8List? avatar;

  String? tagIndex;
  String? namePinyin;
  String? id;
  String? firstletter;

  ContactInfo({
    required this.name,
    this.tagIndex,
    this.phone,
    this.avatar,
    this.namePinyin,
    this.id,
    this.firstletter,
  });

  ContactInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        avatar = json['avatar'],
        phone = json['phone'],
        id = json['id']?.toString(),
        firstletter = json['firstletter'];

  Map<String, dynamic> toJson() => {
//        'id': id,
        'name': name,
        'avatar': avatar,
        'phone': phone
//        'firstletter': firstletter,
//        'tagIndex': tagIndex,
//        'namePinyin': namePinyin,
//        'isShowSuspension': isShowSuspension
      };

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);
}