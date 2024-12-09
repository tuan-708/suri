import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/drop_down_button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:tiengviet/tiengviet.dart';

class DropDownSearchBase extends StatefulWidget {
  final String hint;
  final String hintSearch;
  final List<Item> items;
  final double? borderBtn;
  final double? heightBtn;
  final double? widthBtn;
  final double? maxHeight;
  final Color? colorFocus;
  final Function(String?) onChanged;
  final BoxBorder? boxBorderBtn;
  final Color? backgroundBtn;
  final String? selectedValue;
  final Function(String) onSearch;
  final Color? borderColor;
  final double? borderSize;
  final Color? backgroundButton;
  final String? label;
  final double? paddingLabel;
  final TextStyle? labelStyle;
  final bool? isRequired;
  final bool? typeKey;

  const DropDownSearchBase(
      {super.key,
      required this.hint,
      required this.hintSearch,
      required this.items,
      this.borderBtn,
      this.heightBtn,
      this.widthBtn,
      this.maxHeight,
      this.colorFocus,
      required this.onChanged,
      this.boxBorderBtn,
      this.backgroundBtn,
      this.selectedValue,
      required this.onSearch,
      this.borderColor,
      this.borderSize,
      this.backgroundButton,
      this.label,
      this.paddingLabel,
      this.labelStyle,
      this.isRequired,
      this.typeKey});

  @override
  State<DropDownSearchBase> createState() => _DropDownSearchBaseState();
}

class _DropDownSearchBaseState extends State<DropDownSearchBase> {
  String? selectedValue;
  final TextEditingController textSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.selectedValue != "") {
      setState(() {
        selectedValue = null;
      });
    }

    return SizedBox(
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
              items: widget.items.map((item) {
                final index = widget.items.indexOf(item);
                return DropdownMenuItem<String>(
                    key: Key(item.key),
                    value: item.key,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          TextBase(
                            text: item.value as String,
                            style: TextStyle(
                              fontFamily: Fonts.Lexend.name,
                              fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                              fontWeight: FontWeight.w200,
                              color: ColorConstants.BLACK,
                            ),
                          ),
                        ],
                      ),
                    ));
              }).toList(),
              value: widget.selectedValue ?? selectedValue,
              onChanged: (value) {
                widget.onChanged(value);
                setState(() {
                  selectedValue = value;
                });
              },
              buttonStyleData: ButtonStyleData(
                padding: const EdgeInsets.only(left: 10, right: 5, top: 0),
                height: widget.heightBtn ?? DimensionsHelper.ONE_UNIT_SIZE * 50,
                width: widget.widthBtn ?? DimensionsHelper.iziSize.width,
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
              dropdownStyleData: DropdownStyleData(
                  maxHeight:
                      widget.maxHeight ?? DimensionsHelper.ONE_UNIT_SIZE * 300,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
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
                  useRootNavigator: true),
              menuItemStyleData: MenuItemStyleData(
                height: DimensionsHelper.ONE_UNIT_SIZE * 50,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: textSearch,
                searchInnerWidgetHeight: DimensionsHelper.ONE_UNIT_SIZE * 60,
                searchInnerWidget: Container(
                  height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                  margin: EdgeInsets.symmetric(
                      horizontal: DimensionsHelper.SPACE_SIZE_1X,
                      vertical: DimensionsHelper.SPACE_SIZE_1X),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textSearch,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      hintText: widget.hintSearch,
                      hintStyle: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                        fontWeight: FontWeight.w200,
                        color: ColorConstants.PLACE.withOpacity(0.8),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: ColorConstants.BORDER, width: 0.2)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: widget.colorFocus ?? Colors.grey),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  widget.onSearch(searchValue);
                  final string = widget.items
                      .firstWhere((element) => element.key == item.value);
                  return TiengViet.parse(string.value)
                      .toString()
                      .toLowerCase()
                      .contains(TiengViet.parse(searchValue.toLowerCase()));
                },
              ),
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textSearch.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
