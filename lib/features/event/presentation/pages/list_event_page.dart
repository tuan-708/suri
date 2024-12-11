import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_event_payload.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';
import 'package:suri_checking_event_app/features/event/presentation/widgets/item_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/widgets/loading_list_event.dart';
import 'package:intl/intl.dart';

class ListEventPage extends StatefulWidget {
  const ListEventPage({super.key});

  @override
  State<ListEventPage> createState() => _ListEventPageState();
}

class _ListEventPageState extends State<ListEventPage>
    with TickerProviderStateMixin {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int _selectedIndex = 0;
  late int pageIndex = 1;
  late int pageSize = 5;
  late int? statusId = statusEvent['Sắp diễn ra'];

  ListEventsPayload payloadEvents = ListEventsPayload(
      pageIndex: 1, pageSize: 5, statusId: statusEvent['Sắp diễn ra']);

  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    pageIndex = 1;
    payloadEvents.pageIndex = 1;
    payloadEvents.pageSize = 5;

    context.read<EventBloc>().add(GetListEventRefresh(payloadEvents));
  }

  void _onLoading() async {
    pageIndex = pageIndex + 1;
    payloadEvents.pageIndex = pageIndex;
    context.read<EventBloc>().add(GetListEventPaging(payloadEvents));
  }

  void _onTabTapped(int index, String title) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        _scrollToTop();
        pageIndex = 1;
        payloadEvents.pageIndex = 1;
        payloadEvents.statusId = statusEvent['Sắp diễn ra'];
        context.read<EventBloc>().add(GetListEventPaging(payloadEvents));
        break;
      case 1:
        _scrollToTop();
        pageIndex = 1;
        payloadEvents.pageIndex = 1;
        payloadEvents.statusId = statusEvent['Đã tham gia'];
        context.read<EventBloc>().add(GetListEventPaging(payloadEvents));
        break;
      case 2:
        _scrollToTop();
        pageIndex = 1;
        payloadEvents.pageIndex = 1;
        payloadEvents.statusId = statusEvent['Đã diễn ra'];
        context.read<EventBloc>().add(GetListEventPaging(payloadEvents));
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<EventBloc>().add(GetListEventPaging(payloadEvents));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _header(),
        body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _tabView(),
                _indicator(),
                Expanded(
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
                      child: BlocBuilder<EventBloc, EventState>(
                          buildWhen: (previous, current) {
                        if (current is EventsPagingSuccess) {
                          _refreshController.loadComplete();
                          _refreshController.refreshCompleted();
                        }
                        if (current is EventsPagingFailure) {
                          _refreshController.refreshCompleted();
                          _refreshController.refreshCompleted();
                        }
                        return current is EventsPagingLoading ||
                            current is EventsPagingSuccess ||
                            current is EventsPagingFailure;
                      }, builder: (context, state) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          controller: _scrollController,
                          child: Column(
                            children: [
                              if (state is EventsPagingLoading)
                                const LoadingListEvents(),
                              if (state is EventsPagingSuccess)
                                listEventsSuccess(state)
                              else
                                BoxEmpty(
                                  height: DimensionsHelper.iziSize.height - 200,
                                  title: 'Không có sự kiện',
                                )
                            ],
                          ),
                        );
                      })),
                ),
              ]),
        ));
  }

  ListView listEventsSuccess(EventsPagingSuccess state) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Container(
          width: DimensionsHelper.iziSize.width,
          height: 2,
          color: ColorConstants.BORDER,
          margin: EdgeInsets.symmetric(
              horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
        );
      },
      itemBuilder: (context, index) {
        return ItemEvent(
            key: Key('${state.list![index].id}'),
            id: state.list![index].id,
            imageUrl: state.list![index].photo,
            name: state.list![index].name,
            info: state.list![index].info,
            isSpecialEvent: state.list![index].isSpecialEvent,
            startDate: DateFormat('dd.MM.yyyy - hh:mm')
                .format(state.list![index].startDate));
      },
      itemCount: state.list!.length,
    );
  }

  AnimatedContainer _indicator() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(
          left: _selectedIndex * (DimensionsHelper.iziSize.width / 3)),
      height: 2,
      width: DimensionsHelper.iziSize.width / 3,
      decoration: BoxDecoration(
          color: ColorConstants.PRIMARY_1,
          borderRadius: BorderRadius.circular(2)),
    );
  }

  Row _tabView() {
    return Row(
      children: [
        _itemTab(index: 0, title: "Sắp diễn ra"),
        _itemTab(index: 1, title: "Đang diễn ra"),
        _itemTab(index: 2, title: "Đã diễn ra"),
      ],
    );
  }

  Expanded _itemTab({required int index, required String title}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => {_onTabTapped(index, title)},
        child: AbsorbPointer(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                fontWeight:
                    _selectedIndex == index ? FontWeight.w300 : FontWeight.w200,
                color: _selectedIndex == index
                    ? ColorConstants.PRIMARY_1
                    : ColorConstants.BLACK,
              ),
            )),
          ),
        ),
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Sự kiện",
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
