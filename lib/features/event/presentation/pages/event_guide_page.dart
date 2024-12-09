import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class EventGuidePage extends StatefulWidget {
  const EventGuidePage({super.key});

  @override
  State<EventGuidePage> createState() => _EventGuidePageState();
}

class _EventGuidePageState extends State<EventGuidePage> {
  bool isShowGuide1 = false;
  bool isShowGuide2 = false;
  bool isShowGuide3 = false;
  bool isShowGuide4 = false;
  bool isShowGuide5 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _header(),
        body: Stack(children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  ImagePathConstants.IMAGE_BG_EVENT_SPECIAL,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // guide 1
                  btn(
                      title: "Check-in sớm (Only Member)",
                      onTap: () {
                        setState(() {
                          isShowGuide1 = !isShowGuide1;
                        });
                      },
                      isShow: isShowGuide1),
                  if (isShowGuide1) line(),
                  if (isShowGuide1) content1(),

                  // guide 2
                  SizedBox(
                    height: DimensionsHelper.HORIZONTAL_SCREEN,
                  ),
                  btn(
                      title: "Quà tặng tri ân khách VIP, SVIP, VVIP",
                      onTap: () {
                        setState(() {
                          isShowGuide2 = !isShowGuide2;
                        });
                      },
                      isShow: isShowGuide2),
                  if (isShowGuide2) line(),
                  if (isShowGuide2) content2(),

                  // guide 3
                  SizedBox(
                    height: DimensionsHelper.HORIZONTAL_SCREEN,
                  ),
                  btn(
                      title: "Quà tặng mẹ bầu",
                      onTap: () {
                        setState(() {
                          isShowGuide3 = !isShowGuide3;
                        });
                      },
                      isShow: isShowGuide3),
                  if (isShowGuide3) line(),
                  if (isShowGuide3) content3(),

                  // guide 4
                  SizedBox(
                    height: DimensionsHelper.HORIZONTAL_SCREEN,
                  ),
                  btn(
                      title: 'Quà tặng thí sinh cuộc thi "Nhật ký mẹ bầu"',
                      onTap: () {
                        setState(() {
                          isShowGuide4 = !isShowGuide4;
                        });
                      },
                      isShow: isShowGuide4),
                  if (isShowGuide4) line(),
                  if (isShowGuide4) content4(),
                  // guide 5
                  SizedBox(
                    height: DimensionsHelper.HORIZONTAL_SCREEN,
                  ),
                  btn(
                      title: 'Vòng quay may mắn',
                      onTap: () {
                        setState(() {
                          isShowGuide5 = !isShowGuide5;
                        });
                      },
                      isShow: isShowGuide5),
                  if (isShowGuide5) line(),
                  if (isShowGuide5) content4(),
                ],
              ),
            ),
          ),
        ]));
  }

  GestureDetector btn({Function()? onTap, bool? isShow, String? title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                isShow == true ? 0 : DimensionsHelper.BORDER_RADIUS_3X,
              ),
              bottomRight: Radius.circular(
                isShow == true ? 0 : DimensionsHelper.BORDER_RADIUS_3X,
              ),
              topLeft: Radius.circular(
                DimensionsHelper.BORDER_RADIUS_3X,
              ),
              topRight: Radius.circular(
                DimensionsHelper.BORDER_RADIUS_3X,
              ),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextBase(
                maxLine: 2,
                text: title!,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.BLACK,
                ),
              ),
            ),
            ImageBase(isShow == true
                ? ImagePathConstants.IC_UP
                : ImagePathConstants.IC_DOWN)
          ],
        ),
      ),
    );
  }

  Container line() {
    return Container(
      height: 2,
      width: DimensionsHelper.iziSize.width,
      color: ColorConstants.BORDER,
    );
  }

  Container content1() {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
      width: DimensionsHelper.iziSize.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X),
              bottomRight: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Bước 1: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Khách hàng sử dụng mã QR code trên vé mời online để check-in tham gia sự kiện',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 2: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Check-in theo thứ tự xếp hàng, hệ thống sẽ gửi thông báo nhận quà check-in sớm',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: "- Khu vực check-in VIP: 30 slot",
            maxLine: 2,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: "- Khu vực check-in hạng Member: 170 slot",
            maxLine: 2,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 3: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Khách hàng ra khu vực đổi quà, nhân viên kiểm tra thông xin, xác nhận và trao quà',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: "* Lưu ý:",
            maxLine: 2,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w400,
              color: ColorConstants.RED,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text:
                "- Mỗi khách hàng chỉ được check-in 1 lần và cập nhật tình trạng trực tiếp trên app Suri Event",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text:
                "- Mỗi khách hàng muốn tham gia hoạt động tại các gian hàng đều phải đăng ký vé online và tham gia check-in để kích hoạt vé",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
        ],
      ),
    );
  }

  Container content2() {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
      width: DimensionsHelper.iziSize.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X),
              bottomRight: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Bước 1: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Nhân viên sẽ quét QR code trên vé mời của khách hàng và check thông tin trên hệ thống',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 2: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Nhân viên trao quà cho khách theo thứ hạng vé mời',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 3: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Nhân viên tick vào mục "Đã nhận quà" trên máy chủ và chuyển thông tin tới mục "Quà của tôi" và giao diện trang chủ của khách hàng sẽ cập nhật mục quà VIP với tình trạng "Đã nhận quà"',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: "* Lưu ý:",
            maxLine: 2,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w400,
              color: ColorConstants.RED,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text:
                "- Mỗi khách hàng chỉ được trao quà 1 lần và cập nhật tình trạng trực tiếp trên app Suri Event",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text:
                "- Khách hàng tuyệt đối giữ bảo mật mã QR code tránh mọi trường hợp tranh chấp",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
        ],
      ),
    );
  }

  Container content3() {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
      width: DimensionsHelper.iziSize.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X),
              bottomRight: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Bước 1: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Nhân viên sẽ quét QR code trên vé mời của khách hàng và check thông tin trên hệ thống',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 2: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Nhân viên trao quà cho khách hàng',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 3: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Nhân viên tick vào mục "Đã nhận quà" trên máy chủ và chuyển thông tin tới mục "Quà của tôi" và giao diện trang chủ của khách hàng sẽ cập nhật mục quà bầu với tình trạng "Đã nhận quà"',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: "* Lưu ý:",
            maxLine: 2,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w400,
              color: ColorConstants.RED,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text:
                "- Mỗi khách hàng chỉ được trao quà 1 lần và cập nhật tình trạng trực tiếp trên app Suri Event",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text:
                "- Khách hàng tuyệt đối giữ bảo mật mã QR code tránh mọi trường hợp tranh chấp",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
        ],
      ),
    );
  }

  Container content4() {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
      width: DimensionsHelper.iziSize.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X),
              bottomRight: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Bước 1: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Nhân viên sẽ quét QR code trên vé mời của khách hàng và check thông tin trên hệ thống',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 2: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Nhân viên trao quà cho khách hàng',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 3: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      ' Nhân viên tick vào mục "Đã nhận quà" trên máy chủ và chuyển thông tin tới mục "Quà của tôi" và giao diện trang chủ của khách hàng sẽ cập nhật mục quà Nhật ký mẹ bầu với tình trạng "Đã nhận quà"',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: "* Lưu ý:",
            maxLine: 2,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w400,
              color: ColorConstants.RED,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text:
                "- Mỗi khách hàng chỉ được trao quà 1 lần và cập nhật tình trạng trực tiếp trên app Suri Event",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text:
                "- Khách hàng tuyệt đối giữ bảo mật mã QR code tránh mọi trường hợp tranh chấp",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
        ],
      ),
    );
  }

  Container content5() {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
      width: DimensionsHelper.iziSize.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X),
              bottomRight: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Bước 1: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Khách hàng sử dụng mã QR code trên vé mời online để check-in tham gia sự kiện',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 2: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Khách hàng thực hiện nhiệm vụ tại mỗi gian hàng để tích điểm. Sau khi hoàn thành nhiệm vụ, nhân viên mỗi gian hàng sẽ quét mã QR code của khách nhấn "Đã hoàn thành" để tích điểm và số điểm sẽ tự động cập nhật trên trang chủ app của khách hàng.',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 3: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Sau khi đủ điểm mỗi lần quay, khách hàng nhấn "Đổi lượt chơi vòng quay may mắn" để sử dụng lượt quay',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 4: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Khách hàng chủ động quay vòng quay may mắn, trang chủ hiện mã món quà khách hàng sẽ nhận được',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          RichText(
            text: TextSpan(
              text: 'Bước 5: ',
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Khách hàng đến khu vực nhận quà, nhân viên quét mã quà tặng check thông tin, trao quà và cập nhật tình trạng "Đã nhận quà" cho khách hàng.',
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                    fontWeight: FontWeight.w200,
                    color: ColorConstants.BLACK,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: "* Lưu ý:",
            maxLine: 2,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w400,
              color: ColorConstants.RED,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: "- Mỗi khách hàng được quay tối đa 3 lần",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text:
                "- Mỗi mã nhận quà chỉ được phát 1 lần, tuyệt đối bảo mật mã nhận quà tránh trường hợp tranh chấp",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: "- Quy định đổi điểm:",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          TextBase(
            text: "+ 5 điểm: Lần quay VQMM đầu tiên",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          TextBase(
            text: "+ 15 điểm: Lần quay VQMM thứ 2",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
          TextBase(
            text: "+ 30 điểm: Lần quay VQMM thứ 3",
            maxLine: 4,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
              fontWeight: FontWeight.w200,
              color: ColorConstants.BLACK,
            ),
          ),
        ],
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
