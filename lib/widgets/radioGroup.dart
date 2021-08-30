import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/theme/style.dart';

import 'cell.dart';
import 'cellGroup.dart';
import 'checkbox.dart';

class RadioGroup extends StatefulWidget {
  // 选中项的标识符
  final String? value;
  // 形状
  final String? shape;
  // 所有选项
  final List<RadioItem>? list;
  // 是否禁用所有单选框
  final bool? disabled;
  // 所有单选框的图标大小
  final double? iconSize;
  // 所有单选框的选中状态颜色
  final Color? checkedColor;
  // 是否为单元格组件
  final bool inCellGroup;
  // 布局方式
  final Axis direction;
  // 当绑定值变化时触发的事件
  final Function(String? val)? onChange;

  RadioGroup(
      {Key? key,
      this.shape,
      this.value,
      this.list,
      this.disabled,
      this.checkedColor,
      this.inCellGroup: false,
      this.onChange,
      this.iconSize,
      this.direction: Axis.vertical})
      : super(key: key);

  @override
  _RadioGroup createState() => _RadioGroup();
}

class _RadioGroup extends State<RadioGroup> {
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  List<Widget> buildItems() {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.list!.length; i++) {
      RadioItem item = widget.list![i];
      Widget checkbox = NCheckbox(
        value: _value == item.name,
        shape: widget.shape ?? item.shape,
        text: widget.inCellGroup ? null : item.text,
        disabled: widget.disabled ?? item.disabled,
        readonly: _value == item.name,
        iconSize: widget.iconSize ?? item.iconSize,
        checkedColor: widget.checkedColor ?? item.checkedColor,
        onChange: (val) {
          setState(() {
            _value = item.name;
          });
          if (widget.onChange != null) widget.onChange!(_value);
        },
      );
      widgets.add(widget.inCellGroup
          ? Cell(
              title: item.text,
              customRight: checkbox,
              clickable: true,
              onClick: () {
                setState(() {
                  if (_value == item.name) return;
                  _value = item.name;
                });
              },
            )
          : checkbox);
      if (i < widget.list!.length - 1 && !widget.inCellGroup) {
        widgets.add(SizedBox(height: Style.intervalLg));
      }
    }
    return widgets;
  }

  Widget build(BuildContext context) {
    return widget.inCellGroup
        ? CellGroup(
            children: <Widget>[...buildItems()],
          )
        : widget.direction == Axis.vertical
            ? Column(
                children: <Widget>[...buildItems()],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[...buildItems()]);
  }
}

class RadioItem {
  final String? name;
  final bool value;
  final String shape;
  final String? text;
  final bool disabled;
  final double iconSize;
  final Color checkedColor;

  RadioItem(
      {this.name,
      this.value: false,
      this.shape: 'round',
      this.text,
      this.disabled: false,
      this.iconSize: Style.checkboxSize,
      this.checkedColor: Style.checkboxCheckedIconColor});
}
