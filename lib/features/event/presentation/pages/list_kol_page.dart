import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/input_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_kol_paging_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/searching_kol_payload.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';
import 'package:suri_checking_event_app/features/event/presentation/widgets/item_kol.dart';
import 'package:suri_checking_event_app/features/event/presentation/widgets/item_kol_loading.dart';

class ListKOLPage extends StatefulWidget {
  const ListKOLPage({super.key});

  @override
  State<ListKOLPage> createState() => _ListKOLPageState();
}

class _ListKOLPageState extends State<ListKOLPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool isKOL = true;
  int pageIndex = 1;
  int pageSize = 5;
  ListKOLPagingPayload payload = ListKOLPagingPayload(
    categoryId: 1001,
    pageIndex: 1,
    pageSize: 5,
  );

  TextEditingController keyword = TextEditingController();

  void _onRefresh() async {
    if(StringValid.nullOrEmpty(keyword.text) ){
    pageIndex = 1;
    payload.pageIndex = 1;
    payload.pageSize = 5;
    payload.categoryId = isKOL ? 1001 : 1002;

    context.read<EventBloc>().add(GetListKOLPagingEvent(payload));
    }else{
         _refreshController.refreshCompleted();
    }

  }

  void _onLoading() async {
        if(StringValid.nullOrEmpty(keyword.text) ){
    pageIndex = pageIndex + 1;
    payload.pageIndex = pageIndex;
    payload.pageSize = 5;
    payload.categoryId = isKOL ? 1001 : 1002;
    context.read<EventBloc>().add(GetListKOLPagingEvent(payload));
        }else{
            

            _refreshController.loadComplete();
        }

  }

  @override
  void initState() {
    super.initState();

    context.read<EventBloc>().add(GetListKOLPagingEvent(payload));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
        child: Column(
          children: [
            InputBase(
                controller: keyword,
                type: InputBaseType.TEXT,
                borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
                isBorder: true,
                height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                suffixIcon: _btnSearch()),
            SizedBox(
              height: DimensionsHelper.HORIZONTAL_SCREEN,
            ),
            _tab(),
            SizedBox(
              height: DimensionsHelper.HORIZONTAL_SCREEN,
            ),
            _listKOLs(),
          ],
        ),
      ),
    );
  }

  GestureDetector _btnSearch() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();

        if (keyword.text != "") {
          SearchingKOLPayload payload = SearchingKOLPayload(
              keyword: keyword.text, categoryId: isKOL ? 1001 : 1002);

          context.read<EventBloc>().add(GetListKOLSearchingEvent(payload));

          return;
        }
        context.read<EventBloc>().add(GetListKOLPagingEvent(payload));
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: ColorConstants.PRIMARY_1,
            borderRadius:
                BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X)),
        child: ImageBase(
          ImagePathConstants.IC_SEARCH,
          width: DimensionsHelper.ONE_UNIT_SIZE * 20,
          height: DimensionsHelper.ONE_UNIT_SIZE * 20,
        ),
      ),
    );
  }

  Expanded _listKOLs() {
    return Expanded(
        child: SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: ClassicHeader(
        textStyle: TextStyle(
            fontFamily: Fonts.Lexend.name, fontWeight: FontWeight.w200),
        refreshingText: "Cuộn xuống để làm mới",
        releaseText: "Kéo xuống để làm mới dữ liệu",
        completeText: "Dữ liệu làm mới thành công",
        idleText: "Làm mới dữ liệu",
        failedText: "Làm mới dữ liệu bị lỗi",
      ),
      footer: ClassicFooter(
        textStyle: TextStyle(
            fontFamily: Fonts.Lexend.name, fontWeight: FontWeight.w200),
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
          if (current is ListKOLPagingSuccess ||
              current is ListKOLPagingFailure) {
            _refreshController.refreshCompleted();

            _refreshController.loadComplete();
          }

          return current is ListKOLPagingLoading ||
              current is ListKOLPagingSuccess ||
              current is ListKOLPagingFailure ||
              current is ListKOLSearchingLoading ||
              current is ListKOLSearchingSuccess ||
              current is ListKOLSearchingFailure;
        },
        builder: (context, state) {
          return SingleChildScrollView(
              child: Column(children: [
            if (state is ListKOLPagingLoading ||
                state is ListKOLSearchingLoading)
              _buildLoadingList()
            else if (state is ListKOLPagingSuccess ||
                state is ListKOLSearchingSuccess)
              _buildSuccessList(state)
            else
              _buildEmptyBox()
          ]));
        },
      ),
    ));
  }

  BoxEmpty _buildEmptyBox() {
    return BoxEmpty(
      height: DimensionsHelper.iziSize.height - 270,
      title: "Không tìm thấy KOL's",
    );
  }

  ListView _buildSuccessList(EventState state) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: DimensionsHelper.HORIZONTAL_SCREEN,
        );
      },
      itemCount: state.list.length,
      itemBuilder: (context, index) {
        return ItemKol(
          key: Key('${state.list[index].id}'),
          item: state.list[index],
        );
      },
    );
  }

  ListView _buildLoadingList() {
    return ListView.separated(
      shrinkWrap: true,
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
        return const ItemKOLLoading();
      },
      itemCount: 10,
    );
  }

  void changeTabKol(bool value) {
    keyword.text = "";
    setState(() {
      isKOL = value;
    });
    pageIndex = 1;

    payload.pageIndex = 1;
    payload.pageSize = 5;
    payload.categoryId = value ? 1001 : 1002;

    context.read<EventBloc>().add(GetListKOLPagingEvent(payload));
  }

  Row _tab() {
    return Row(
      children: [
        _button(
          isSelectedKOL: true,
          title: "KOL's Nhí",
          onChange: () {
            changeTabKol(true);
          },
        ),
        SizedBox(
          width: DimensionsHelper.SPACE_SIZE_3X,
        ),
        _button(
          isSelectedKOL: false,
          title: "Biệt Đội",
          onChange: () {
            changeTabKol(false);
          },
        ),
      ],
    );
  }

  Expanded _button({String? title, bool? isSelectedKOL, Function()? onChange}) {
    return Expanded(
      child: GestureDetector(
        onTap: onChange,
        child: Container(
          decoration: BoxDecoration(
              color: isKOL == isSelectedKOL
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
              color: isKOL == isSelectedKOL
                  ? ColorConstants.WHITE
                  : ColorConstants.BLACK,
            ),
          )),
        ),
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Danh sách KOL's Nhí",
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
