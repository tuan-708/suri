import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_linnear_gradient.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/event/data/models/history_vote_payload.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/list_kol_entity.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';
import 'package:intl/intl.dart';
import 'package:suri_checking_event_app/features/event/presentation/widgets/modal_vote_success.dart';

class KOLDetailPage extends StatefulWidget {
  const KOLDetailPage({super.key, required this.args});
  final KOLDetailsEntity args;

  @override
  State<KOLDetailPage> createState() => _KOLDetailPageState();
}

class _KOLDetailPageState extends State<KOLDetailPage> {
  final _sharedHelper = sl.get<SharedPreferenceHelper>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late int totalVotesPerKol = 0;

  late int pageIndex = 1;
  late int pageSize = 5;
  late int remainVotes = 0;

  HistoryVotePayload payloadHistories =
      HistoryVotePayload(pageIndex: 1, pageSize: 5, kolId: 0);

  @override
  void initState() {
    super.initState();

    payloadHistories.kolId = widget.args.id;

    setState(() {
      totalVotesPerKol = widget.args.totalVotesPerKol;
    });

    context.read<EventBloc>().add(GetListHistoriesVote(payloadHistories));
    context.read<EventBloc>().add(GetRemainingVotes());
  }

  void _onRefresh() async {
    pageIndex = 1;
    payloadHistories.pageIndex = 1;
    payloadHistories.pageSize = 5;

    context.read<EventBloc>().add(GetListHistoriesVote(payloadHistories));
  }

  void _onLoading() async {
    pageIndex = pageIndex + 1;
    payloadHistories.pageIndex = pageIndex;
    _refreshController.refreshCompleted();
    context.read<EventBloc>().add(GetListHistoriesVote(payloadHistories));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              _kolInfo(),
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      ColorConstants.BG_LINEAR_GRADIENT1,
                      ColorConstants.BG_LINEAR_GRADIENT2
                    ])),
                child: Padding(
                  padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
                  child: Column(
                    children: [
                      _title(),
                      _headerTable(),
                      SizedBox(
                        height: 280,
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
                                if (current is ListHistoriesVoteFailure) {
                                  _refreshController.loadComplete();
                                  _refreshController.refreshCompleted();
                                }
                                if (current is ListHistoriesVoteSuccess) {
                                  _refreshController.loadComplete();
                                  _refreshController.refreshCompleted();
                                }
                                return current is ListHistoriesVoteLoading ||
                                    current is ListHistoriesVoteSuccess ||
                                    current is ListHistoriesVoteFailure;
                              },
                              builder: (context, state) {
                                if (state is ListHistoriesVoteLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (state is ListHistoriesVoteSuccess) {
                                  return ListView.builder(
                                    itemCount: state.list.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: index % 2 == 0
                                                ? Colors.white
                                                : Colors.transparent),
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              DimensionsHelper.SPACE_SIZE_2X,
                                          vertical:
                                              DimensionsHelper.SPACE_SIZE_2X,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: DimensionsHelper
                                                      .ONE_UNIT_SIZE *
                                                  70,
                                              child: TextBase(
                                                  text: '${index + 1}',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          Fonts.Lexend.name,
                                                      fontSize: DimensionsHelper
                                                              .ONE_UNIT_SIZE *
                                                          20,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: ColorConstants
                                                          .BLACK)),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextBase(
                                                        text: state.list[index]
                                                            .accountName!,
                                                        style: TextStyle(
                                                            fontFamily: Fonts
                                                                .Lexend.name,
                                                            fontSize:
                                                                DimensionsHelper
                                                                        .ONE_UNIT_SIZE *
                                                                    20,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            color:
                                                                ColorConstants
                                                                    .BLACK)),
                                                    TextBase(
                                                        text: !StringValid
                                                                .nullOrEmpty(
                                                                    state
                                                                        .list[
                                                                            index]
                                                                        .kolPhoneNumber!)
                                                            ? "${state.list[index].kolPhoneNumber!.substring(0, 3)} *** ${state.list[index].kolPhoneNumber!.substring(-1, -3)}"
                                                            : "",
                                                        style: TextStyle(
                                                            fontFamily: Fonts
                                                                .Lexend.name,
                                                            fontSize:
                                                                DimensionsHelper
                                                                        .ONE_UNIT_SIZE *
                                                                    20,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            color:
                                                                ColorConstants
                                                                    .BLACK)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: DimensionsHelper
                                                      .ONE_UNIT_SIZE *
                                                  200,
                                              child: TextBase(
                                                  text: DateFormat(
                                                          'hh:mm - dd/MM/yyyy')
                                                      .format(state.list[index]
                                                          .voteDate!),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          Fonts.Lexend.name,
                                                      fontSize: DimensionsHelper
                                                              .ONE_UNIT_SIZE *
                                                          19,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: ColorConstants
                                                          .BLACK)),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }

                                return const BoxEmpty();
                              },
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _headerTable() {
    return Container(
      color: ColorConstants.PRIMARY_1,
      padding: EdgeInsets.symmetric(
        horizontal: DimensionsHelper.SPACE_SIZE_2X,
        vertical: DimensionsHelper.SPACE_SIZE_2X,
      ),
      child: Row(
        children: [
          SizedBox(
            width: DimensionsHelper.ONE_UNIT_SIZE * 70,
            child: TextBase(
                text: "STT",
                style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.ONE_UNIT_SIZE * 22,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.WHITE)),
          ),
          Expanded(
            child: SizedBox(
              child: TextBase(
                  text: "Mã người bình chọn",
                  style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.ONE_UNIT_SIZE * 22,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.WHITE)),
            ),
          ),
          SizedBox(
            width: DimensionsHelper.ONE_UNIT_SIZE * 200,
            child: TextBase(
                text: "Thời gian",
                style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.ONE_UNIT_SIZE * 22,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.WHITE)),
          ),
        ],
      ),
    );
  }

  Container _title() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: DimensionsHelper.SPACE_SIZE_3X),
      child: Center(
        child: TextBase(
          text: "Lịch sử bình chọn".toUpperCase(),
          style: TextStyle(
            fontFamily: Fonts.SVN.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 1.30,
            fontWeight: FontWeight.w400,
            color: ColorConstants.BLACK,
          ),
        ),
      ),
    );
  }

  Container _kolInfo() {
    return Container(
      margin: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
      decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.PRIMARY_1),
          borderRadius:
              BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
            child: ImageBase(
              "$BASE_URL${widget.args.photo}",
              height: DimensionsHelper.iziSize.width,
              width: DimensionsHelper.iziSize.width,
            ),
          ),
          Container(
            padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBase(
                    text: widget.args.name.toUpperCase(),
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.ONE_UNIT_SIZE * 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBase(
                                text: "SBD: ",
                                style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  fontSize: DimensionsHelper.ONE_UNIT_SIZE * 21,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                )),
                            TextBase(
                                text: widget.args.number.toUpperCase(),
                                style: TextStyle(
                                    fontFamily: Fonts.Lexend.name,
                                    fontSize:
                                        DimensionsHelper.ONE_UNIT_SIZE * 21,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.BLACK)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBase(
                                text: "Năm sinh: ",
                                style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  fontSize: DimensionsHelper.ONE_UNIT_SIZE * 21,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                )),
                            TextBase(
                                text: '${widget.args.dob.year}',
                                style: TextStyle(
                                    fontFamily: Fonts.Lexend.name,
                                    fontSize:
                                        DimensionsHelper.ONE_UNIT_SIZE * 21,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.BLACK)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBase(
                                text: "Quê quán: ",
                                style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  fontSize: DimensionsHelper.ONE_UNIT_SIZE * 21,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                )),
                            TextBase(
                                text: widget.args.address,
                                style: TextStyle(
                                    fontFamily: Fonts.Lexend.name,
                                    fontSize:
                                        DimensionsHelper.ONE_UNIT_SIZE * 21,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.BLACK)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.PRIMARY_1),
                          borderRadius: BorderRadius.circular(
                              DimensionsHelper.BORDER_RADIUS_3X)),
                      child: Column(
                        children: [
                          Center(
                            child: TextBase(
                                text: "Điểm bình chọn",
                                style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  fontSize: DimensionsHelper.ONE_UNIT_SIZE * 20,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                )),
                          ),
                          SizedBox(
                            height: DimensionsHelper.SPACE_SIZE_2X,
                          ),
                          Center(
                            child: TextBase(
                                text: totalVotesPerKol.toString(),
                                style: TextStyle(
                                    fontFamily: Fonts.Lexend.name,
                                    fontSize:
                                        DimensionsHelper.ONE_UNIT_SIZE * 24,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.PRIMARY_1)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: DimensionsHelper.SPACE_SIZE_3X,
                ),
                ButtonBase(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.VOTING_PROCESS_PAGE);
                  },
                  margin: const EdgeInsets.all(0),
                  borderRadius: DimensionsHelper.BLUR_RADIUS_3X,
                  fontSizedLabel: DimensionsHelper.ONE_UNIT_SIZE * 23,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                  label: "Xem quy trình bình chọn",
                  colorText: ColorConstants.BLACK,
                  colorBG: ColorConstants.PLACE1,
                ),
                SizedBox(
                  height: DimensionsHelper.SPACE_SIZE_3X,
                ),
                BlocBuilder<EventBloc, EventState>(
                  buildWhen: (previous, current) {
                    if (current is RemainingVotesSuccess) {
                      setState(() {
                        remainVotes = current.remainingVotes.remainingVotes;
                      });
                    }

                    if (current is CreateVoteSuccess) {
                      setState(() {
                        remainVotes -= 1;
                        totalVotesPerKol += 1;
                      });

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ModalVoteSuccess(
                            type: widget.args.catagoryId == 1001
                                ? "KOL's nhí"
                                : "Biệt đội KOL's nhí",
                          );
                        },
                      );
                    }

                    if (current is CreateVoteFailure) {
                      ToastHelper.toastWarning(
                          title: current.error, context: context);
                    }

                    return current is RemainingVotesLoading ||
                        current is RemainingVotesSuccess ||
                        current is RemainingVotesFailure ||
                        current is CreateVoteLoading ||
                        current is CreateVoteSuccess ||
                        current is CreateVoteFailure;
                  },
                  builder: (context, state) {
                    if (state is RemainingVotesLoading ||
                        state is CreateVoteLoading) {
                      return ButtonLinearGradient(
                        title: "Đang tải ...",
                        height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                        borderRadius: DimensionsHelper.BLUR_RADIUS_3X,
                      );
                    }

                    return ButtonLinearGradient(
                      isDisable: widget.args.isVotingEnabled != 0 ? null : true,
                      onTap: () {
                        context.read<EventBloc>().add(PostVote(widget.args.id));
                      },
                      title: widget.args.isVotingEnabled != 0
                          ? "Bình chọn ngay (còn lại: $remainVotes/3)"
                          : "Hết hạn vote",
                      height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                      borderRadius: DimensionsHelper.BLUR_RADIUS_3X,
                      fontWeight: FontWeight.w400,
                      color: widget.args.isVotingEnabled != 0
                          ? Colors.white
                          : Colors.black,
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Thông tin KOL's nhí",
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
