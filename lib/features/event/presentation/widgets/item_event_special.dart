import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class ItemEventSpecial extends StatefulWidget {
  const ItemEventSpecial(
      {super.key,
      required this.item,
      required this.index,
      required this.icon,
      required this.onTap});
  final String item;
  final String icon;
  final int index;
  final Function(int) onTap;

  @override
  State<ItemEventSpecial> createState() => _ItemEventSpecialState();
}

class _ItemEventSpecialState extends State<ItemEventSpecial> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DimensionsHelper.iziSize.width,
      height: DimensionsHelper.ONE_UNIT_SIZE * 200,
      child: GestureDetector(
        onTap: () {
          widget.onTap(widget.index);
        },
        child: AbsorbPointer(
          child: Column(
            children: [
              Container(
                width: DimensionsHelper.iziSize.width / 3,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 4))
                    ],
                    borderRadius: BorderRadius.circular(
                        DimensionsHelper.ONE_UNIT_SIZE * 30)),
                child: ImageBase(
                  widget.icon,
                ),
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              TextBase(
                textAlign: TextAlign.center,
                text: widget.item,
                maxLine: 2,
                style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    color: ColorConstants.BLACK,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
