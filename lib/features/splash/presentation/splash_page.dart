import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/di_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _setStatusLogin();
  }

  void _setStatusLogin() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    // check logged in or not.
    _animationController!.forward().whenComplete(
      () async {
        final sharedHelper = sl.get<SharedPreferenceHelper>();
        bool isOpened = sharedHelper.getIsOpenedIntroduction;
        if (isOpened) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.MAIN_PAGE,
            (route) {
              return false;
            },
          );
        } else {
          Navigator.pushNamed(context, AppRoutes.INTRODUCTION_PAGE);
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: ColorConstants.WHITE),
        child: Center(
          child: ImageBase(
            ImagePathConstants.LOGO_APP,
            width: DimensionsHelper.ONE_UNIT_SIZE * 350,
            height: DimensionsHelper.ONE_UNIT_SIZE * 120,
          ),
        ));
  }
}
