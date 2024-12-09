// ignore_for_file: invalid_use_of_protected_member

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/date_helper.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/number_helper.dart';
import 'package:suri_checking_event_app/core/helper/other_helper.dart';
import 'package:suri_checking_event_app/core/helper/timezone_helper.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/theme/app_theme.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';

// Text, number, tiền đều có thể hiện thị defaul = text
// PrefixIcon
// Lable bên trên có thể không (Có thể null)
// Label trên border (Có thể có or null)
// Có bắt phải nhập hay không
// Validate EditText -> Fail hiển thị error label
// Sufix label nếu nó là tiền (Nếu là tiền hiện thị thêm icon tiền)
//

enum InputBaseType {
  TEXT,
  PASSWORD,
  NUMBER,
  DOUBLE,
  PRICE,
  EMAIL,
  PHONE,
  INCREMENT,
  MILTIPLINE,
}

enum PickerDateType {
  MATERIAL,
  CUPERTINO,
}

// ignore: must_be_immutable
class InputBase extends StatefulWidget {
  InputBase({
    Key? key,
    this.label,
    this.placeHolder,
    this.allowEdit = true,
    this.maxLine = 1,
    this.isRequired = false,
    required this.type,
    this.width,
    this.fontSize,
    this.height,
    this.suffixIcon,
    this.paddingTop,
    this.errorText,
    this.textInputAction,
    this.onChanged,
    this.isValidate,
    this.focusNode,
    this.padding,
    this.onSubmitted,
    this.borderRadius,
    this.hintStyle,
    this.borderSide,
    this.isBorder = false,
    this.fillColor,
    this.prefixIcon,
    // this.prefixIcon2,
    this.validate,
    this.isLegend = false,
    this.borderSize,
    this.disableError = false,
    this.miniSize = false,
    this.colorDisibleBorder = ColorConstants.PLACE,
    this.colorBorder = ColorConstants.CIRCLE_COLOR_BG3,
    this.min = 1,
    this.max = 10,
    this.widthIncrement,
    this.isDatePicker = false,
    this.iziPickerDate = PickerDateType.MATERIAL,
    this.obscureText,
    this.contentPaddingIncrement,
    this.initValue,
    this.onTap,
    this.isNotShadown = true,
    this.labelStyle,
    this.isTimePicker = false,
    this.maximumDate,
    this.minimumDate,
    this.initDate,
    this.style,
    this.isResfreshForm = false,
    this.cursorColor,
    this.controller,
    this.inputFormatters,
    this.autofocus,
    this.cupertinoDatePickerMode,
    this.textCapitalization,
    this.isReadOnly = false,
    this.textAlign,
    this.hasFocus,
    this.passedFormatDate = 'yyyy/MM/dd',
    this.paddingLabe,
    this.textColor,
    this.filled = true,
  }) : super(key: key);
  final String? label;
  final String? placeHolder;
  final bool? allowEdit;
  final int? maxLine;
  final InputBaseType type;
  final bool? isRequired;
  final double? width;
  final double? fontSize;
  final double? height;
  final Widget? suffixIcon;
  final double? paddingTop;
  final String? errorText;
  final TextInputAction? textInputAction;
  final Function(String value)? onChanged;
  final Function(bool value)? isValidate;
  bool? boldHinText;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;
  final Function(String)? onSubmitted;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final BorderSide? borderSide;
  final bool? isBorder;
  final Color? fillColor;
  // final Widget? prefixIcon;
  final Widget Function(FocusNode? focusNode)? prefixIcon;
  final String? Function(String)? validate;
  final bool? isLegend;
  final double? borderSize;
  final bool disableError;
  final bool miniSize;
  final Color? colorDisibleBorder;
  final Color? colorBorder;
  final double? min;
  final double? max;
  final double? widthIncrement;
  final bool? isDatePicker;
  final bool? isTimePicker;
  final PickerDateType? iziPickerDate;
  final bool? obscureText;
  final EdgeInsets? contentPaddingIncrement;
  final String? initValue;
  final Function? onTap;
  final bool? isNotShadown;
  final TextStyle? labelStyle;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final DateTime? initDate;
  final TextStyle? style;
  final Color? cursorColor;
  final bool? autofocus;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final CupertinoDatePickerMode? cupertinoDatePickerMode;
  final TextCapitalization? textCapitalization;
  final bool? isReadOnly;
  final TextAlign? textAlign;
  final void Function(bool? hasFocus)? hasFocus;
  final bool filled;
  final double? paddingLabe;
  final Color? textColor;

  /// The format of the date passed to [onChanged] call back function
  final String passedFormatDate;

  bool? isResfreshForm = false;
  _InputBaseState iziState = _InputBaseState();
  @override
  // ignore: no_logic_in_create_state
  _InputBaseState createState() => iziState = _InputBaseState();
}

class _InputBaseState extends State<InputBase> {
  FocusNode? focusNode;
  bool hasFocus = false;
  TextEditingController? textEditingController;
  MoneyMaskedTextController? numberEditingController;
  MoneyMaskedTextController? doubleEditingController;

  bool isShowedError = false;
  bool isVisible = true;
  bool isDisibleIncrement = false;
  bool isDisibleReduction = false;
  String? _errorText = "";

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.initValue ?? '');
    //TODO: fork lại fackage của họ, Thêm try catch
    // Khởi tạo lại NumberController set IniitValue
    if (widget.type == InputBaseType.INCREMENT ||
        widget.type == InputBaseType.PRICE) {
      numberEditingController = MoneyMaskedTextController(
        initialValue:
            NumberHelper.parseDouble(widget.initValue ?? widget.min.toString()),
        precision: 0,
      );
    } else {
      numberEditingController = MoneyMaskedTextController(
        precision: 0,
      );
    }

    doubleEditingController = MoneyMaskedTextController(
      precision: 1,
    );

    focusNode = widget.focusNode ?? FocusNode();
    if (widget.type == InputBaseType.INCREMENT) {
      checkDisibleIncrement(
          NumberHelper.parseInt(numberEditingController!.text));
    }
    // else if (widget.type == InputBaseType.NUMBER || widget.type == InputBaseType.PRICE) {
    //   numberEditingController!.clear();
    //   doubleEditingController!.clear();
    // }
  }

  @override
  void dispose() {
    focusNode?.dispose();
    textEditingController?.dispose();
    numberEditingController?.dispose();
    doubleEditingController?.dispose();
    super.dispose();
  }

  void setValue(dynamic newValue) {
    if (!StringValid.nullOrEmpty(newValue) &&
            widget.type == InputBaseType.NUMBER ||
        !StringValid.nullOrEmpty(newValue) &&
            widget.type == InputBaseType.PRICE ||
        !StringValid.nullOrEmpty(newValue) &&
            widget.type == InputBaseType.DOUBLE) {
      numberEditingController = MoneyMaskedTextController(
        initialValue: NumberHelper.parseDouble(newValue.toString()),
        precision: 0,
        decimalSeparator: '',
      );
      doubleEditingController = MoneyMaskedTextController(
        initialValue: NumberHelper.parseDouble(newValue.toString()),
        precision: 1,
      );
    } else {
      textEditingController!.text = newValue.toString();
    }
    setState(() {});
  }

  TextInputType getType(InputBaseType type) {
    if (type == InputBaseType.NUMBER) {
      return TextInputType.number;
    } else if (type == InputBaseType.PASSWORD) {
      return TextInputType.visiblePassword;
    } else if (type == InputBaseType.PRICE) {
      return TextInputType.number;
    } else if (type == InputBaseType.TEXT) {
      return TextInputType.text;
    } else if (type == InputBaseType.EMAIL) {
      return TextInputType.emailAddress;
    } else if (type == InputBaseType.PHONE) {
      return TextInputType.phone;
    } else if (type == InputBaseType.DOUBLE) {
      return const TextInputType.numberWithOptions();
    } else if (type == InputBaseType.INCREMENT) {
      return TextInputType.number;
    } else if (type == InputBaseType.MILTIPLINE) {
      return TextInputType.multiline;
    }
    return TextInputType.text;
  }

  TextEditingController getController(InputBaseType type) {
    if (type == InputBaseType.NUMBER) {
      return widget.controller ?? numberEditingController!;
    } else if (type == InputBaseType.PASSWORD) {
      return widget.controller ?? textEditingController!;
    } else if (type == InputBaseType.PRICE) {
      return widget.controller ??
          textEditingController!; //numberEditingController!;
    } else if (type == InputBaseType.TEXT) {
      return widget.controller ?? textEditingController!;
    } else if (type == InputBaseType.EMAIL) {
      return widget.controller ?? textEditingController!;
    } else if (type == InputBaseType.PHONE) {
      return widget.controller ?? textEditingController!;
    } else if (type == InputBaseType.DOUBLE) {
      return doubleEditingController!;
    } else if (type == InputBaseType.INCREMENT) {
      return widget.controller ?? numberEditingController!;
    }
    return widget.controller ?? textEditingController!;
  }

  String? Function(String)? checkValidate(
    InputBaseType type,
  ) {
    if (widget.validate != null) {
      return widget.validate;
    }
    if (type == InputBaseType.NUMBER) {
      return null;
    } else if (type == InputBaseType.PASSWORD) {
      return StringValid.password;
    } else if (type == InputBaseType.PRICE) {
      return null;
    } else if (type == InputBaseType.TEXT) {
      return null;
    } else if (type == InputBaseType.EMAIL) {
      return null;
    } else if (type == InputBaseType.PHONE) {
      return null;
    } else if (type == InputBaseType.INCREMENT) {
      return StringValid.increment;
    } else {
      return null;
    }
  }

  void onIncrement(InputBaseType type, {required bool increment}) {
    if (type == InputBaseType.INCREMENT) {
      final controller = getController(widget.type);
      if (StringValid.nullOrEmpty(controller.text)) {
        controller.text = '1';
      }
      int value = int.parse(controller.text);
      if (increment) {
        value++;
        controller.text = value.toString();
        checkDisibleIncrement(value);
      } else {
        validator(widget.type, value.toString());
        if (value > 0) {
          value--;
          controller.text = value.toString();
        }
        checkDisibleIncrement(value);
      }
      if (widget.onChanged != null) {
        widget.onChanged!(value.toString());
        validator(widget.type, value.toString());
      }
    }
  }

  void checkDisibleIncrement(int value) {
    if (value <= widget.min! && !isDisibleReduction) {
      setState(() {
        isDisibleReduction = true;
      });
      return;
    }
    if (value > widget.min! && isDisibleReduction) {
      setState(() {
        isDisibleReduction = false;
      });
      return;
    }
    if (value >= widget.max! && !isDisibleIncrement) {
      setState(() {
        isDisibleIncrement = true;
      });
      return;
    }
    if (value < widget.max! && isDisibleIncrement) {
      setState(() {
        isDisibleIncrement = false;
      });
      return;
    }
  }

  void validator(InputBaseType type, String val) {
    if (checkValidate(widget.type) != null && isShowedError) {
      setState(() {
        _errorText = checkValidate(widget.type)!(val.toString());
        if (val.toString() == "") _errorText = "";
      });
      if (widget.isValidate != null) {
        widget.isValidate!(StringValid.nullOrEmpty(_errorText));
      }
    }
  }

  void datePicker(PickerDateType pickerType) {
    // if (widget.isTimePicker!) {
    //   showTimePicker(
    //     context: context,
    //     initialTime: initialTime,
    //   );
    // }
    OtherHelper.primaryFocus();
    if (pickerType == PickerDateType.CUPERTINO) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: ColorConstants.WHITE,
          ),
          height: DimensionsHelper.ONE_UNIT_SIZE * 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                height: DimensionsHelper.ONE_UNIT_SIZE * 400,
                child: CupertinoDatePicker(
                  mode: widget.isTimePicker!
                      ? widget.cupertinoDatePickerMode ??
                          CupertinoDatePickerMode.time
                      : widget.cupertinoDatePickerMode ??
                          CupertinoDatePickerMode.date,
                  // initialDateTime: DateTime.now(),
                  use24hFormat: true,
                  initialDateTime: widget.initDate ??
                      widget.minimumDate ??
                      TimeZoneHelper.dateTimeNow(),
                  maximumDate: widget.maximumDate ??
                      TimeZoneHelper.dateTimeNow()
                          .add(const Duration(days: 18250)),
                  minimumDate: widget.minimumDate ??
                      TimeZoneHelper.dateTimeNow()
                          .subtract(const Duration(days: 18250)),

                  onDateTimeChanged: (value) {
                    if (widget.isTimePicker!) {
                      if (widget.cupertinoDatePickerMode != null &&
                          widget.cupertinoDatePickerMode ==
                              CupertinoDatePickerMode.dateAndTime) {
                        final String date = DateHelper.formatDate(value,
                            format: 'dd/MM/yyyy - HH:mm:ss');
                        getController(widget.type).text = date;
                        if (!StringValid.nullOrEmpty(widget.onChanged)) {
                          widget.onChanged!(DateHelper.formatDate(value,
                              format: 'dd/MM/yyyy - HH:mm'));
                        }
                      } else {
                        // final String date = DateHelper.formatDate(value, format: 'MM/dd/yyyy');
                        getController(widget.type).text = DateHelper.formatDate(
                            value,
                            format: 'HH:mm'); //date;
                        if (!StringValid.nullOrEmpty(widget.onChanged)) {
                          widget.onChanged!(DateHelper.formatDate(value,
                              format: 'dd/MM/yyyy HH:mm'));
                        }
                      }
                      OtherHelper.primaryFocus();
                    } else {
                      final String date =
                          DateHelper.formatDate(value, format: 'dd/MM/yyyy');
                      getController(widget.type).text = date;
                      if (!StringValid.nullOrEmpty(widget.onChanged)) {
                        widget.onChanged!(
                            DateHelper.formatDate(value, format: 'dd/MM/yyyy'));
                      }
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  final value = getController(widget.type).text;
                  if (StringValid.nullOrEmpty(value)) {
                    final now = TimeZoneHelper.dateTimeNow();
                    if (widget.isTimePicker!) {
                      if (widget.cupertinoDatePickerMode != null &&
                          widget.cupertinoDatePickerMode ==
                              CupertinoDatePickerMode.dateAndTime) {
                        final String date = DateHelper.formatDate(now,
                            format: 'dd/MM/yyyy HH:mm');
                        getController(widget.type).text = date;
                        if (!StringValid.nullOrEmpty(widget.onChanged)) {
                          widget.onChanged!(DateHelper.formatDate(now,
                              format: 'dd/MM/yyyy HH:mm'));
                        }
                      } else {
                        // final String date = DateHelper.formatDate(now, format: 'MM/dd/yyyy');
                        // getController(widget.type).text = date;
                        // if (!ValidateHelper.nullOrEmpty(widget.onChanged)) {
                        //   widget.onChanged!(DateHelper.formatDate(now, format: 'MM/dd/yyyy'));
                        // }
                        getController(widget.type).text =
                            DateHelper.formatDate(now, format: 'HH:mm'); //date;
                        if (!StringValid.nullOrEmpty(widget.onChanged)) {
                          widget.onChanged!(DateHelper.formatDate(now,
                              format: 'dd/MM/yyyy HH:mm'));
                        }
                      }
                      OtherHelper.primaryFocus();
                    } else {
                      final String date =
                          DateHelper.formatDate(now, format: 'dd/MM/yyyy');
                      getController(widget.type).text = date;
                      if (!StringValid.nullOrEmpty(widget.onChanged)) {
                        widget.onChanged!(
                            DateHelper.formatDate(now, format: 'dd/MM/yyyy'));
                      }
                    }
                  }

                  Navigator.pop(context);
                },
                child: GestureDetector(
                  onTap: () {
                    final value = getController(widget.type).text;
                    if (StringValid.nullOrEmpty(value)) {
                      getController(widget.type).text = DateHelper.formatDate(
                          DateTime.now(),
                          format: 'dd/MM/yyyy');
                    }
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: DimensionsHelper.SPACE_SIZE_3X,
                    ),
                    child: TextBase(
                      text: "Xác nhận",
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_H6,
                          color: ColorConstants.PRIMARY_1,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ).then((value) {
        hasFocus = false;
        if (widget.hasFocus != null) {
          widget.hasFocus!(hasFocus);
        }
      });
    } else {
      showDatePicker(
        context: context,
        initialDate: widget.initDate ??
            widget.minimumDate ??
            TimeZoneHelper.dateTimeNow(),
        firstDate: widget.minimumDate ??
            TimeZoneHelper.dateTimeNow().subtract(const Duration(days: 18250)),
        lastDate: widget.maximumDate ??
            TimeZoneHelper.dateTimeNow().add(const Duration(days: 18250)),
        // initialDate: DateTime.now(),
        // firstDate: DateTime.now(),
        // lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: AppTheme.light.copyWith(
              colorScheme: const ColorScheme.light(
                primary: ColorConstants.PRIMARY_1,
              ),
            ),
            child: child!,
          );
        },
      ).then(
        (value) {
          if (!StringValid.nullOrEmpty(value)) {
            final String date =
                DateHelper.formatDate(value!, format: widget.passedFormatDate);
            getController(widget.type).text = date;
            if (!StringValid.nullOrEmpty(widget.onChanged)) {
              widget.onChanged!(DateHelper.formatDate(value,
                  format: widget.passedFormatDate));
            }
          }
        },
      );
    }
  }

  Widget? getSuffixIcon() {
    if (widget.isDatePicker! && StringValid.nullOrEmpty(widget.suffixIcon)) {
      return const Icon(
        Icons.calendar_month,
        color: ColorConstants.PLACE,
        size: 25,
      );
    }
    if (widget.type == InputBaseType.PRICE) {
      // return widget.suffixIcon ??
      //     SizedBox.shrink(
      //       child: Padding(
      //         padding: EdgeInsets.only(
      //           right: DimensionsHelper.SPACE_SIZE_1X,
      //         ),
      //         child: Align(
      //           alignment: Alignment.centerRight,
      //           child: Text(
      //             "\$",
      //             style:
      //                 TextStyle(fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL),
      //           ),
      //         ),
      //       ),
      //     );
    } else if (widget.type == InputBaseType.PASSWORD) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        child: Icon(isVisible ? Icons.visibility_off : Icons.visibility,
            color: ColorConstants.ICON),
      );
    }
    if (!StringValid.nullOrEmpty(widget.suffixIcon)) {
      return widget.suffixIcon!;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == InputBaseType.INCREMENT) {
      checkDisibleIncrement(
          NumberHelper.parseInt(numberEditingController!.text));
    }
    if (!focusNode!.hasListeners) {
      focusNode!.addListener(() {
        setState(() {});
      });
    }
    if (!StringValid.nullOrEmpty(widget.errorText) &&
        StringValid.nullOrEmpty(_errorText)) {
      _errorText = widget.errorText.toString();
    }

    // if (widget.isResfreshForm == true) {
    //   if (widget.type == InputBaseType.NUMBER ||
    //       widget.type == InputBaseType.PRICE ||
    //       widget.type == InputBaseType.DOUBLE) {
    //     getController(widget.type).text = '0';
    //   } else {
    //     getController(widget.type).text = '';
    //   }
    // }
    return SizedBox(
      width: widget.width ?? DimensionsHelper.iziSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isLegend == false && widget.label != null)
            Container(
              padding: EdgeInsets.only(
                bottom: widget.paddingLabe ?? DimensionsHelper.SPACE_SIZE_2X,
              ),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: widget.label,
                  style: widget.labelStyle ??
                      TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 1.1,
                        fontWeight: FontWeight.w200,
                        color: ColorConstants.BLACK.withOpacity(0.8),
                      ),
                  children: [
                    if (widget.isRequired!)
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                          fontWeight: FontWeight.w200,
                          color: Colors.red,
                        ),
                      )
                    else
                      const TextSpan(),
                  ],
                ),
              ),
            ),
          Row(
            children: [
              if (InputBaseType.INCREMENT == widget.type)
                GestureDetector(
                  onTap: () {
                    if (!isDisibleReduction) {
                      OtherHelper.primaryFocus();
                      onIncrement(widget.type, increment: false);
                    }
                  },
                  child: Container(
                    // margin: EdgeInsets.all(
                    //   DimensionsHelper.ONE_UNIT_SIZE * 10,
                    // ),
                    height:
                        widget.height ?? DimensionsHelper.ONE_UNIT_SIZE * 55,
                    constraints: BoxConstraints(
                      maxHeight: DimensionsHelper.ONE_UNIT_SIZE * 55,
                    ),
                    width: widget.widthIncrement ??
                        DimensionsHelper.ONE_UNIT_SIZE * 80,
                    decoration: BoxDecoration(
                      color: ColorConstants.WHITE,
                      boxShadow:
                          widget.isNotShadown! ? null : OtherHelper().boxShadow,
                      border: widget.isBorder!
                          ? isDisibleReduction
                              ? Border.all(
                                  color: widget.colorDisibleBorder ??
                                      ColorConstants.PRIMARY_1,
                                )
                              : Border.all(
                                  color: widget.colorBorder ??
                                      ColorConstants.PRIMARY_1,
                                )
                          : isDisibleReduction
                              ? Border.all(
                                  color: widget.colorDisibleBorder ??
                                      ColorConstants.PRIMARY_1,
                                )
                              : Border.all(
                                  color: widget.colorBorder ??
                                      ColorConstants.PRIMARY_1,
                                ),
                      borderRadius: BorderRadius.circular(
                        DimensionsHelper.BLUR_RADIUS_2X,
                      ),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: isDisibleReduction
                          ? widget.colorDisibleBorder ?? ColorConstants.PLACE
                          : widget.colorBorder ??
                              ColorConstants.CIRCLE_COLOR_BG3,
                    ),
                  ),
                ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    if (widget.isDatePicker! && widget.allowEdit!) {
                      if (widget.hasFocus != null) {
                        hasFocus = true;
                        widget.hasFocus!(hasFocus);
                      }
                      datePicker(widget.iziPickerDate!);
                    }
                    if (widget.allowEdit == false && widget.onTap != null) {
                      widget.onTap!();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow:
                          widget.isNotShadown! ? null : OtherHelper().boxShadow,
                      color: ColorConstants.WHITE,
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? DimensionsHelper.BLUR_RADIUS_2X,
                      ),
                    ),
                    width: InputBaseType.INCREMENT == widget.type
                        ? widget.width ?? DimensionsHelper.ONE_UNIT_SIZE * 90
                        : null,
                    height: widget.miniSize ? 40 : widget.height,
                    child: TextFormField(
                      readOnly: widget.isReadOnly!,
                      autofocus: widget.autofocus ?? false,
                      onTap: () {
                        if (!StringValid.nullOrEmpty(widget.onTap)) {
                          widget.onTap!();
                        }
                      },
                      textAlign: InputBaseType.INCREMENT == widget.type
                          ? TextAlign.center
                          : widget.textAlign ?? TextAlign.start,
                      onFieldSubmitted: (val) {
                        if (!StringValid.nullOrEmpty(widget.onSubmitted)) {
                          widget.onSubmitted!(val);
                        }
                        if (!StringValid.nullOrEmpty(val) &&
                            InputBaseType.INCREMENT == widget.type) {
                          if (NumberHelper.parseInt(val) < widget.min!) {
                            getController(widget.type).text =
                                NumberHelper.parseInt(widget.min.toString())
                                    .toString();
                          }
                        }
                      },
                      onChanged: (val) {
                        isShowedError = true;
                        if (widget.type == InputBaseType.NUMBER ||
                            widget.type == InputBaseType.DOUBLE) {
                          if (StringValid.nullOrEmpty(val)) {
                            // getController(widget.type).text = '';
                            // val = '';
                          }
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(val);
                          // onIncrement(widget.type, increment: true);
                        }
                        validator(widget.type, val.toString());
                      },
                      textInputAction: widget.textInputAction,
                      keyboardType: getType(widget.type),
                      maxLines: widget.maxLine,
                      textAlignVertical: TextAlignVertical.center,
                      enabled: widget.isDatePicker! ? false : widget.allowEdit,
                      controller: getController(widget.type),
                      obscureText: widget.obscureText ??
                          widget.type == InputBaseType.PASSWORD && isVisible,
                      focusNode: focusNode,
                      inputFormatters: _getInputFormatters(
                          widget.type), //widget.inputFormatters,
                      style: widget.style ??
                          TextStyle(
                              color: Colors.black,
                              fontFamily: Fonts.Lexend.name,
                              fontWeight: FontWeight.w200),
                      cursorColor:
                          widget.cursorColor ?? ColorConstants.PRIMARY_1,
                      textCapitalization:
                          widget.textCapitalization ?? TextCapitalization.none,
                      decoration: InputDecoration(
                        hintStyle: widget.hintStyle ??
                            TextStyle(
                              fontFamily: Fonts.Lexend.name,
                              fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                              fontWeight: FontWeight.w200,
                              color: ColorConstants.PLACE.withOpacity(0.8),
                            ),
                        contentPadding: widget.miniSize
                            ? const EdgeInsets.only(
                                top: 15, left: 10, right: 10)
                            : widget.contentPaddingIncrement,
                        isDense: true,
                        labelText:
                            widget.isLegend == true ? widget.label : null,
                        labelStyle: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: focusNode!.hasFocus
                              ? DimensionsHelper.FONT_SIZE_H5
                              : DimensionsHelper.FONT_SIZE_H6,
                          fontWeight: focusNode!.hasFocus
                              ? FontWeight.w200
                              : FontWeight.w200,
                          color: ColorConstants.BLACK,
                        ),
                        prefixIcon: StringValid.nullOrEmpty(widget.prefixIcon)
                            ? null
                            : widget.type == InputBaseType.PRICE
                                ? SizedBox.shrink(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: DimensionsHelper.SPACE_SIZE_1X,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "\$",
                                          style: TextStyle(
                                              fontFamily: Fonts.Lexend.name,
                                              fontSize: DimensionsHelper
                                                  .FONT_SIZE_SPAN_SMALL,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  )
                                : widget.prefixIcon!(focusNode),
                        border: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false)
                                        ? ColorConstants.PRIMARY_1
                                        : ColorConstants.PRIMARY_1,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ??
                                DimensionsHelper.BLUR_RADIUS_1X,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false)
                                        ? ColorConstants.PRIMARY_1
                                        : ColorConstants.PRIMARY_1,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ??
                                DimensionsHelper.BLUR_RADIUS_1X,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false)
                                        ? ColorConstants.BORDER
                                        : ColorConstants.BORDER,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ??
                                DimensionsHelper.BLUR_RADIUS_2X,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false)
                                        ? ColorConstants.BORDER
                                        : ColorConstants.BORDER,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ??
                                DimensionsHelper.BLUR_RADIUS_1X,
                          ),
                        ),
                        filled: widget.filled,
                        hintText: widget.placeHolder,
                        fillColor: (widget.allowEdit == false)
                            ? widget.fillColor ??
                                ColorConstants.PLACE1.withOpacity(0.4)
                            : widget.fillColor ?? ColorConstants.WHITE,
                        suffixIcon: getSuffixIcon(),
                      ),
                    ),
                  ),
                ),
              ),
              if (InputBaseType.INCREMENT == widget.type)
                GestureDetector(
                  onTap: () {
                    if (!isDisibleIncrement) {
                      OtherHelper.primaryFocus();
                      onIncrement(widget.type, increment: true);
                    }
                  },
                  child: Container(
                    // margin: EdgeInsets.all(
                    //   DimensionsHelper.ONE_UNIT_SIZE * 10,
                    // ),
                    constraints: BoxConstraints(
                        maxHeight: DimensionsHelper.ONE_UNIT_SIZE * 60),
                    height:
                        widget.height ?? DimensionsHelper.ONE_UNIT_SIZE * 60,
                    width: widget.widthIncrement ??
                        DimensionsHelper.ONE_UNIT_SIZE * 80,
                    decoration: BoxDecoration(
                      color: ColorConstants.WHITE,
                      // boxShadow: OtherHelper().boxShadow,
                      border: widget.isBorder!
                          ? isDisibleIncrement
                              ? Border.all(
                                  color: widget.colorDisibleBorder ??
                                      ColorConstants.PRIMARY_1,
                                )
                              : Border.all(
                                  color: widget.colorBorder ??
                                      ColorConstants.PRIMARY_1,
                                )
                          : isDisibleIncrement
                              ? Border.all(
                                  color: widget.colorDisibleBorder ??
                                      ColorConstants.PRIMARY_1,
                                )
                              : Border.all(
                                  color: widget.colorBorder ??
                                      ColorConstants.PRIMARY_1,
                                ),
                      borderRadius: BorderRadius.circular(
                        DimensionsHelper.BLUR_RADIUS_2X,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: isDisibleIncrement
                          ? widget.colorDisibleBorder ?? ColorConstants.PLACE
                          : widget.colorBorder ??
                              ColorConstants.CIRCLE_COLOR_BG3,
                    ),
                  ),
                ),
            ],
          ),
          // if (!widget.disbleError)
          if (!StringValid.nullOrEmpty(_errorText) && !widget.disableError)
            Container(
              margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_1X),
              alignment: Alignment.topLeft,
              child: Text(
                StringValid.nullOrEmpty(_errorText.toString())
                    ? ""
                    : _errorText.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontWeight: FontWeight.w200,
                  color: ColorConstants.RED,
                ),
              ),
            ),
        ],
      ),
    );
  }

  ///
  /// Get input formatters.
  ///
  List<TextInputFormatter> _getInputFormatters(InputBaseType type) {
    if (widget.type == InputBaseType.NUMBER) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    if (widget.type == InputBaseType.PRICE) {
      final locale = sl<SharedPreferenceHelper>().getLocale;
      return [
        CurrencyTextInputFormatter(
          symbol: '',
          decimalDigits: 0,
          locale: locale.isEmpty ? 'vi' : locale,
        ),
      ];
    }
    if (widget.type == InputBaseType.DOUBLE) {
      final locale = sl<SharedPreferenceHelper>().getLocale;

      final currentLocale = locale.isEmpty ? 'vi' : locale.toString();
      return [
        ThousandsSeparatorDecimalInputFormatter(
          locale: currentLocale,
          separator: locale == 'vi' ? '.' : ',', // Ký tự phân cách hàng nghìn
          decimalSeparator:
              locale == 'vi' ? ',' : '.', // Ký tự phân cách thập phân
        ),
      ];
    }
    return widget.inputFormatters ?? [];
  }
}

class ThousandsSeparatorDecimalInputFormatter extends TextInputFormatter {
  ThousandsSeparatorDecimalInputFormatter({
    this.locale = 'vi',
    required this.decimalSeparator,
    required this.separator,
  });
  String? locale;
  String separator;
  String decimalSeparator;
  static const int decimalDigits = 2; // Số chữ số sau dấu phẩy

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newText = newValue.text.replaceAll(separator, '');
    final List<String> parts = newText.split(decimalSeparator);

    String integerPart = parts[0];
    if (integerPart.isNotEmpty) {
      final regEx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      integerPart =
          integerPart.replaceAllMapped(regEx, (Match m) => '${m[1]}$separator');
    }

    newText = integerPart;
    if (parts.length > 1) {
      String decimalPart = parts[1];
      if (decimalPart.length > decimalDigits) {
        decimalPart = decimalPart.substring(0, decimalDigits);
      }
      newText += '$decimalSeparator$decimalPart';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
