import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/features/event/data/models/spin_wheel_arguments.dart';

class SpinWheelPage extends StatefulWidget {
  const SpinWheelPage({super.key, required this.args});
  final SpinWheelArguments args;

  @override
  State<SpinWheelPage> createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage> {
  late InAppWebViewController inAppWebViewController;
  late double progressValue = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _header(),
        body: SafeArea(
          bottom: false,
          child: Stack(children: [
            if (progressValue < 1.0)
              Container(
                margin:
                    EdgeInsets.only(top: DimensionsHelper.ONE_UNIT_SIZE * 100),
                height: DimensionsHelper.iziSize.height,
                child: const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                )),
              ),
            Padding(
              padding: EdgeInsets.only(top: DimensionsHelper.ONE_UNIT_SIZE * 0),
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "$BASE_URL/app/quay-thuong/${widget.args.eventId}?token=${widget.args.token}")),
                onWebViewCreated: (InAppWebViewController controllers) {
                  inAppWebViewController = controllers;
                },
                onProgressChanged:
                    (InAppWebViewController controllers, int progress) {
                  setState(() {
                    progressValue = progress / 100;
                  });
                },
              ),
            ),
          ]),
        ));
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Quay thưởng",
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