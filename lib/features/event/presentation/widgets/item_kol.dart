import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/kol_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/list_kol_entity.dart';

class ItemKol extends StatelessWidget {
  const ItemKol({super.key, required this.item});
  final KOLDetailEntity item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final sharedHelper = sl.get<SharedPreferenceHelper>();
        if (StringValid.nullOrEmpty(sharedHelper.getJwtToken)) {
          Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
        } else {
          KOLDetailsEntity args = KOLDetailsEntity(
              active: item.active,
              address: item.address,
              catagoryId: item.catagoryId,
              description: item.description,
              createdTime: item.createdTime,
              dob: item.dob,
              gender: item.gender,
              id: item.id,
              kolVotes: item.kolVotes,
              info: item.info,
              name: item.name,
              number: item.number,
              photo: item.photo,
              photoThumb: item.photoThumb,
              isVotingEnabled: item.isVotingEnabled,
              catagory: item.catagory,
              catagoryName: "",
              totalVotesPerKol: item.totalVotesPerKol!,
              toTalVote: item.toTalVote!);
          Navigator.pushNamed(context, AppRoutes.KOL_DETAIL_PAGE,
              arguments: args);
        }
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
            border: Border.all(color: ColorConstants.PRIMARY_1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
              child: ImageBase(
                "$BASE_URL${item.photoThumb}",
                height: DimensionsHelper.ONE_UNIT_SIZE * 170 * 1.25,
                width: DimensionsHelper.ONE_UNIT_SIZE * 170 * 1.25,
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_2X),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBase(
                      text: item.name.toUpperCase(),
                      style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.ONE_UNIT_SIZE * 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBase(
                          text: "SBD: ${item.number}".toUpperCase(),
                          style: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            fontSize: DimensionsHelper.ONE_UNIT_SIZE * 21,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )),
                      TextBase(
                          text: "XH:  ${item.indexTotalVotesPerKol}"
                              .toUpperCase(),
                          style: TextStyle(
                              fontFamily: Fonts.Lexend.name,
                              fontSize: DimensionsHelper.ONE_UNIT_SIZE * 21,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.PRIMARY_1)),
                    ],
                  ),
                  SizedBox(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 10,
                  ),
                  Row(
                    children: [
                      TextBase(
                          text: "Điểm bình chọn: ",
                          style: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            fontSize: DimensionsHelper.ONE_UNIT_SIZE * 21,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )),
                      TextBase(
                          text: " ${item.totalVotesPerKol}".toUpperCase(),
                          style: TextStyle(
                              fontFamily: Fonts.Lexend.name,
                              fontSize: DimensionsHelper.ONE_UNIT_SIZE * 23,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.PRIMARY_1)),
                    ],
                  ),
                  SizedBox(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 10,
                  ),
                  ButtonBase(
                    onTap: () {
                      KOLDetailsEntity args = KOLDetailsEntity(
                          active: item.active,
                          address: item.address,
                          catagoryId: item.catagoryId,
                          description: item.description,
                          createdTime: item.createdTime,
                          dob: item.dob,
                          gender: item.gender,
                          id: item.id,
                          kolVotes: item.kolVotes,
                          info: item.info,
                          name: item.name,
                          number: item.number,
                          photo: item.photo,
                          photoThumb: item.photoThumb,
                          isVotingEnabled: item.isVotingEnabled,
                          catagory: item.catagory,
                          catagoryName: "",
                          totalVotesPerKol: item.totalVotesPerKol!,
                          toTalVote: item.toTalVote!);
                      Navigator.pushNamed(context, AppRoutes.KOL_DETAIL_PAGE,
                          arguments: args);
                    },
                    margin: const EdgeInsets.all(0),
                    borderRadius: DimensionsHelper.BLUR_RADIUS_4X,
                    fontSizedLabel: DimensionsHelper.ONE_UNIT_SIZE * 23,
                    height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                    label: "Bình chọn",
                    colorText: ColorConstants.BLACK,
                    colorBG: ColorConstants.PLACE1,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
