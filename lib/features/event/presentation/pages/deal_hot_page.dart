import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class DealHotPage extends StatefulWidget {
  const DealHotPage({super.key});

  @override
  State<DealHotPage> createState() => _DealHotPageState();
}

class _DealHotPageState extends State<DealHotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageBase(ImagePathConstants.IMG_DEAL_HOT_1),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              ImageBase(ImagePathConstants.IMG_DEAL_HOT_2),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              ImageBase(ImagePathConstants.IMG_DEAL_HOT_3),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              ImageBase(ImagePathConstants.IMG_DEAL_HOT_4),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              ImageBase(ImagePathConstants.IMG_DEAL_HOT_5),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              ImageBase(ImagePathConstants.IMG_DEAL_HOT_6),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              ImageBase(ImagePathConstants.IMG_DEAL_HOT_7)
            ],
          ),
        ),
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: 'Deal hot',
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
