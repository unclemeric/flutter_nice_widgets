import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/model/ContactInfo.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactUtils{
  static Future<Uint8List?> getConcatAvatar(Contact contact, {bool photoHighRes = true}) async {
    await Permission.contacts.request();
    // Android only: Get thumbnail for an avatar afterwards (only necessary if `withThumbnails: false` is used)
    Uint8List? avatar = await ContactsService.getAvatar(contact,photoHighRes: photoHighRes);
    return avatar;
  }

  static Future<dynamic> addContact(Contact contact) async {
    await Permission.contacts.request();
    // Add a contact  
    // The contact must have a firstName / lastName to be successfully added  
    return await ContactsService.addContact(contact);
  }

  static Future<dynamic> deleteContact(Contact contact) async {
    await Permission.contacts.request();
    // Delete a contact
    // The contact must have a valid identifier
    return await ContactsService.deleteContact(contact);
  }

  static Future<dynamic> updateContact(Contact contact) async {
    await Permission.contacts.request();
    // Update a contact
    // The contact must have a valid identifier
    return await ContactsService.updateContact(contact);
  }

  static Future<Contact> openContactForm({bool iOSLocalizedLabels = true, bool androidLocalizedLabels = true}) async {
    await Permission.contacts.request();
    // Usage of the native device form for creating a Contact
    // Throws a error if the Form could not be open or the Operation is canceled by the User
    return await ContactsService.openContactForm(iOSLocalizedLabels:iOSLocalizedLabels,androidLocalizedLabels: androidLocalizedLabels);
  }
  static Future<Contact> openExistingContact(Contact contact, {bool iOSLocalizedLabels = true, bool androidLocalizedLabels = true}) async{
    await Permission.contacts.request();
    // Usage of the native device form for editing a Contact
    // The contact must have a valid identifier
    // Throws a error if the Form could not be open or the Operation is canceled by the User
    return await ContactsService.openExistingContact(contact, iOSLocalizedLabels: iOSLocalizedLabels,androidLocalizedLabels: androidLocalizedLabels);
  }
  static Future<Iterable<Contact>> getConcatsByDevice() async {
    await Permission.contacts.request();
    // Get all contacts on device
    Iterable<Contact> _contacts = await ContactsService.getContacts();
    return _contacts;
  }

  /// withThumbnails: 查询是否带出手机号
  static Future<Iterable<Contact>> queryConcats({String? query, bool withThumbnails = true, bool photoHighResolution = true, bool orderByGivenName = true, bool iOSLocalizedLabels = true, bool androidLocalizedLabels = true}) async {
    await Permission.contacts.request();
    // Get contacts matching a string
    Iterable<Contact> _result = await ContactsService.getContacts(query: query,withThumbnails: withThumbnails,photoHighResolution: photoHighResolution,orderByGivenName: orderByGivenName,iOSLocalizedLabels: iOSLocalizedLabels,androidLocalizedLabels: androidLocalizedLabels);
    return _result;
  }



  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static Widget getSusItem(BuildContext context, String tag,
      {double susHeight = 40}) {
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  static Widget getWeChatListItem(
    BuildContext context,
    ContactInfo model, {
    double susHeight = 40,
    required Color headerBgColor,
    required Color headerFontColor,
  }) {
    return getWeChatItem(
      context,
      model,
      headerBgColor: headerBgColor,
      headerFontColor: headerFontColor,
    );
  }

  static Widget getWeChatItem(
    BuildContext context,
    ContactInfo model, {
    required Color headerBgColor,
    required Color headerFontColor,
  }) {
    DecorationImage? image;
    if (model.avatar!.isNotEmpty) {
      image = DecorationImage(
        image: MemoryImage(model.avatar!),
        fit: BoxFit.contain,
      );
    }
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.0),
          color: headerBgColor,
          image: image,
        ),
        child: model.avatar!.isEmpty
            ? Text('${model.firstletter}',
                style: TextStyle(fontSize: 16.0, color: headerFontColor))
            : Image.memory(model.avatar!),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model.name),
          SizedBox(
            height: 5.0,
          ),
          Text(
            model.phone!,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black45,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.pop(context, model);
      },
    );
  }
}