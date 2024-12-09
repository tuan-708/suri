import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/event_page.dart';
import 'package:suri_checking_event_app/features/gift/presentation/pages/gift_page.dart';
import 'package:suri_checking_event_app/features/home/presentation/pages/home_page.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_event.dart';
import 'package:suri_checking_event_app/features/main/presentation/widgets/modal_scan_qr.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_event.dart';
import 'package:suri_checking_event_app/features/user/presentation/pages/user_page.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  String _scanBarcode = 'Unknown';
  final sharedHelper = sl.get<SharedPreferenceHelper>();

  DateTime? currentBackPressTime;

  final List<Widget> _pages = [
    const HomePage(),
    const EventPage(),
    const GiftPage(),
    const UserPage(),
  ];

  void onTabTapped(int index) {
    // Check nó login chưa và quay lại home
    if ((index == 2 || index == 3) &&
        (StringValid.nullOrEmpty(sharedHelper.getJwtToken))) {
      Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
      setState(() {
        _currentIndex = 0;
      });
      return;
    }
    if (index == 3) {
      context.read<UserBloc>().add(GetEventRemains(1042));
    }
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Hủy',
        false,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  void initState() {
    context.read<MainBloc>().add(LoadProfile());

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> onDoubleBack() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ToastHelper.toastInfo(
          title: "Bạn có muốn thoát ứng dụng?", context: context);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onDoubleBack(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildNavItem(
                  icon: ImagePathConstants.IC_DASHBOARD1,
                  index: 0,
                  title: "Trang chủ"),
              _buildNavItem(
                icon: ImagePathConstants.IC_DASHBOARD2,
                index: 1,
                title: "Sự kiện",
              ),
              _buildNavItem(
                icon: "",
                index: 4,
                title: "Scan",
              ),
              _buildNavItem(
                icon: ImagePathConstants.IC_DASHBOARD3,
                index: 2,
                title: "Quà của bạn",
              ),
              _buildNavItem(
                  icon: ImagePathConstants.IC_DASHBOARD4,
                  index: 3,
                  title: "Tài khoản"),
            ],
          ),
        ),
        floatingActionButton: btnScanQR(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  GestureDetector btnScanQR() {
    return GestureDetector(
      onTap: () {
        if (StringValid.nullOrEmpty(sharedHelper.getJwtToken)) {
          Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ScanQRView(),
          ));
        }
      },
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(DimensionsHelper.ONE_UNIT_SIZE * 100),
        child: Container(
          width: DimensionsHelper.ONE_UNIT_SIZE * 90,
          height: DimensionsHelper.ONE_UNIT_SIZE * 90,
          padding: const EdgeInsets.all(7),
          margin: EdgeInsets.only(
            top: DimensionsHelper.ONE_UNIT_SIZE * 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(DimensionsHelper.ONE_UNIT_SIZE * 100),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.ONE_UNIT_SIZE * 100),
                gradient: const LinearGradient(colors: [
                  ColorConstants.LINEAR_GRADIENT1,
                  ColorConstants.LINEAR_GRADIENT2,
                ])),
            child: Center(
              child: ImageBase(
                ImagePathConstants.IC_SCAN,
                width: DimensionsHelper.ONE_UNIT_SIZE * 40,
                height: DimensionsHelper.ONE_UNIT_SIZE * 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String? icon,
    required int index,
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        onTabTapped(index);
      },
      child: AbsorbPointer(
        child: SizedBox(
          width: DimensionsHelper.iziSize.width / 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != "")
                ImageBase(
                  icon!,
                  colorIconsSvg: _currentIndex == index
                      ? ColorConstants.PRIMARY_1
                      : ColorConstants.BLACK,
                )
              else
                SizedBox(
                  width: DimensionsHelper.ONE_UNIT_SIZE * 40,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 32,
                ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_1X * 0.5,
              ),
              Text(title,
                  style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      color: _currentIndex == index
                          ? ColorConstants.PRIMARY_1
                          : title == "Scan"
                              ? ColorConstants.PRIMARY_1
                              : ColorConstants.BLACK,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL * 0.75,
                      fontWeight: _currentIndex == index
                          ? FontWeight.w400
                          : FontWeight.w300)),
            ],
          ),
        ),
      ),
    );
  }
}
