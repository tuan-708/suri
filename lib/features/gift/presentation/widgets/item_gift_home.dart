import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/price_helper.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/gift_account_entity.dart';
import 'package:intl/intl.dart';

class ItemGiftHome extends StatelessWidget {
  ItemGiftHome({super.key, required this.item, required this.accountId});

  GiftAccountEntity item;
  int accountId;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, 4))
            ],
            borderRadius:
                BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
            color: ColorConstants.WHITE),
        padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
        child: Column(
          children: [
            _giftInfo(context),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_2X,
            ),
            _eventInfo(context)
          ],
        ));
  }

  Container _eventInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_1X),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_3X),
          color: ColorConstants.PRIMARY_4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _eventImage(context),
          SizedBox(
            width: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBase(
                  text: item.eventName!,
                  maxLine: 2,
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.BLACK,
                  )),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_1X * 0.7,
              ),
              Row(
                children: [
                  ImageBase(ImagePathConstants.IC_ADDRESS),
                  SizedBox(
                    width: DimensionsHelper.SPACE_SIZE_1X,
                  ),
                  Expanded(
                    child: TextBase(
                        maxLine: 2,
                        text: item.eventInfo!,
                        style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                          fontWeight: FontWeight.w200,
                          color: ColorConstants.BLACK,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_1X * 0.7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBase(
                      text: DateFormat('dd.MM.yyyy - hh:mm')
                          .format(item.eventStartDate!),
                      style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.PRIMARY_1,
                      )),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  Row _giftInfo(BuildContext context) {
    return Row(
      children: [
        _giftImage(context),
        SizedBox(
          width: DimensionsHelper.SPACE_SIZE_2X,
        ),
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBase(
                            text: item.eventGiftName!,
                            maxLine: 2,
                            style: TextStyle(
                                fontFamily: Fonts.Lexend.name,
                                color: ColorConstants.BLACK,
                                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                                fontWeight: FontWeight.w400),
                          ),
                           TextBase(
                        text: item.eventGiftTypeName!,
                        maxLine: 2,
                        style: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            color: ColorConstants.BLACK,
                            fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                            fontWeight: FontWeight.w200),
                      ),
                        ],
                      ),
                    ),
                    if (item.accountGiftStatusId == 1002)
                      QrImageView(
                        data: base64Encode(utf8.encode(
                            "{\"GiftId\": ${item.id}, \"AccountId\": $accountId, \"fm\": \"scGift\"}")),
                        version: QrVersions.auto,
                        size: DimensionsHelper.ONE_UNIT_SIZE * 90,
                      ),
                    if (item.accountGiftStatusId == 1001)
                      SizedBox(
                        height: DimensionsHelper.ONE_UNIT_SIZE * 40,
                        child: TextBase(
                          text: 'Đã nhận',
                          maxLine: 2,
                          style: TextStyle(
                              fontFamily: Fonts.Lexend.name,
                              color: ColorConstants.PRIMARY_3,
                              fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
               
                if(item.price != null)
                  Row(
                    children: [
                      TextBase(
                        text: "Giá trị lên đến: ",
                        style: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            color: ColorConstants.BLACK,
                            fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                            fontWeight: FontWeight.w200),
                      ),
                      TextBase(
                        text: PriceHelper.currencyConverterVND(item.price!),
                        style: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            color: ColorConstants.PRIMARY_1,
                            fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  GestureDetector _giftImage(context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, AppRoutes.GIFT_EVENT_DETAIL_PAGE);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
        child: ImageBase(
          StringValid.nullOrEmpty(item.photo)
              ? ImagePathConstants.IMAGE_GIFT
              : "$BASE_URL${item.photo}",
          height: DimensionsHelper.ONE_UNIT_SIZE * 134,
          width: DimensionsHelper.ONE_UNIT_SIZE * 170,
        ),
      ),
    );
  }

  GestureDetector _eventImage(context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, AppRoutes.EVENT_DETAIL_PAGE);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
        child: ImageBase(
          StringValid.nullOrEmpty(item.eventPhoto)
              ? ImagePathConstants.IMAGE_GIFT
              : "$BASE_URL${item.eventPhoto}",
          height: DimensionsHelper.ONE_UNIT_SIZE * 100,
          width: DimensionsHelper.ONE_UNIT_SIZE * 120,
        ),
      ),
    );
  }
}
