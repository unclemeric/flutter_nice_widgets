// To parse this JSON data, do
//
//     final AppUpdateInfo = AppUpdateInfoFromMap(jsonString);

import 'dart:convert';

class AppUpdateInfo {
    AppUpdateInfo({
        required this.android,
        required this.ios,
    });

    UpdateInfo android;
    UpdateInfo ios;

    factory AppUpdateInfo.fromJson(String str) => AppUpdateInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AppUpdateInfo.fromMap(Map<String, dynamic> json) => AppUpdateInfo(
        android: UpdateInfo.fromMap(json["android"]),
        ios: UpdateInfo.fromMap(json["ios"]),
    );

    Map<String, dynamic> toMap() => {
        "android": android.toMap(),
        "ios": ios.toMap(),
    };
}

class UpdateInfo {
    UpdateInfo({
        required this.version,
        required this.buildNumber,
        required this.link,
        required this.contents,
        required this.force,
    });

    String version;
    int buildNumber;
    String link;
    List<String> contents;
    bool force;

    factory UpdateInfo.fromJson(String str) => UpdateInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UpdateInfo.fromMap(Map<String, dynamic> json) => UpdateInfo(
        version: json["version"] == null ? null : json["version"],
        buildNumber: json["buildNumber"] == null ? null : json["buildNumber"],
        link: json["link"] == null ? null : json["link"],
        contents: List<String>.from(json["contents"].map((x) => x)),
        force: json["force"] == null ? null : json["force"],
    );

    Map<String, dynamic> toMap() => {
        "version": version,
        "buildNumber": buildNumber,
        "link": link,
        "contents": List<dynamic>.from(contents.map((x) => x)),
        "force": force,
    };
}
