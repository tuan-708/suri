import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_bloc.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_event.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_state.dart';
import 'package:suri_checking_event_app/features/gift/presentation/widgets/item_event_gift.dart';
import 'package:suri_checking_event_app/features/gift/presentation/widgets/item_gift_loading.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_gift_event_arguments.dart';

class MyGiftEventPage extends StatefulWidget {
  const MyGiftEventPage({super.key, required this.args});
  final ListGiftEventArguments args;

  @override
  State<MyGiftEventPage> createState() => _MyGiftEventPageState();
}

class _MyGiftEventPageState extends State<MyGiftEventPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late int id;

  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  void _onRefresh() async {
    context.read<GiftBloc>().add(GetListGiftEvent(id));
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

    id = widget.args.id;

    context.read<GiftBloc>().add(GetListGiftEvent(id));
  }

  @override
  Widget build(BuildContext context) {
    final profile = BlocProvider.of<MainBloc>(context);

    return Scaffold(
      appBar: _header(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: DimensionsHelper.HORIZONTAL_SCREEN,
            ),
            BlocBuilder<GiftBloc, GiftState>(
              buildWhen: (previous, current) {
                return current is GetListGiftEventLoading ||
                    current is GetListGiftEventSuccess ||
                    current is GetListGiftEventFailure;
              },
              builder: (context, state) {
                if (state is GetListGiftEventLoading) {
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

                if (state is GetListGiftEventSuccess) {
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
                          return ItemEventGift(
                            key: Key("${state.list[index].id}"),
                            item: state.list[index],
                            accountId: profile.state.profile!.id!,
                          );
                        },
                        itemCount: state.list.length,
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
        title: "Quà của bạn",
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
