import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_nice_widgets/model/ContactInfo.dart';
import 'package:flutter_nice_widgets/utils/contacts_utils.dart';
import 'package:flutter_nice_widgets/widgets/loading.dart';
import 'package:flutter_nice_widgets/widgets/scaffold.dart';
import 'package:lpinyin/lpinyin.dart';

class NConcats extends StatefulWidget {
  final Color? headerColor;
  final Color? headerFontColor;
  const NConcats({Key? key, this.headerColor,this.headerFontColor}) : super(key: key);

  @override
  _NConcatsState createState() => _NConcatsState();
}

class _NConcatsState extends State<NConcats> {
  List<ContactInfo> contactList = [];
  List<ContactInfo> topList = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    this.loadData();
  }
  void loadData() async {
    isLoading = true;
    //加载联系人列表
    Iterable<Contact> result =
        await ContactUtils.queryConcats();
      result.toList().forEach((e) {
        e.phones!.toList().forEach((ctt) {
          String name = e.displayName ?? '未命名';
          ContactInfo contactInfo = ContactInfo(name: name, namePinyin: PinyinHelper.getPinyin(name),phone: ctt.value,);
          if(e.avatar != null){
            contactInfo.avatar = e.avatar;
          }
          contactList.add(contactInfo);
        });
      });
      _handleList(contactList);
    
  }

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      list[i].firstletter = list[i].name.substring(0, 1);
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(contactList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(contactList);

    // add topList.
    contactList.insertAll(0, topList);

    setState(() {
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '通讯录',
      body: isLoading ? Center(child: Loading(text: '通讯录读取中',)) : AzListView(
        data: contactList,
        itemCount: contactList.length,
        itemBuilder: (BuildContext context, int index) {
          ContactInfo model = contactList[index];
          return ContactUtils.getWeChatListItem(
            context,
            model,
            headerBgColor: widget.headerColor ?? Color(0xFF0099FF),
            headerFontColor: widget.headerFontColor ?? Color(0xFFFFFFFF),
          );
        },
        physics: BouncingScrollPhysics(),
        susItemBuilder: (BuildContext context, int index) {
          ContactInfo model = contactList[index];
          if ('↑' == model.getSuspensionTag()) {
            return Container();
          }
          return ContactUtils.getSusItem(context, model.getSuspensionTag());
        },
        indexBarData: [...kIndexBarData],
        indexBarOptions: IndexBarOptions(
          needRebuild: true,
          ignoreDragCancel: true,
          downTextStyle: TextStyle(fontSize: 12, color: Colors.white),
          downItemDecoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.green),
          indexHintWidth: 120 / 2,
          indexHintHeight: 100 / 2,
          indexHintDecoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ContactUtils.getImgPath('ic_index_bar_bubble_gray'),package: 'flutter_nice_widgets'),
              fit: BoxFit.contain,
            ),
          ),
          indexHintAlignment: Alignment.centerRight,
          indexHintChildAlignment: Alignment(-0.25, 0.0),
          indexHintOffset: Offset(-20, 0),
        ),
      ),
    );
  }
}