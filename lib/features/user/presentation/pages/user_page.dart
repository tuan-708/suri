import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/core/base_widgets/animated_custom_dialog.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/auth/presentation/pages/login_page.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_event.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_state.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_event.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_state.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with WidgetsBindingObserver {
  final _sharedHelper = sl.get<SharedPreferenceHelper>();
  final width =
      DimensionsHelper.iziSize.width - 2 * DimensionsHelper.HORIZONTAL_SCREEN;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetEventRemains(1042));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              _header(),
              _boxInfo(),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is GetEventRemainsSuccess) {
                    return Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: DimensionsHelper.HORIZONTAL_SCREEN,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextBase(
                                  text: "Điểm của bạn: ",
                                  style: TextStyle(
                                      fontFamily: Fonts.Lexend.name,
                                      color: ColorConstants.BLACK,
                                      fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                                      fontWeight: FontWeight.w200)),
                              TextBase(
                                  text: '${state.amount}',
                                  style: TextStyle(
                                      fontFamily: Fonts.Lexend.name,
                                      color: ColorConstants.PRIMARY_1,
                                      fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                                      fontWeight: FontWeight.w300))
                            ],
                          ),
                          SizedBox(
                            height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                          ),
                          Stack(clipBehavior: Clip.none, children: [
                            Container(
                              height: DimensionsHelper.ONE_UNIT_SIZE * 20,
                              width: width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: ColorConstants.PLACE3),
                            ),
                            Positioned(
                                top: 0,
                                left: 0,
                                height: DimensionsHelper.ONE_UNIT_SIZE * 20,
                                width: state.amount * (width / 30),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        gradient: const LinearGradient(colors: [
                                          ColorConstants.LINEAR_GRADIENT1,
                                          ColorConstants.LINEAR_GRADIENT2
                                        ])))),
                            Positioned(
                                top: -DimensionsHelper.ONE_UNIT_SIZE * 50,
                                left: 3 * (width / 30),
                                child: ImageBase(
                                  ImagePathConstants.IMG_MUC_1,
                                  width: DimensionsHelper.ONE_UNIT_SIZE *
                                      70 *
                                      1.25,
                                  height: DimensionsHelper.ONE_UNIT_SIZE *
                                      54 *
                                      1.25,
                                )),
                            Positioned(
                                top: -DimensionsHelper.ONE_UNIT_SIZE * 62,
                                left: 12 * (width / 30),
                                child: ImageBase(
                                  ImagePathConstants.IMG_MUC_2,
                                  width:
                                      DimensionsHelper.ONE_UNIT_SIZE * 69 * 1.5,
                                  height:
                                      DimensionsHelper.ONE_UNIT_SIZE * 53 * 1.5,
                                )),
                            Positioned(
                                top: -DimensionsHelper.ONE_UNIT_SIZE * 35,
                                left: 25 * (width / 30),
                                child: ImageBase(
                                  ImagePathConstants.IMG_MUC_3,
                                  width:
                                      DimensionsHelper.ONE_UNIT_SIZE * 46 * 1.4,
                                  height:
                                      DimensionsHelper.ONE_UNIT_SIZE * 38 * 1.4,
                                )),
                          ])
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              _btnAccountInfo(),
              _btnPrivacyPolicy(),
              _btnChangePasswordAccount(),
              _btnDeleteAccount(),
              _space(),
              _btnLogout(context),
              _space(),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _btnLogout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _sharedHelper.setJwtToken('');
        _sharedHelper.setLogged(status: false);
        _sharedHelper.setProfile('');

        context.read<MainBloc>().add(LogOutProfile());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => MainBloc(),
              child: const LoginPage(),
            ),
          ),
          (route) => false,
        );
      },
      child: AbsorbPointer(
        child: Container(
          width: DimensionsHelper.iziSize.width,
          height: DimensionsHelper.ONE_UNIT_SIZE * 70,
          padding: EdgeInsets.symmetric(
            horizontal: DimensionsHelper.SPACE_SIZE_3X,
            vertical: DimensionsHelper.SPACE_SIZE_3X,
          ),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: Offset(0, 4))
              ],
              borderRadius:
                  BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
              gradient: const LinearGradient(colors: [
                ColorConstants.LINEAR_GRADIENT1,
                ColorConstants.LINEAR_GRADIENT2
              ])),
          child: Row(
            children: [
              ImageBase(
                ImagePathConstants.IC_LOGOUT,
                width: DimensionsHelper.ONE_UNIT_SIZE * 30,
                height: DimensionsHelper.ONE_UNIT_SIZE * 30,
              ),
              SizedBox(
                width: DimensionsHelper.SPACE_SIZE_2X,
              ),
              TextBase(
                text: "Đăng xuất",
                style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    color: ColorConstants.WHITE,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _space() {
    return SizedBox(
      height: DimensionsHelper.SPACE_SIZE_3X,
    );
  }

  GestureDetector _btnAccountInfo() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.EDIT_USER_PAGE);
      },
      child: Container(
        margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_3X),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, 4))
            ],
            color: ColorConstants.WHITE,
            borderRadius:
                BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X)),
        padding: EdgeInsets.symmetric(
          horizontal: DimensionsHelper.SPACE_SIZE_2X,
          vertical: DimensionsHelper.SPACE_SIZE_3X,
        ),
        child: Row(
          children: [
            ImageBase(
              ImagePathConstants.IC_USER,
              width: DimensionsHelper.ONE_UNIT_SIZE * 30,
              height: DimensionsHelper.ONE_UNIT_SIZE * 30,
            ),
            SizedBox(
              width: DimensionsHelper.SPACE_SIZE_2X,
            ),
            TextBase(
              text: "Thông tin của bạn",
              style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  color: ColorConstants.BLACK,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _btnPrivacyPolicy() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.PRIVACY_POLICY_PAGE);
      },
      child: Container(
        margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_3X),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, 4))
            ],
            color: ColorConstants.WHITE,
            borderRadius:
                BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X)),
        padding: EdgeInsets.symmetric(
          horizontal: DimensionsHelper.SPACE_SIZE_2X,
          vertical: DimensionsHelper.SPACE_SIZE_3X,
        ),
        child: Row(
          children: [
            ImageBase(
              ImagePathConstants.IC_WARNING,
              width: DimensionsHelper.ONE_UNIT_SIZE * 30,
              height: DimensionsHelper.ONE_UNIT_SIZE * 30,
            ),
            SizedBox(
              width: DimensionsHelper.SPACE_SIZE_2X,
            ),
            Expanded(
              child: TextBase(
                maxLine: 2,
                text: "Điều khoản chính sách",
                style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    color: ColorConstants.BLACK,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDialog(BuildContext context, {String? content}) {
    showAnimatedDialog(
      context,
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: DimensionsHelper.ONE_UNIT_SIZE * 160,
          width: DimensionsHelper.iziSize.width * 0.8,
          padding: EdgeInsets.all(
            DimensionsHelper.SPACE_SIZE_3X,
          ),
          child: Column(
            children: [
              Text(content ?? 'Bạn có muốn xóa tài khoản?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      color: ColorConstants.BLACK,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * 1.1,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_4X,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonBase(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        label: 'Huỷ',
                        height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                        colorBG: ColorConstants.PLACE1,
                        color: ColorConstants.BLACK,
                        fontSizedLabel: DimensionsHelper.ONE_UNIT_SIZE * 24,
                        margin: const EdgeInsets.all(0),
                      ),
                    ),
                    SizedBox(
                      width: DimensionsHelper.SPACE_SIZE_2X,
                    ),
                    Expanded(
                      child: ButtonBase(
                        onTap: () {
                          context.read<UserBloc>().add(PostDeleteAccount());
                          Navigator.pop(context);
                        },
                        label: 'Xác nhận',
                        height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                        fontSizedLabel: DimensionsHelper.ONE_UNIT_SIZE * 24,
                        margin: const EdgeInsets.all(0),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _btnDeleteAccount() {
    return GestureDetector(
      onTap: () {
        showDialog(context);
      },
      child: BlocBuilder<UserBloc, UserState>(
        buildWhen: (previous, current) {
          if (current is PostDeleteAccountSuccess) {
            ToastHelper.toastSuccess(
                title: "Xoá tài khoản thành công!", context: context);
            _sharedHelper.setJwtToken('');
            _sharedHelper.setLogged(status: false);
            _sharedHelper.setProfile('');

            Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
          }
          if (current is PostDeleteAccountFailure) {
            ToastHelper.toastError(
                title: "Xoá tài khoản thất bại", context: context);
          }
          return current is PostDeleteAccountLoading ||
              current is PostDeleteAccountSuccess ||
              current is PostDeleteAccountFailure;
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_3X),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 4))
                ],
                color: ColorConstants.WHITE,
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X)),
            padding: EdgeInsets.symmetric(
              horizontal: DimensionsHelper.SPACE_SIZE_2X,
              vertical: DimensionsHelper.SPACE_SIZE_3X,
            ),
            child: Row(
              children: [
                ImageBase(
                  ImagePathConstants.IC_DELETE,
                  width: DimensionsHelper.ONE_UNIT_SIZE * 30,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 30,
                ),
                SizedBox(
                  width: DimensionsHelper.SPACE_SIZE_2X,
                ),
                TextBase(
                  text: "Xóa tài khoản",
                  style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      color: ColorConstants.BLACK,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                      fontWeight: FontWeight.w200),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  GestureDetector _btnChangePasswordAccount() {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.CHANGE_PASSWORD_PAGE);
        },
        child: Container(
          margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_3X),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: Offset(0, 4))
              ],
              color: ColorConstants.WHITE,
              borderRadius:
                  BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X)),
          padding: EdgeInsets.symmetric(
            horizontal: DimensionsHelper.SPACE_SIZE_2X,
            vertical: DimensionsHelper.SPACE_SIZE_3X,
          ),
          child: Row(
            children: [
              ImageBase(
                ImagePathConstants.IC_CHANGE_PASSWORD,
                width: DimensionsHelper.ONE_UNIT_SIZE * 30,
                height: DimensionsHelper.ONE_UNIT_SIZE * 30,
                colorIconsSvg: Colors.black,
              ),
              SizedBox(
                width: DimensionsHelper.SPACE_SIZE_2X,
              ),
              TextBase(
                text: "Đổi mật khẩu",
                style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    color: ColorConstants.BLACK,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ));
  }

  Container _boxInfo() {
    return Container(child: BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: DimensionsHelper.ONE_UNIT_SIZE * 100,
                bottom: DimensionsHelper.ONE_UNIT_SIZE * 20,
              ),
              width: DimensionsHelper.iziSize.width,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 4))
                  ],
                  color: ColorConstants.WHITE,
                  borderRadius:
                      BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_5X)),
              margin:
                  EdgeInsets.only(top: DimensionsHelper.ONE_UNIT_SIZE * 120),
              child: Column(
                children: [
                  if (!state.isProfileLoading! && state.profile != null)
                    TextBase(
                      text: state.profile!.name!,
                      style: TextStyle(
                          color: ColorConstants.BLACK,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                          fontWeight: FontWeight.w400),
                    ),
                  SizedBox(
                    height: DimensionsHelper.SPACE_SIZE_1X,
                  ),
                  TextBase(
                    text: "---Khách hàng---",
                    style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        color: ColorConstants.BLACK,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(
                    height: DimensionsHelper.SPACE_SIZE_1X,
                  ),
                  if (!state.isProfileLoading! && state.profile != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBase(
                          text: "Hạng thành viên: ",
                          style: TextStyle(
                              fontFamily: Fonts.Lexend.name,
                              color: ColorConstants.BLACK,
                              fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                              fontWeight: FontWeight.w200),
                        ),
                        TextBase(
                          text: state.profile!.rankName!,
                          style: TextStyle(
                              fontFamily: Fonts.Lexend.name,
                              color: ColorConstants.PRIMARY_1,
                              fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                ],
              ),
            ),
            if (!state.isProfileLoading! && state.profile != null)
              Positioned(
                  top: DimensionsHelper.ONE_UNIT_SIZE * 30,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            DimensionsHelper.ONE_UNIT_SIZE * 100),
                        color: ColorConstants.WHITE),
                    padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_1X),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          DimensionsHelper.ONE_UNIT_SIZE * 100),
                      child: ImageBase(
                        !StringValid.nullOrEmpty(state.profile!.photo!)
                            ? state.profile!.photo!
                            : ImagePathConstants.IMAGE_USER_TEST,
                        width: DimensionsHelper.ONE_UNIT_SIZE * 130 * 1.25,
                        height: DimensionsHelper.ONE_UNIT_SIZE * 130 * 1.25,
                      ),
                    ),
                  )),
          ],
        );
      },
    ));
  }

  Container _header() {
    return Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        padding: EdgeInsets.symmetric(
          vertical: DimensionsHelper.ONE_UNIT_SIZE * 15,
        ),
        color: Colors.white,
        height: DimensionsHelper.ONE_UNIT_SIZE * 80,
        width: DimensionsHelper.iziSize.width,
        child: Center(
          child: TextBase(
            text: "Tài khoản",
            style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                color: ColorConstants.BLACK,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400),
          ),
        ));
  }
}
