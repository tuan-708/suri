import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class VotingProcessPage extends StatefulWidget {
  const VotingProcessPage({super.key});

  @override
  State<VotingProcessPage> createState() => _VotingProcessPageState();
}

class _VotingProcessPageState extends State<VotingProcessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBase(
                text: "Bước 1:",
                maxLine: 2,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.PRIMARY_1,
                )),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_2X,
            ),
            TextBase(
                text:
                    "Truy cập vào cổng bình chọn Biệt Đội KOLs Nhí 2024 qua mã QR code hoặc qua đường link: ///",
                maxLine: 3,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                  fontWeight: FontWeight.w200,
                  color: ColorConstants.BLACK,
                )),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_2X,
            ),
            TextBase(
                text: "Bước 2:",
                maxLine: 2,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.PRIMARY_1,
                )),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_2X,
            ),
            TextBase(
                text:
                    "Tại danh sách bình chọn, tìm kiếm thí sinh yêu thích, nhấn nút 'Bình chọn' để truy cập vào trang bình chọn của thí sinh.",
                maxLine: 3,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                  fontWeight: FontWeight.w200,
                  color: ColorConstants.BLACK,
                )),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_2X,
            ),
            TextBase(
                text: "Bước 3:",
                maxLine: 2,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.PRIMARY_1,
                )),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_2X,
            ),
            TextBase(
                text:
                    "Nhấn vào 'Bình chọn ngay' để bình chọn cho thí sinh mình yêu thích",
                maxLine: 3,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                  fontWeight: FontWeight.w200,
                  color: ColorConstants.BLACK,
                )),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_2X,
            ),
            TextBase(
                text: "Lưu ý:",
                maxLine: 2,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.BLACK,
                )),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_2X,
            ),
            TextBase(
                text: "Mỗi lượt bình chọn tương ứng với 1 điểm",
                maxLine: 3,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w200,
                  color: ColorConstants.BLACK,
                )),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_2X,
            ),
            TextBase(
                text: "Mỗi tài khoản được bình chọn 3 lượt/ngày",
                maxLine: 3,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w200,
                  color: ColorConstants.BLACK,
                )),
          ],
        ),
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Quy trình bình chọn",
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        titleStyle: TextStyle(
          fontFamily: Fonts.Lexend.name,
          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
          fontWeight: FontWeight.w400,
          color: ColorConstants.BLACK,
        ));
  }
}
