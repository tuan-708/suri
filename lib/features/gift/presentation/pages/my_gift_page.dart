import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_bloc.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_event.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_state.dart';
import 'package:suri_checking_event_app/features/gift/presentation/widgets/item_gift_loading.dart';

class MyGiftPage extends StatefulWidget {
  const MyGiftPage({super.key});

  @override
  State<MyGiftPage> createState() => _MyGiftPageState();
}

class _MyGiftPageState extends State<MyGiftPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    context.read<GiftBloc>().add(GetListGiftOfAccount());
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();

    context.read<GiftBloc>().add(GetListGiftOfAccount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        width: DimensionsHelper.iziSize.width,
        height: DimensionsHelper.iziSize.height,
        padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              ImagePathConstants.IMAGE_BG_EVENT_SPECIAL,
            ),
          ),
        ),
        child: Column(
          children: [
            BlocBuilder<GiftBloc, GiftState>(
              buildWhen: (previous, current) {
                return current is ListGiftOfAccountLoading ||
                    current is ListGiftOfAccountSuccess ||
                    current is ListGiftOfAccountFailure;
              },
              builder: (context, state) {
                if (state is ListGiftOfAccountLoading) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: DimensionsHelper.HORIZONTAL_SCREEN,
                        );
                      },
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const ItemGiftLoading();
                      },
                    ),
                  );
                }

                if (state is ListGiftOfAccountFailure) {
                  return Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: ClassicHeader(
                        textStyle: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            fontWeight: FontWeight.w200),
                        refreshingText: "Cuộn xuống để làm mới",
                        releaseText: "Kéo xuống để làm mới dữ liệu",
                        completeText: "Dữ liệu làm mới thành công",
                        idleText: "Làm mới dữ liệu",
                        failedText: "Làm mới dữ liệu bị lỗi",
                      ),
                      footer: ClassicFooter(
                        textStyle: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            fontWeight: FontWeight.w200),
                        loadingText: "Đang tải...",
                        noDataText: 'Không có dữ liệu',
                        canLoadingText: 'Cuộn lên để tải thêm dữ liệu',
                        failedText: 'Tải thêm lỗi dữ liệu',
                        idleText: 'Cuộn lên để tải thêm dữ liệu',
                      ),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: DimensionsHelper.SPACE_SIZE_5X,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            padding:
                                EdgeInsets.all(DimensionsHelper.SPACE_SIZE_2X),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    DimensionsHelper.BORDER_RADIUS_4X)),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          DimensionsHelper.BORDER_RADIUS_4X)),
                                  clipBehavior: Clip.hardEdge,
                                  child: ImageBase(
                                    ImagePathConstants.IMAGE_GIFT,
                                    width: DimensionsHelper.ONE_UNIT_SIZE * 125,
                                    height:
                                        DimensionsHelper.ONE_UNIT_SIZE * 125,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                SizedBox(
                                  width: DimensionsHelper.SPACE_SIZE_2X,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBase(
                                        text: "Quà tặng check-in sớm",
                                        style: TextStyle(
                                          fontFamily: Fonts.Lexend.name,
                                          fontSize:
                                              DimensionsHelper.FONT_SIZE_SPAN *
                                                  .95,
                                          fontWeight: FontWeight.w300,
                                          color: ColorConstants.BLACK,
                                        )),
                                    Row(
                                      children: [
                                        TextBase(
                                            text: "Thời gian check in:  ",
                                            style: TextStyle(
                                              fontFamily: Fonts.Lexend.name,
                                              fontSize: DimensionsHelper
                                                      .FONT_SIZE_SPAN *
                                                  .95,
                                              fontWeight: FontWeight.w200,
                                              color: ColorConstants.BLACK,
                                            )),
                                        TextBase(
                                            text: "09:00",
                                            style: TextStyle(
                                              fontFamily: Fonts.Lexend.name,
                                              fontSize: DimensionsHelper
                                                      .FONT_SIZE_SPAN *
                                                  .95,
                                              fontWeight: FontWeight.w300,
                                              color: ColorConstants.BLACK,
                                            )),
                                      ],
                                    )
                                  ],
                                ))
                              ],
                            ),
                          );
                        },
                        itemCount: 10,
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: ClassicHeader(
                        textStyle: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            fontWeight: FontWeight.w200),
                        refreshingText: "Cuộn xuống để làm mới",
                        releaseText: "Kéo xuống để làm mới dữ liệu",
                        completeText: "Dữ liệu làm mới thành công",
                        idleText: "Làm mới dữ liệu",
                        failedText: "Làm mới dữ liệu bị lỗi",
                      ),
                      footer: ClassicFooter(
                        textStyle: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            fontWeight: FontWeight.w200),
                        loadingText: "Đang tải...",
                        noDataText: 'Không có dữ liệu',
                        canLoadingText: 'Cuộn lên để tải thêm dữ liệu',
                        failedText: 'Tải thêm lỗi dữ liệu',
                        idleText: 'Cuộn lên để tải thêm dữ liệu',
                      ),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: const Center(
                        child: BoxEmpty(
                          title: 'Hiện tại bạn chưa có quà',
                        ),
                      )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Quà của tôi",
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
