import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/introduction/data/datasources/introduction_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final controller = IntroductionItems();
  final pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      child: Text(
                        "Bỏ qua",
                        style: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL,
                            fontWeight: FontWeight.w300,
                            color: Colors.blue),
                      )),

                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    effect: WormEffect(
                      dotHeight: DimensionsHelper.ONE_UNIT_SIZE * 17,
                      dotWidth: DimensionsHelper.ONE_UNIT_SIZE * 17,
                      activeDotColor: ColorConstants.PRIMARY_1,
                    ),
                  ),

                  //Next Button
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      child: Text(
                        "Tiếp tục",
                        style: TextStyle(
                            fontFamily: Fonts.Lexend.name,
                            fontWeight: FontWeight.w300,
                            fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL,
                            color: Colors.blue),
                      )),
                ],
              ),
      ),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  SizedBox(height: DimensionsHelper.ONE_UNIT_SIZE * 20),
                  Text(
                    controller.items[index].title,
                    style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_H2 * 0.8,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 15),
                  Text(controller.items[index].descriptions,
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: DimensionsHelper.FONT_SIZE_H6),
                      textAlign: TextAlign.center),
                ],
              );
            }),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.PRIMARY_1),
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: TextButton(
          onPressed: () async {
            sl
                .get<SharedPreferenceHelper>()
                .setIsOpenedIntroduction(status: true);
            if (!mounted) return;
            Navigator.pushNamed(context, AppRoutes.MAIN_PAGE);
          },
          child: Text(
            "Bắt đầu",
            style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                color: Colors.white,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400),
          )),
    );
  }
}
