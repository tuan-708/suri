import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_bloc.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_event.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_state.dart';
import 'package:suri_checking_event_app/features/gift/presentation/widgets/item_gift_home.dart';
import 'package:suri_checking_event_app/features/gift/presentation/widgets/item_gift_loading.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';

class GiftPage extends StatefulWidget {
  const GiftPage({super.key});

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final _sharedHelper = sl.get<SharedPreferenceHelper>();

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
    final profile = BlocProvider.of<MainBloc>(context);

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            SizedBox(
              height: DimensionsHelper.HORIZONTAL_SCREEN,
            ),
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

                if (state is ListGiftOfAccountSuccess) {
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
                          return ItemGiftHome(
                            key: Key("${state.gifts[index].id}"),
                            item: state.gifts[index],
                            accountId: profile.state.profile!.id!,
                          );
                        },
                        itemCount: state.gifts.length,
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

  Container _header() {
    return Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        padding: EdgeInsets.symmetric(
          vertical: DimensionsHelper.ONE_UNIT_SIZE * 15,
        ),
        color: Colors.white,
        height: DimensionsHelper.ONE_UNIT_SIZE * 80,
        width: DimensionsHelper.iziSize.width,
        child: Center(
          child: TextBase(
            text: "Quà của bạn",
            style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                color: ColorConstants.BLACK,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400),
          ),
        ));
  }
}
