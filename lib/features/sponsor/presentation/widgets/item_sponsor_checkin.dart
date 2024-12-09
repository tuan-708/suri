import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/store_checkin_entity.dart';

class ItemSponsorCheckin extends StatelessWidget {
  const ItemSponsorCheckin({super.key, required this.item});
  final StoreCheckinEntity item;

  Color switchColor(String value) {
    switch (value) {
      case 'Đồng':
        return Colors.brown;
      case 'Bạc':
        return Colors.grey;
      case 'Vàng':
        return Colors.amber;
      case 'Kim cương':
        return Colors.blueAccent;
      case 'Đồng tài trợ':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_2X),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
          color: Colors.white,
          border: Border.all(
            color: ColorConstants.PLACE3,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
                border: Border.all(
                  color: ColorConstants.PLACE3,
                )),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
              child: ImageBase(
                StringValid.url(
                    item.photo ?? ImagePathConstants.IMAGE_USER_TEST),
                fit: BoxFit.scaleDown,
                height: DimensionsHelper.ONE_UNIT_SIZE * 125,
                width: DimensionsHelper.ONE_UNIT_SIZE * 125,
              ),
            ),
          ),
          SizedBox(
            width: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBase(
                    text: item.name,
                    maxLine: 1,
                    style: TextStyle(
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                        fontFamily: Fonts.Lexend.name,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    width: DimensionsHelper.ONE_UNIT_SIZE * 40,
                    height: DimensionsHelper.ONE_UNIT_SIZE * 40,
                    decoration: BoxDecoration(
                        color: ColorConstants.PRIMARY_1,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(DimensionsHelper.ONE_UNIT_SIZE * 4),
                    child: Center(
                      child: TextBase(
                        text: item.point == null ? '+0' : '+${item.point}',
                        maxLine: 1,
                        style: TextStyle(
                            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.8,
                            fontFamily: Fonts.Lexend.name,
                            color: Colors.white,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBase(
                      text: "Khu vực:",
                      style: TextStyle(
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                          fontFamily: Fonts.Lexend.name,
                          fontWeight: FontWeight.w200)),
                  TextBase(
                      text: item.position != "" ? item.position : "Chưa rõ",
                      style: TextStyle(
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                          fontFamily: Fonts.Lexend.name,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBase(
                      text: "Nhà tài trợ:",
                      style: TextStyle(
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                          fontFamily: Fonts.Lexend.name,
                          fontWeight: FontWeight.w200)),
                  TextBase(
                      text: item.storeRankingName != ""
                          ? item.storeRankingName
                          : "Chưa rõ",
                      style: TextStyle(
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                          color: switchColor(item.storeRankingName),
                          fontFamily: Fonts.Lexend.name,
                          fontWeight: FontWeight.w400)),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
