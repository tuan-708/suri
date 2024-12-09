import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_linnear_gradient.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/list_kol_entity.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';
import 'package:url_launcher/url_launcher.dart';

class QueueTableKOLPage extends StatefulWidget {
  const QueueTableKOLPage({super.key});

  @override
  State<QueueTableKOLPage> createState() => _QueueTableKOLPageState();
}

class _QueueTableKOLPageState extends State<QueueTableKOLPage> {
  final pageController = PageController();
  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  List<String> listOrganizational = [
    'https://dion.vn/wp-content/uploads/2024/09/bioamicus2.png',
  ];

  List<String> listCompanion = [
    'https://dion.vn/wp-content/uploads/2024/09/natureisway.png',
    'https://dion.vn/wp-content/uploads/2024/09/motaro.png',
    'https://dion.vn/wp-content/uploads/2024/09/midkid.png',
    'https://dion.vn/wp-content/uploads/2024/09/jonzac-2.png',
    'https://dion.vn/wp-content/uploads/2024/09/atono.png',
    'https://dion.vn/wp-content/uploads/2024/09/bioamicus.png',
    'https://dion.vn/wp-content/uploads/2024/09/photo_2024-09-09_09-50-05.jpg',
    'https://dion.vn/wp-content/uploads/2024/09/photo_2024-09-09_09-50-13.jpg'
  ];

  final int itemsPerPage = 6;

  final int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  int indexSliderOrganizational = 0;
  int indexSliderCompanion = 0;

  // Mặc định chọn KOL
  int selectId = 1001;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
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
    context.read<EventBloc>().add(GetListTop3KOL());
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _header(),
        body: Container(
            child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_imageBanner(), _introduce(), _rank()]),
        )));
  }

  Container _introduce() {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              TextBase(
                text: "01",
                style: TextStyle(
                  fontFamily: Fonts.SVN.name,
                  fontSize: DimensionsHelper.ONE_UNIT_SIZE * 70,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.PRIMARY_1.withOpacity(0.5),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: DimensionsHelper.ONE_UNIT_SIZE * 55,
                  top: DimensionsHelper.ONE_UNIT_SIZE * 22,
                ),
                child: TextBase(
                  text:
                      "Giới thiệu về Biệt đội KOLs nhí ${DateTime.now().year}",
                  style: TextStyle(
                    fontFamily: Fonts.SVN.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 1.2,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.BLACK,
                  ),
                ),
              ),
            ],
          ),
          Text(
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                fontWeight: FontWeight.w200,
                color: ColorConstants.BLACK,
              ),
              "Biệt Đội KOLs Nhí là cuộc thi do Suri Store tổ chức với mong muốn tìm kiếm những tài năng nhí và phát huy năng khiếu, sở trường của các bé giúp các em nhỏ có cơ hội trải nghiệm công việc của một KOLs thực thụ. Sau thành công của 3 mùa tổ chức, cuộc thi đã nhận được sự ủng hộ đông đảo trong cộng đồng mẹ&bé cũng như trở thành một sân chơi uy tín, chuyên nghiệp và hấp dẫn nhất dành cho các em bé có độ tuổi từ 6 tháng - 5 tuổi ở phạm vi toàn quốc. "),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_3X,
          ),
          Text(
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                fontWeight: FontWeight.w200,
                color: ColorConstants.BLACK,
              ),
              "Biệt Đội KOLs Nhí ${DateTime.now().year} trở lại với chủ đề “Born Happy Fighters” - Sinh ra để trở thành những chiến binh hạnh phúc. Mang thông điệp vô cùng ý nghĩa, cuộc thi năm nay sẽ tìm ra những “chiến binh hạnh phúc” có năng lực lan toả niềm vui, năng lượng tích cực đến với những người xung quanh và trở thành biểu tượng của sự hạnh phúc trong gia đình! "),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_3X,
          ),
          Text(
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                fontWeight: FontWeight.w200,
                color: ColorConstants.BLACK,
              ),
              "Với những quyền lợi đặc biệt, các thí sinh Biệt Đội KOLs Nhí ${DateTime.now().year} sẽ có cơ hội nhận được nhiều giải thưởng lớn và trở thành Đại sứ thương hiệu của các nhãn hàng quốc tế. Quý vị hãy bình chọn cho thí sinh mình yêu thích nhé! "),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_4X,
          ),
          Text(
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              "Thông tin chi tiết, vui lòng liên hệ: "),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Text(
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                fontWeight: FontWeight.w400,
                color: ColorConstants.PRIMARY_1,
              ),
              "Ms. VÕ TRẦN QUỲNH TRANG "),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_4X,
          ),
          Text(
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              "Trưởng ban tổ chức: "),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DimensionsHelper.ONE_UNIT_SIZE * 110,
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                      fontWeight: FontWeight.w200,
                      color: ColorConstants.BLACK,
                    ),
                    "Contact: "),
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              GestureDetector(
                onTap: () {
                  _launchUrl(Uri.parse('tel:0986120954'));
                },
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                    "0986.120.954"),
              ),
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DimensionsHelper.ONE_UNIT_SIZE * 110,
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                      fontWeight: FontWeight.w200,
                      color: ColorConstants.BLACK,
                    ),
                    "Gmail: "),
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              GestureDetector(
                onTap: () {
                  _launchUrl(Uri.parse(
                      'mailto:quynhtrangmedia@gmail.com?subject=Xin Chào Suri Store&body=Vui lòng điền nội dung!'));
                },
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                    "quynhtrangmedia@gmail.com"),
              ),
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DimensionsHelper.ONE_UNIT_SIZE * 110,
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                      fontWeight: FontWeight.w200,
                      color: ColorConstants.BLACK,
                    ),
                    "Zalo: "),
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              GestureDetector(
                onTap: () {
                  _launchUrl(Uri.parse('https://zalo.me/0986120954'));
                },
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                    "0986.120.954"),
              ),
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DimensionsHelper.ONE_UNIT_SIZE * 110,
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                      fontWeight: FontWeight.w200,
                      color: ColorConstants.BLACK,
                    ),
                    "Fanpage: "),
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _launchUrl(
                        Uri.parse('https://www.facebook.com/suristore83vtp'));
                  },
                  child: Text(
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      "https://www.facebook.com/suristore83vtp"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DimensionsHelper.ONE_UNIT_SIZE * 110,
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                      fontWeight: FontWeight.w200,
                      color: ColorConstants.BLACK,
                    ),
                    "Website: "),
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _launchUrl(Uri.parse('https://suristore.vn/'));
                  },
                  child: Text(
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      "https://suristore.vn/"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DimensionsHelper.ONE_UNIT_SIZE * 110,
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                      fontWeight: FontWeight.w200,
                      color: ColorConstants.BLACK,
                    ),
                    "Hotline: "),
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _launchUrl(Uri.parse('tel:086621285'));
                  },
                  child: Text(
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      "0866.212.855 "),
                ),
              ),
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DimensionsHelper.ONE_UNIT_SIZE * 110,
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                      fontWeight: FontWeight.w200,
                      color: ColorConstants.BLACK,
                    ),
                    "Địa chỉ: "),
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_2X,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _launchUrl(Uri.parse(
                        'https://www.google.com/maps/search/?api=1&query=Suri Center 18 Vũ Trọng Phụng, Thanh Xuân, Hà Nội'));
                  },
                  child: Text(
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                      "Suri Center 18 Vũ Trọng Phụng, Thanh Xuân, Hà Nội"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _rank() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            ColorConstants.BG_LINEAR_GRADIENT1,
            ColorConstants.BG_LINEAR_GRADIENT2
          ])),
      padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title2(),
          _tab(),
          _topKOL(),
          _listKOLs(),
          _btnSeeMore(),
          _title3(),
          _titleOrganization(),
          organizationalUnit(),
          _indicatorOrganizationUnit(),
          SizedBox(
            height: DimensionsHelper.ONE_UNIT_SIZE * 30,
          ),
          titleCompanion(),
          companionUnit(),
          _indicatorCompanionUnit(),
          SizedBox(
            height: DimensionsHelper.ONE_UNIT_SIZE * 30,
          ),
          totalPrizeDetails(),
        ],
      ),
    );
  }

  Center titleCompanion() {
    return Center(
      child: Container(
          margin: EdgeInsets.only(bottom: DimensionsHelper.SPACE_SIZE_3X),
          child: TextBase(
            text: "Đơn vị đồng hành",
            style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400,
                color: ColorConstants.PRIMARY_1),
          )),
    );
  }

  Container _titleOrganization() {
    return Container(
        margin: EdgeInsets.only(bottom: DimensionsHelper.SPACE_SIZE_3X),
        child: Center(
          child: TextBase(
            text: "Đơn vị đồng tổ chức",
            style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400,
                color: ColorConstants.PRIMARY_1),
          ),
        ));
  }

  Center _indicatorOrganizationUnit() {
    final int pageCount = (listOrganizational.length / itemsPerPage).ceil();

    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: indexSliderOrganizational,
        count: pageCount,
        effect: WormEffect(
          dotHeight: DimensionsHelper.ONE_UNIT_SIZE * 17,
          dotWidth: DimensionsHelper.ONE_UNIT_SIZE * 17,
          activeDotColor: ColorConstants.PRIMARY_1,
        ),
      ),
    );
  }

  Center _indicatorCompanionUnit() {
    final int pageCount = (listCompanion.length / itemsPerPage).ceil();

    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: indexSliderCompanion,
        count: pageCount,
        effect: WormEffect(
          dotHeight: DimensionsHelper.ONE_UNIT_SIZE * 17,
          dotWidth: DimensionsHelper.ONE_UNIT_SIZE * 17,
          activeDotColor: ColorConstants.PRIMARY_1,
        ),
      ),
    );
  }

  Center _btnSeeMore() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: DimensionsHelper.SPACE_SIZE_3X),
        child: ButtonLinearGradient(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.LIST_KOL_PAGE);
          },
          title: 'Xem thêm',
          fontWeight: FontWeight.w400,
          borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
          width: DimensionsHelper.ONE_UNIT_SIZE * 150,
        ),
      ),
    );
  }

  Column totalPrizeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title4(),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_2X,
        ),
        Center(
          child: TextBase(
            text: "Tổng giá trị giải thưởng lên đến :",
            style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w200,
                color: ColorConstants.BLACK),
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_2X,
        ),
        Center(
          child: TextBase(
            text: "300.000.000 VNĐ",
            style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400,
                color: ColorConstants.PRIMARY_1),
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_4X,
        ),
        TextBase(
          text: "Thể lệ :",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN,
            fontWeight: FontWeight.w400,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X,
        ),
        TextBase(
          text: "* Chia bảng thí sinh :",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w400,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X,
        ),
        TextBase(
          text: "- Bảng KOLs: tất cả thí sinh từ 6M - 5 tuổi",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w200,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X * .5,
        ),
        TextBase(
          maxLine: 5,
          text:
              "- Bảng Biệt đội: Mỗi một nhóm tối thiểu 5 thành viên - tối đa 15 thành viên",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w200,
            color: ColorConstants.BLACK,
          ),
        ),
        TextBase(
          text: "Vòng thi :",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN,
            fontWeight: FontWeight.w400,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X,
        ),
        TextBase(
          text: "* Bảng KOL's :",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w400,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X,
        ),
        TextBase(
          maxLine: 5,
          text: "- Vòng 1 (từ tháng 8 - 30/9): Casting Photo (Tìm ra Top 100)",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w200,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X * .5,
        ),
        TextBase(
          maxLine: 5,
          text:
              "- Vòng 2 (từ 10/10 - 30/10): Training short video (Tìm ra Top 30)",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w200,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X * .5,
        ),
        TextBase(
          maxLine: 5,
          text: "- Vòng 3 (17/11): Tập làm Đại sứ thương hiệu",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w200,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X * .5,
        ),
        TextBase(
          maxLine: 5,
          text: "- Vòng Chung kết diễn ra tại The Queen's Day (15/12)",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w200,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X,
        ),
        TextBase(
          text: "* Bảng Biệt đội :",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w400,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X,
        ),
        TextBase(
          maxLine: 5,
          text: "- Vòng 1 (từ tháng 8 - 30/11): Casting Photo (Chọn ra Top 10)",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w200,
            color: ColorConstants.BLACK,
          ),
        ),
        SizedBox(
          height: DimensionsHelper.SPACE_SIZE_1X * .5,
        ),
        TextBase(
          maxLine: 5,
          text: "- Vòng Chung kết diễn ra tại The Queen's Day (15/12)",
          style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            fontWeight: FontWeight.w200,
            color: ColorConstants.BLACK,
          ),
        ),
      ],
    );
  }

  SizedBox organizationalUnit() {
    final int pageCount = (listOrganizational.length / itemsPerPage).ceil();

    List<List<String>> pages = List.generate(
      pageCount,
      (pageIndex) {
        final int start = pageIndex * itemsPerPage;
        final int end = start + itemsPerPage > listOrganizational.length
            ? listOrganizational.length
            : start + itemsPerPage;
        return listOrganizational.sublist(start, end);
      },
    );

    return SizedBox(
      width: DimensionsHelper.iziSize.width,
      height: DimensionsHelper.ONE_UNIT_SIZE * 200,
      child: CarouselSlider.builder(
        carouselController: _controller,
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 1,
          viewportFraction: 1,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            setState(() {
              indexSliderOrganizational = index;
            });
          },
        ),
        itemCount: pageCount,
        itemBuilder: (context, pageIndex, realIndex) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: DimensionsHelper.SPACE_SIZE_2X),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: pages[pageIndex].length,
                itemBuilder: (context, gridIndex) {
                  return Container(
                    color: ColorConstants.WHITE,
                    padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_2X),
                    child: ImageBase(
                      pages[pageIndex][gridIndex],
                      width: DimensionsHelper.iziSize.width,
                      height: DimensionsHelper.ONE_UNIT_SIZE * 100,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  SizedBox companionUnit() {
    final int pageCount = (listCompanion.length / itemsPerPage).ceil();
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;

    List<List<String>> pages = List.generate(
      pageCount,
      (pageIndex) {
        final int start = pageIndex * itemsPerPage;
        final int end = start + itemsPerPage > listCompanion.length
            ? listCompanion.length
            : start + itemsPerPage;
        return listCompanion.sublist(start, end);
      },
    );

    return SizedBox(
      width: DimensionsHelper.iziSize.width,
      height: isTablet
          ? DimensionsHelper.ONE_UNIT_SIZE * 650
          : DimensionsHelper.ONE_UNIT_SIZE * 370,
      child: CarouselSlider.builder(
        carouselController: _controller,
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 1,
          viewportFraction: 1,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            setState(() {
              indexSliderCompanion = index;
            });
          },
        ),
        itemCount: pageCount,
        itemBuilder: (context, pageIndex, realIndex) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: DimensionsHelper.SPACE_SIZE_2X),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: pages[pageIndex].length,
                itemBuilder: (context, gridIndex) {
                  return Container(
                    color: ColorConstants.WHITE,
                    padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_2X),
                    child: ImageBase(
                      pages[pageIndex][gridIndex],
                      width: DimensionsHelper.iziSize.width,
                      height: DimensionsHelper.ONE_UNIT_SIZE * 100,
                      fit: BoxFit.fitHeight,
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  Container _topKOL() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: DimensionsHelper.SPACE_SIZE_4X),
      child: BlocBuilder<EventBloc, EventState>(
        buildWhen: (previous, current) {
          return current is ListTop3KOLLoading ||
              current is ListTop3KOLSuccess ||
              current is ListTop3KOLFailure;
        },
        builder: (context, state) {
          if (state is ListTop3KOLLoading) {
            return SizedBox(
              height: DimensionsHelper.ONE_UNIT_SIZE * 200,
              child: const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
            );
          }

          if (state is ListTop3KOLSuccess) {
            if (state.list[selectId == 1001 ? 0 : 1].value.length < 3) {
              return const BoxEmpty();
            }
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemTopKOL(
                      topKOL: 2,
                      data: state.list[selectId == 1001 ? 0 : 1].value[1]),
                  itemTopKOL(
                      topKOL: 1,
                      data: state.list[selectId == 1001 ? 0 : 1].value[0]),
                  itemTopKOL(
                      topKOL: 3,
                      data: state.list[selectId == 1001 ? 0 : 1].value[2]),
                ]);
          }

          return const BoxEmpty();
        },
      ),
    );
  }

  Row _tab() {
    return Row(
      children: [
        _button(isSelectedKOL: 1001, title: "KOLs Nhí"),
        SizedBox(
          width: DimensionsHelper.SPACE_SIZE_3X,
        ),
        _button(isSelectedKOL: 1002, title: "Biệt Đội"),
      ],
    );
  }

  Container _listKOLs() {
    return Container(
      margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_3X),
      child: BlocBuilder<EventBloc, EventState>(
        buildWhen: (previous, current) {
          return current is ListTop3KOLLoading ||
              current is ListTop3KOLSuccess ||
              current is ListTop3KOLFailure;
        },
        builder: (context, state) {
          if (state is ListTop3KOLLoading) {
            return SizedBox(
              height: DimensionsHelper.ONE_UNIT_SIZE * 200,
              child: const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
            );
          }

          if (state is ListTop3KOLSuccess) {
            final listItem = state.list[selectId == 1001 ? 0 : 1].value;
            final subList = listItem.length > 3 ? listItem.sublist(3) : [];
            return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: DimensionsHelper.HORIZONTAL_SCREEN,
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (StringValid.nullOrEmpty(_sharedHelper.getJwtToken)) {
                      Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
                    } else {
                      Navigator.pushNamed(context, AppRoutes.KOL_DETAIL_PAGE,
                          arguments: subList[index]);
                    }
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            DimensionsHelper.BORDER_RADIUS_4X),
                        border: Border.all(color: ColorConstants.PRIMARY_1)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              DimensionsHelper.BORDER_RADIUS_4X),
                          child: ImageBase(
                            '$BASE_URL${subList[index].photo}',
                            height: DimensionsHelper.ONE_UNIT_SIZE * 170 * 1.25,
                            width: DimensionsHelper.ONE_UNIT_SIZE * 170 * 1.25,
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding:
                              EdgeInsets.all(DimensionsHelper.SPACE_SIZE_2X),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextBase(
                                  maxLine: 2,
                                  text: subList[index].name.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: Fonts.Lexend.name,
                                    fontSize:
                                        DimensionsHelper.ONE_UNIT_SIZE * 22,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextBase(
                                      text: "SBD: ${subList[index].number}"
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: Fonts.Lexend.name,
                                        fontSize:
                                            DimensionsHelper.ONE_UNIT_SIZE * 21,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.black,
                                      )),
                                  TextBase(
                                      text: "XH: ${index + 4}".toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: Fonts.Lexend.name,
                                          fontSize:
                                              DimensionsHelper.ONE_UNIT_SIZE *
                                                  21,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstants.PRIMARY_1)),
                                ],
                              ),
                              SizedBox(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 10,
                              ),
                              Row(
                                children: [
                                  TextBase(
                                      text: "Điểm bình chọn: ",
                                      style: TextStyle(
                                        fontFamily: Fonts.Lexend.name,
                                        fontSize:
                                            DimensionsHelper.ONE_UNIT_SIZE * 21,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.black,
                                      )),
                                  TextBase(
                                      text: '${subList[index].totalVotesPerKol}'
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: Fonts.Lexend.name,
                                          fontSize:
                                              DimensionsHelper.ONE_UNIT_SIZE *
                                                  23,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstants.PRIMARY_1)),
                                ],
                              ),
                              SizedBox(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 10,
                              ),
                              ButtonBase(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.KOL_DETAIL_PAGE,
                                      arguments: subList[index]);
                                },
                                margin: const EdgeInsets.all(0),
                                borderRadius: DimensionsHelper.BLUR_RADIUS_4X,
                                fontSizedLabel:
                                    DimensionsHelper.ONE_UNIT_SIZE * 23,
                                height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                                label: "Bình chọn",
                                colorText: ColorConstants.BLACK,
                                colorBG: ColorConstants.PLACE1,
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const BoxEmpty();
        },
      ),
    );
  }

  Color switchColor(topKOL) {
    switch (topKOL) {
      case 1:
        return ColorConstants.TOP1;
      case 2:
        return ColorConstants.TOP2;
      case 3:
        return ColorConstants.TOP3;
      default:
        return ColorConstants.TOP1;
    }
  }

  double width = DimensionsHelper.iziSize.width -
      2 * DimensionsHelper.SPACE_SIZE_1X -
      2 * DimensionsHelper.HORIZONTAL_SCREEN;

  GestureDetector itemTopKOL(
      {required int topKOL, required KOLDetailsEntity data}) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;

    return GestureDetector(
      onTap: () {
        if (StringValid.nullOrEmpty(_sharedHelper.getJwtToken)) {
          Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
        } else {
          Navigator.pushNamed(context, AppRoutes.KOL_DETAIL_PAGE,
              arguments: data);
        }
      },
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
            // height: topKOL == 1
            //     ? isTablet
            //         ? DimensionsHelper.ONE_UNIT_SIZE * 400
            //         : DimensionsHelper.ONE_UNIT_SIZE * 392
            //     : isTablet
            //         ? DimensionsHelper.ONE_UNIT_SIZE * 345
            //         : DimensionsHelper.ONE_UNIT_SIZE * 315,
            width: topKOL == 1 ? width * 0.37 : width * 0.3,
            margin: EdgeInsets.only(
                top: topKOL == 1
                    ? DimensionsHelper.ONE_UNIT_SIZE
                    : DimensionsHelper.ONE_UNIT_SIZE * 30),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: switchColor(topKOL)),
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X)),
            child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
                child: Column(
                  children: [
                    ImageBase("$BASE_URL${data.photo}",
                        width: DimensionsHelper.iziSize.width,
                        height: topKOL == 1
                            ? isTablet
                                ? DimensionsHelper.ONE_UNIT_SIZE * 250
                                : DimensionsHelper.ONE_UNIT_SIZE * 200
                            : isTablet
                                ? DimensionsHelper.ONE_UNIT_SIZE * 210
                                : DimensionsHelper.ONE_UNIT_SIZE * 150),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextBase(
                              text: "Điểm bình chọn",
                              style: TextStyle(
                                fontFamily: Fonts.Lexend.name,
                                fontSize: topKOL == 1
                                    ? DimensionsHelper.ONE_UNIT_SIZE * 18
                                    : DimensionsHelper.ONE_UNIT_SIZE * 16,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          TextBase(
                              text: '${data.totalVotesPerKol}',
                              style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  fontSize: topKOL == 1
                                      ? DimensionsHelper.ONE_UNIT_SIZE * 22
                                      : DimensionsHelper.ONE_UNIT_SIZE * 19,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.PRIMARY_1)),
                          const SizedBox(
                            height: 5,
                          ),
                          TextBase(
                              textAlign: TextAlign.center,
                              text: data.name.toUpperCase(),
                              maxLine: 2,
                              style: TextStyle(
                                fontFamily: Fonts.Lexend.name,
                                fontSize: topKOL == 1
                                    ? DimensionsHelper.ONE_UNIT_SIZE * 18
                                    : DimensionsHelper.ONE_UNIT_SIZE * 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          TextBase(
                              textAlign: TextAlign.center,
                              text: "SBD: ${data.number}".toUpperCase(),
                              maxLine: 2,
                              style: TextStyle(
                                fontFamily: Fonts.Lexend.name,
                                fontSize: topKOL == 1
                                    ? DimensionsHelper.ONE_UNIT_SIZE * 18
                                    : DimensionsHelper.ONE_UNIT_SIZE * 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                  ],
                ))),
        Positioned(
          bottom: -10,
          left: topKOL == 1
              ? ((width * 0.37) / 2) - DimensionsHelper.ONE_UNIT_SIZE * 15
              : ((width * 0.3) / 2) - DimensionsHelper.ONE_UNIT_SIZE * 15,
          child: Container(
            width: DimensionsHelper.ONE_UNIT_SIZE * 30,
            height: DimensionsHelper.ONE_UNIT_SIZE * 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: switchColor(topKOL)),
            child: Center(
              child: TextBase(
                  text: '$topKOL',
                  style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.ONE_UNIT_SIZE * 19,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.WHITE)),
            ),
          ),
        ),
      ]),
    );
  }

  Stack _title2() {
    return Stack(
      children: [
        TextBase(
          text: "02",
          style: TextStyle(
            fontFamily: Fonts.SVN.name,
            fontSize: DimensionsHelper.ONE_UNIT_SIZE * 75,
            fontWeight: FontWeight.w400,
            color: ColorConstants.PRIMARY_1.withOpacity(0.5),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: DimensionsHelper.ONE_UNIT_SIZE * 22,
          ),
          width: DimensionsHelper.iziSize.width,
          child: Center(
            child: TextBase(
              text: "Bảng Xếp hạng bình chọn".toUpperCase(),
              style: TextStyle(
                fontFamily: Fonts.SVN.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * 1.34,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack _title4() {
    return Stack(
      children: [
        TextBase(
          text: "04",
          style: TextStyle(
            fontFamily: Fonts.SVN.name,
            fontSize: DimensionsHelper.ONE_UNIT_SIZE * 75,
            fontWeight: FontWeight.w400,
            color: ColorConstants.PRIMARY_1.withOpacity(0.4),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: DimensionsHelper.ONE_UNIT_SIZE * 10,
            left: DimensionsHelper.ONE_UNIT_SIZE * 73,
          ),
          width: DimensionsHelper.iziSize.width,
          child: TextBase(
            maxLine: 2,
            text: "Tổng giá trị giải thưởng và chi tiết\n     thể lệ, vòng thi",
            style: TextStyle(
              fontFamily: Fonts.SVN.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * 1.3,
              fontWeight: FontWeight.w400,
              color: ColorConstants.BLACK,
            ),
          ),
        ),
      ],
    );
  }

  Stack _title3() {
    return Stack(
      children: [
        TextBase(
          text: "03",
          style: TextStyle(
            fontFamily: Fonts.SVN.name,
            fontSize: DimensionsHelper.ONE_UNIT_SIZE * 75,
            fontWeight: FontWeight.w400,
            color: ColorConstants.PRIMARY_1.withOpacity(0.4),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: DimensionsHelper.ONE_UNIT_SIZE * 10,
            left: DimensionsHelper.ONE_UNIT_SIZE * 73,
          ),
          width: DimensionsHelper.iziSize.width,
          child: TextBase(
            text: "Vinh Danh Các Đơn Vị Tài Trợ",
            style: TextStyle(
              fontFamily: Fonts.SVN.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * 1.34,
              fontWeight: FontWeight.w400,
              color: ColorConstants.BLACK,
            ),
          ),
        ),
      ],
    );
  }

  Expanded _button({String? title, int? isSelectedKOL}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectId = isSelectedKOL!;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: selectId == isSelectedKOL
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
              color: selectId == isSelectedKOL
                  ? ColorConstants.WHITE
                  : ColorConstants.BLACK,
            ),
          )),
        ),
      ),
    );
  }

  ImageBase _imageBanner() {
    return ImageBase(
      ImagePathConstants.IMAGE_BG_KOL,
      width: DimensionsHelper.iziSize.width,
      height: DimensionsHelper.ONE_UNIT_SIZE * 300,
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Biệt đội KOL's Nhí",
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
