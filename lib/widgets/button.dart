import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/theme/style.dart';

enum NButtonSize {
  Mini,
  Small,
  Normal,
  Large,
}

enum NButtonType {
  Default,
  Primary,
  Info,
  Danger,
  Warning,
}

class NButton extends StatelessWidget {
  // 类型
  final NButtonType type;

  // 尺寸
  final NButtonSize size;

  // 按钮文字
  final String? text;

  // 按钮宽度
  final double? width;

  // 按钮高度
  final double? height;

  // 按钮颜色
  final dynamic color;

  // 左侧图标
  final Widget? icon;

  // 按钮内文字颜色
  final Color? textColor;

  // 是否为块级元素
  final bool block;

  // 是否为朴素按钮
  final bool plain;

  // 是否为方形按钮
  final bool square;

  // 是否为圆形按钮
  final bool round;

  // 是否禁用按钮
  final bool disabled;

  // 是否为加载中
  final bool loading;

  // 是否使用 0.5px 边框
  final bool hairline;

  // 自定义内边距
  final EdgeInsets? padding;

  // 自定义按钮圆角
  final BorderRadius? borderRadius;

  final bool hasBorder;

  // 点击后回调
  final Function()? onTap;

  NButton(
      {Key? key,
      this.type: NButtonType.Default,
      this.size: NButtonSize.Normal,
      this.text,
      this.width,
      this.height,
      this.color,
      this.textColor,
      this.icon,
      this.hasBorder: true,
      this.block: false,
      this.plain: false,
      this.square: false,
      this.round: false,
      this.disabled: false,
      this.hairline: false,
      this.loading: false,
      this.padding,
      this.borderRadius,
      this.onTap})
      : super(key: key);

  final Map<NButtonSize, dynamic> sizes = {
    NButtonSize.Mini: <String, dynamic>{
      "fontSize": Style.buttonMiniFontSize,
      "padding": const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
    },
    NButtonSize.Small: <String, dynamic>{
      "fontSize": Style.buttonSmallFontSize,
      "padding": const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    },
    NButtonSize.Normal: <String, dynamic>{
      "fontSize": Style.buttonDefaultFontSize,
      "padding": const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
    },
    NButtonSize.Large: <String, dynamic>{
      "fontSize": Style.buttonLargeFontSize,
      "padding": const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    },
  };

  // plain为false时才使用colors配置
  final Map<NButtonType, dynamic> colors = {
    NButtonType.Default: <String, Color>{
      "buttonColor": Style.buttonDefaultBackgroundColor,
      "borderColor": Style.buttonDefaultBorderColor,
      "textColor": Style.buttonDefaultColor
    },
    NButtonType.Primary: <String, Color>{
      "buttonColor": Style.buttonPrimaryBackgroundColor,
      "borderColor": Style.buttonPrimaryBorderColor,
      "textColor": Style.buttonPrimaryColor
    },
    NButtonType.Info: <String, Color>{
      "buttonColor": Style.buttonInfoBackgroundColor,
      "borderColor": Style.buttonInfoBorderColor,
      "textColor": Style.buttonInfoColor
    },
    NButtonType.Danger: <String, Color>{
      "buttonColor": Style.buttonDangerBackgroundColor,
      "borderColor": Style.buttonDangerBorderColor,
      "textColor": Style.buttonDangerColor
    },
    NButtonType.Warning: <String, Color>{
      "buttonColor": Style.buttonWarningBackgroundColor,
      "borderColor": Style.buttonWarningBorderColor,
      "textColor": Style.buttonWarningColor
    },
  };

  Widget buildContent() {
    Color? buttonColor;
    buttonColor = color is Gradient
        ? null
        : plain
            ? Style.buttonPlainBackgroundColor
            : (color ?? colors[type]["buttonColor"]);
    Color? buttonTextColor = (textColor ??
        (plain
            ? (color ?? colors[type]["buttonColor"])
            : ((color != null) && type == NButtonType.Default
                ? Colors.white
                : colors[type]["textColor"])));

    return Container(
      width: width,
      height: height ?? sizes[size]["height"],
      padding: padding ?? sizes[size]["padding"],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: block ? MainAxisSize.max : MainAxisSize.min,
        children: <Widget>[
          loading
              ? SizedBox(
                  width: sizes[size]["fontSize"],
                  height: sizes[size]["fontSize"],
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(buttonTextColor),
                    backgroundColor: buttonColor,
                    strokeWidth: Style.borderWidthBase,
                  ),
                )
              : (icon ?? Container()),
          (loading || icon != null) && text != null
              ? const SizedBox(width: Style.intervalSm)
              : Container(),
          text != null
              ? Text(text!,
                  style: TextStyle(
                      color: buttonTextColor,
                      fontSize: sizes[size]["fontSize"]))
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    Color? buttonColor;

    borderColor = color is Gradient
        ? null
        : (hasBorder
            ? color ?? colors[type]["borderColor"]
            : Colors.transparent);
    buttonColor = color is Gradient
        ? null
        : plain
            ? Style.buttonPlainBackgroundColor
            : (color ?? colors[type]["buttonColor"]);
    return Opacity(
      opacity: disabled ? Style.buttonDisabledOpacity : 1.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: buttonColor,
            gradient: color is Gradient ? color : null,
            border: color is Gradient
                ? null
                : Border.all(
                    color: borderColor!,
                    width: hairline
                        ? Style.buttonHairBorderWidth
                        : Style.buttonBorderWidth),
            borderRadius: borderRadius ??
                (square
                    ? null
                    : BorderRadius.circular(round
                        ? Style.buttonRoundBorderRadius
                        : Style.buttonBorderRadius))),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            focusColor: (disabled || loading)
                ? Style.transparent
                : Theme.of(context).focusColor,
            highlightColor: (disabled || loading)
                ? Style.transparent
                : Theme.of(context).highlightColor,
            hoverColor: (disabled || loading)
                ? Style.transparent
                : Theme.of(context).hoverColor,
            splashColor: (disabled || loading)
                ? Style.transparent
                : Theme.of(context).splashColor,
            borderRadius: borderRadius ??
                (square
                    ? null
                    : BorderRadius.circular(round
                        ? Style.buttonRoundBorderRadius
                        : Style.buttonBorderRadius)),
            onTap: () {
              if (!disabled && !loading && onTap != null) onTap!();
            },
            child: buildContent(),
          ),
        ),
      ),
    );
  }
}
