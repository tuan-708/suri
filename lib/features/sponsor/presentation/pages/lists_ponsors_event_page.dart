import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_ponsors_event_page_arguments.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_bloc.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_event.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_state.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/widgets/item_sponsor_checkin.dart';

class ListSponsorsEventPage extends StatefulWidget {
  const ListSponsorsEventPage({super.key, required this.args});
  final ListSponsorsEventPageArguments args;

  @override
  State<ListSponsorsEventPage> createState() => _ListSponsorsEventPageState();
}

class _ListSponsorsEventPageState extends State<ListSponsorsEventPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late bool isAll = true;

  @override
  void initState() {
    super.initState();

    context.read<SponsorBloc>().add(GetListStoreCheckinEvent(widget.args.id));
  }

  void _onRefresh() async {
    context.read<SponsorBloc>().add(GetListStoreCheckinEvent(widget.args.id));
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  Row _tab() {
    return Row(
      children: [
        _button(
          isAllSelected: true,
          title: "Tất cả",
          onChange: () {
            setState(() {
              isAll = true;
            });
          },
        ),
        SizedBox(
          width: DimensionsHelper.SPACE_SIZE_3X,
        ),
        _button(
          isAllSelected: false,
          title: "Đã check in",
          onChange: () {
            setState(() {
              isAll = false;
            });
          },
        ),
      ],
    );
  }

  Expanded _button({String? title, bool? isAllSelected, Function()? onChange}) {
    return Expanded(
      child: GestureDetector(
        onTap: onChange,
        child: Container(
          decoration: BoxDecoration(
              color: isAllSelected == isAll
                  ? ColorConstants.PRIMARY_1
                  : ColorConstants.WHITE,
              border: Border.all(color: ColorConstants.WHITE, width: 3),
              borderRadius: BorderRadius.all(
                  Radius.circular(DimensionsHelper.BLUR_RADIUS_3X))),
          padding: EdgeInsets.symmetric(
              vertical: DimensionsHelper.ONE_UNIT_SIZE * 15),
          child: Center(
              child: TextBase(
            text: '$title',
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
              fontWeight: FontWeight.w400,
              color: isAllSelected == isAll
                  ? ColorConstants.WHITE
                  : ColorConstants.BLACK,
            ),
          )),
        ),
      ),
    );
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
            _tab(),
            SizedBox(
              height: DimensionsHelper.HORIZONTAL_SCREEN,
            ),
            BlocBuilder<SponsorBloc, SponsorState>(
              buildWhen: (previous, current) {
                return current is ListStoreCheckinLoading ||
                    current is ListStoreCheckinSuccess ||
                    current is ListStoreCheckinFailure;
              },
              builder: (context, state) {
                if (state is ListStoreCheckinLoading) {
                  return const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(strokeWidth: 1.5)),
                  );
                }

                if (state is ListStoreCheckinSuccess &&
                    isAll == false &&
                    state.list
                        .where((e) => e.isChecked == true)
                        .toList()
                        .isEmpty) {
                  return const Expanded(
                      child: Center(
                    child: BoxEmpty(
                      title: 'Bạn chưa checkin tại gian hàng ',
                    ),
                  ));
                }

                if (state is ListStoreCheckinSuccess) {
                  final listSponsor = isAll
                      ? state.list
                      : state.list.where((e) => e.isChecked == true).toList();
                  return Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
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
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: DimensionsHelper.HORIZONTAL_SCREEN,
                          );
                        },
                        itemBuilder: (context, index) {
                          return ItemSponsorCheckin(
                            key: Key('${listSponsor[index].id}'),
                            item: listSponsor[index],
                          );
                        },
                        itemCount: listSponsor.length,
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
                      child: const Center(
                        child: BoxEmpty(
                          title: 'Sự kiện chưa có gian hàng',
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
        title: "Danh sách gian hàng",
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
