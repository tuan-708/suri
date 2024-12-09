import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/sponsor_detail_page_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_bloc.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_event.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_state.dart';

class SponsorDetailPage extends StatefulWidget {
  const SponsorDetailPage({super.key, required this.args});
  final SponsorDetailPageArguments args;

  @override
  State<SponsorDetailPage> createState() => _SponsorDetailPageState();
}

class _SponsorDetailPageState extends State<SponsorDetailPage> {
  late int id;

  @override
  void initState() {
    super.initState();
    id = widget.args.id;

    context.read<SponsorBloc>().add(GetSponsorDetail(id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SponsorBloc, SponsorState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _header(state),
          body: Container(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  if (state is GetSponsorDetailLoading)
                    SizedBox(
                        height: DimensionsHelper.iziSize.height - 100,
                        child: const Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )))
                  else if (state is GetSponsorDetailSuccess)
                    Column(
                      children: [
                        _banner(state),
                        Container(
                          padding: EdgeInsets.only(
                            top: DimensionsHelper.ONE_UNIT_SIZE * 120,
                            left: DimensionsHelper.HORIZONTAL_SCREEN,
                            right: DimensionsHelper.HORIZONTAL_SCREEN,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text("Thông tin nhà tài trợ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: Fonts.Lexend.name,
                                      fontSize:
                                          DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstants.BLACK,
                                    )),
                              ),
                              SizedBox(
                                height: DimensionsHelper.SPACE_SIZE_2X,
                              ),
                              Text(state.sponsorDetail.description,
                                  style: TextStyle(
                                    fontFamily: Fonts.Lexend.name,
                                    fontSize:
                                        DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                                    fontWeight: FontWeight.w200,
                                    color: ColorConstants.BLACK,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Stack _banner(GetSponsorDetailSuccess state) {
    return Stack(clipBehavior: Clip.none, children: [
      ImageBase(
        "$BASE_URL${state.sponsorDetail.photo}",
        width: DimensionsHelper.iziSize.width,
        height: DimensionsHelper.ONE_UNIT_SIZE * 400,
        fit: BoxFit.fitWidth,
      ),
      Positioned(
          bottom: -DimensionsHelper.ONE_UNIT_SIZE * 100,
          child: Container(
            padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
            margin: EdgeInsets.symmetric(
                horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
            width: DimensionsHelper.iziSize.width -
                DimensionsHelper.HORIZONTAL_SCREEN * 2,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 4))
                ],
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_5X),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBase(
                    text: state.sponsorDetail.name,
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
                          text:
                              StringValid.nullOrEmpty(state.sponsorDetail.info!)
                                  ? "Chưa có thông tin"
                                  : state.sponsorDetail.info!,
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
              ],
            ),
          )),
    ]);
  }

  AppBarBase _header(state) {
    return AppBarBase(
        title: state is GetSponsorDetailSuccess
            ? state.sponsorDetail.name
            : "Đang tải ...",
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
