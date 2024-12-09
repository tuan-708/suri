import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class Item {
  late String key;
  late dynamic value;

  Item({
    required this.key,
    required this.value,
  });
}

class SingleDropDownBase extends StatefulWidget {
  final String hint;
  final List<Item> items;
  final Function(String?) onChanged;
  final double? heightBtn;
  final double? widthBtn;
  final double? borderBtn;
  final double? maxHeight;
  final Color? borderColor;
  final double? borderSize;
  final Color? backgroundItem;
  final String? selectedValue;
  final Color? backgroundButton;
  final String? label;
  final BoxBorder? boxBorderBtn;
  final double? paddingLabel;
  final TextStyle? labelStyle;
  final bool? isRequired;
  final Color? backgroundBtn;

  // ignore: use_key_in_widget_constructors
  const SingleDropDownBase(
      {super.key,
      required this.hint,
      required this.items,
      required this.onChanged,
      this.heightBtn,
      this.widthBtn,
      this.borderBtn,
      this.maxHeight,
      this.borderColor,
      this.borderSize,
      this.backgroundItem,
      this.selectedValue,
      this.backgroundButton,
      this.label,
      this.boxBorderBtn,
      this.backgroundBtn,
      this.paddingLabel,
      this.labelStyle,
      this.isRequired});

  @override
  State<SingleDropDownBase> createState() => _SingleDropDownBaseState();
}

class _SingleDropDownBaseState extends State<SingleDropDownBase> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    //  if (widget.selectedValue != "") {
    //   setState(() {
    //     selectedValue = null;
    //   });
    // }

    return SizedBox(
      width: widget.widthBtn ?? DimensionsHelper.ONE_UNIT_SIZE * 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Container(
              padding: EdgeInsets.only(
                bottom: widget.paddingLabel ?? DimensionsHelper.SPACE_SIZE_2X,
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
                    if (widget.isRequired != null)
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
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.hint,
                      style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                        fontWeight: FontWeight.w200,
                        color: ColorConstants.PLACE.withOpacity(0.8),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: widget.items
                  .map((Item item) => DropdownMenuItem<String>(
                        value: item.key.toString(),
                        child: Text(
                          item.value.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                            fontWeight: FontWeight.w200,
                            color: ColorConstants.BLACK,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: widget.selectedValue ?? selectedValue,
              onChanged: (val) {
                widget.onChanged(val);
                setState(() {
                  selectedValue = val;
                });
              },
              buttonStyleData: ButtonStyleData(
                height: widget.heightBtn ?? DimensionsHelper.ONE_UNIT_SIZE * 50,
                width: widget.widthBtn ?? DimensionsHelper.iziSize.width,
                padding: const EdgeInsets.only(left: 10, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      widget.borderBtn ?? DimensionsHelper.BORDER_RADIUS_2X),
                  border: Border.all(
                    color: widget.borderColor ?? Colors.black12,
                    width: widget.borderSize ?? 0,
                  ),
                  color: widget.backgroundButton ?? Colors.white,
                ),
                elevation: 0,
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
                iconSize: 25,
                iconEnabledColor: Colors.grey,
                iconDisabledColor: Colors.grey,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight:
                    widget.maxHeight ?? DimensionsHelper.ONE_UNIT_SIZE * 160,
                width: widget.widthBtn,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 4))
                  ],
                  borderRadius: BorderRadius.circular(
                      widget.borderBtn ?? DimensionsHelper.BORDER_RADIUS_2X),
                  border: widget.boxBorderBtn,
                  color: widget.backgroundBtn ?? Colors.white,
                ),
                elevation: 0,
                offset: const Offset(0, -3),
                scrollbarTheme: ScrollbarThemeData(
                  crossAxisMargin: 1,
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(4),
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: DimensionsHelper.ONE_UNIT_SIZE * 50,
                padding: const EdgeInsets.only(left: 10, right: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
