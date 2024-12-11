import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_linnear_gradient.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';

class ModalVoteSuccess extends StatelessWidget {
  const ModalVoteSuccess({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;
    return SafeArea(
      child: Container(
        child: Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
            height: DimensionsHelper.ONE_UNIT_SIZE * 460,
            width: dialogWidth,
            child: Column(
              children: [
                ImageBase(
                  ImagePathConstants.IMAGE_VOTE_SUCCESS,
                  width: DimensionsHelper.ONE_UNIT_SIZE * 117 * 1.25,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 115 * 1.25,
                ),
                SizedBox(
                  height: DimensionsHelper.SPACE_SIZE_3X,
                ),
                TextBase(
                  maxLine: 3,
                  textAlign: TextAlign.center,
                  text:
                      'Bình chọn thành công. Cảm ơn bạn đã đồng hành cùng $type.',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                ),
                SizedBox(
                  height: DimensionsHelper.SPACE_SIZE_3X,
                ),
                ButtonLinearGradient(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: "Tiếp tục bình chọn",
                  fonSize: DimensionsHelper.FONT_SIZE_SPAN,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                  borderRadius: DimensionsHelper.BLUR_RADIUS_3X,
                ),
                ButtonBase(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.MAIN_PAGE);
                  },
                  colorText: Colors.black,
                  fontSizedLabel: DimensionsHelper.FONT_SIZE_SPAN,
                  colorBG: Colors.white,
                  fillColor: Colors.white,
                  label: 'Về trang chủ',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
