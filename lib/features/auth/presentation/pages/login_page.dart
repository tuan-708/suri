import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/input_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/other_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_apple_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_google_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_payload.dart';
import 'package:suri_checking_event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool isAvailableFutureAppleSignIn = false;
  User? _userIOS;

  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (!StringValid.nullOrEmpty(googleUser)) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        final UserCredential user =
            await FirebaseAuth.instance.signInWithCredential(credential);

        LoginGooglePayload payload = LoginGooglePayload(
            Email: user.user!.email ?? "",
            FullName: user.user!.displayName ?? "",
            Photo: user.user!.photoURL ?? '',
            Id: user.user!.uid);

        context.read<AuthBloc>().add(PostLoginGoogle(payload));
      } else {
        // ignore: use_build_context_synchronously
        ToastHelper.toastInfo(
            title: 'Bạn đã hủy bỏ đăng nhập', context: context);
      }
    } catch (e) {
      ToastHelper.toastInfo(title: e.toString(), context: context);
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple() async {
    if (isAvailableFutureAppleSignIn == true) {
      try {
        final rawNonce = generateNonce();
        final nonce = sha256ofString(rawNonce);

        // Request credential for the currently signed in Apple account.
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: nonce,
        );

        final familyName = appleCredential.familyName ?? "";
        final givenName = appleCredential.givenName ?? "";

        LoginApplePayload payload = LoginApplePayload(
            Email: appleCredential.email ?? "",
            FullName: "$familyName $givenName",
            Id: appleCredential.userIdentifier ?? "");

        context.read<AuthBloc>().add(PostLoginApple(payload));
      } catch (e) {
        ToastHelper.toastInfo(
            title: 'Bạn đã hủy bỏ đăng nhập', context: context);
      }
    } else {
      ToastHelper.toastInfo(
          title: 'Đăng nhập không thành công!', context: context);
    }
  }

  Future<void> checkAvailableAppleLogin() async {
    isAvailableFutureAppleSignIn = await TheAppleSignIn.isAvailable();
    if (isAvailableFutureAppleSignIn == true) {
      TheAppleSignIn.onCredentialRevoked!.listen((data) {});
    }
  }

  @override
  void initState() {
    super.initState();
    checkAvailableAppleLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              line1(),
              iconClose(),
              line2(),
              imgLogoApp(),
              line3(),
              inputUserName(),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_5X,
              ),
              inputPassword(),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_5X,
              ),
              textForgotPassword(context),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_3X,
              ),
              btnLogin(),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_3X,
              ),
              // line(),

              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoginGoogleSuccess) {
                    ToastHelper.toastSuccess(
                        title: "Đăng nhập thành công!", context: context);
                  }

                  if (state is LoginGoogleFailure) {
                    ToastHelper.toastError(
                        title: "Đăng nhập thất bại!", context: context);
                  }
                },
                builder: (context, state) {
                  return loginWithSocial(
                      title: "Tiếp tục với Google",
                      onTap: () async {
                        await signInWithGoogle();
                      },
                      icon: ImagePathConstants.IC_GOOGLE);
                },
              ),

              if (Platform.isIOS)
                Column(
                  children: [
                    SizedBox(
                      height: DimensionsHelper.SPACE_SIZE_3X,
                    ),
                    loginWithSocial(
                        title: "Tiếp tục với Apple",
                        onTap: () async {
                          await signInWithApple();
                        },
                        icon: ImagePathConstants.IMAGE_APPLE),
                  ],
                ),

              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_3X,
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_5X,
              ),
              footer(context)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox line3() {
    return SizedBox(
      height: DimensionsHelper.ONE_UNIT_SIZE * 50,
    );
  }

  SizedBox line2() {
    return SizedBox(
      height: DimensionsHelper.ONE_UNIT_SIZE * 60,
    );
  }

  Row iconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, AppRoutes.MAIN_PAGE);
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: OtherHelper().boxShadow,
                  color: ColorConstants.WHITE),
              child: ImageBase(
                ImagePathConstants.IC_CLOSE,
                width: DimensionsHelper.ONE_UNIT_SIZE * 70,
                height: DimensionsHelper.ONE_UNIT_SIZE * 70,
              )),
        )
      ],
    );
  }

  SizedBox line1() {
    return SizedBox(
      height: DimensionsHelper.ONE_UNIT_SIZE * 40,
    );
  }

  Container footer(BuildContext context) {
    return Container(
      width: DimensionsHelper.iziSize.width,
      margin: EdgeInsets.only(bottom: DimensionsHelper.HORIZONTAL_SCREEN),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: DimensionsHelper.ONE_UNIT_SIZE * 40,
                left: DimensionsHelper.HORIZONTAL_SCREEN,
                right: DimensionsHelper.HORIZONTAL_SCREEN),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Bằng cách tiếp tục, bạn đồng ý với ',
                style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Điều khoản dịch vụ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                              context, AppRoutes.PRIVACY_POLICY_PAGE);
                        },
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL)),
                  TextSpan(
                      text: ' của chúng tôi và xác nhận rằng bạn đã đọc ',
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL)),
                  TextSpan(
                      text: 'Chính sách quyền riêng tư',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                              context, AppRoutes.PRIVACY_POLICY_PAGE);
                        },
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL)),
                  TextSpan(
                      text: ' của chúng tôi.',
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL)),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_3X),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextBase(
                  text: 'Bạn chưa có tài khoản?',
                  style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      color: ColorConstants.BLACK,
                      fontWeight: FontWeight.w200,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN),
                ),
                SizedBox(
                  width: DimensionsHelper.SPACE_SIZE_2X,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.REGISTER_PAGE);
                  },
                  child: TextBase(
                      text: 'Đăng ký',
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          decoration: TextDecoration.underline,
                          color: ColorConstants.PRIMARY_1,
                          fontWeight: FontWeight.w400,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  GestureDetector loginWithSocial(
      {required String title,
      required String icon,
      required Function() onTap}) {
    return GestureDetector(
      onTap: () async {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
        child: GestureDetector(
          child: AbsorbPointer(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: DimensionsHelper.SPACE_SIZE_3X,
                  vertical: DimensionsHelper.SPACE_SIZE_3X),
              decoration: BoxDecoration(
                  color: ColorConstants.WHITE,
                  borderRadius: BorderRadius.all(
                      Radius.circular(DimensionsHelper.BORDER_RADIUS_3X))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: DimensionsHelper.SPACE_SIZE_2X,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: ImageBase(
                      icon,
                      width: DimensionsHelper.ONE_UNIT_SIZE * 50,
                      height: DimensionsHelper.ONE_UNIT_SIZE * 50,
                    ),
                  ),
                  SizedBox(
                    width: DimensionsHelper.SPACE_SIZE_2X,
                  ),
                  TextBase(text: title)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container line() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextBase(
            text: '----------',
          ),
          TextBase(
            text: '  Hoặc  ',
            style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                color: ColorConstants.BLACK,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL,
                fontWeight: FontWeight.w400),
          ),
          const TextBase(
            text: '----------',
          ),
        ],
      ),
    );
  }

  Container btnLogin() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is LoginLocked) {
              final timeLeft =
                  state.unlockTime.difference(DateTime.now()).inSeconds;
              ToastHelper.toastError(
                  title: 'Tài khoản bị khóa. Thử lại sau $timeLeft giây.',
                  context: context);
              setState(() {
                isLoading = false;
              });
            }

            if (state is LoginSuccess) {
              ToastHelper.toastSuccess(
                  title: "Đăng nhập tài khoản thành công!", context: context);
              Navigator.pushNamed(context, AppRoutes.MAIN_PAGE);

              _sharedHelper.setLogged(status: true);
              _sharedHelper.setJwtToken(state.profile.accessToken.toString());
              _sharedHelper
                  .setProfile(jsonEncode(state.profile.profile!.toJson()));

              setState(() {
                isLoading = false;
              });
            }
            if (state is LoginFailure) {
              ToastHelper.toastError(title: state.error, context: context);

              setState(() {
                isLoading = false;
              });
            }

            if (state is LoginLoading) {
              setState(() {
                isLoading = true;
              });
            }
          },
          builder: (context, state) {
            return ButtonBase(
                isLoading: isLoading,
                onTap: () {
                  if (StringValid.nullOrEmpty(userName.text)) {
                    ToastHelper.toastWarning(
                        title: "Tên đăng nhập không được để trống!",
                        context: context);
                    return;
                  }
                  if (StringValid.nullOrEmpty(password.text)) {
                    ToastHelper.toastWarning(
                        title: "Mật khẩu không được để trống",
                        context: context);
                    return;
                  }

                  FocusScope.of(context).requestFocus(FocusNode());

                  LoginPayload payload = LoginPayload(
                    USERNAME: userName.text,
                    PASSWORD: password.text,
                  );

                  context.read<AuthBloc>().add(PostLogin(payload));
                },
                label: 'Đăng nhập',
                fontSizedLabel: DimensionsHelper.FONT_SIZE_SPAN,
                colorBG: ColorConstants.PRIMARY_1,
                borderRadius: DimensionsHelper.BLUR_RADIUS_2X,
                fontWeight: FontWeight.w400);
          },
        ));
  }

  Container textForgotPassword(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.FORGOT_PASSWORD_PAGE);
            },
            child: TextBase(
                textAlign: TextAlign.right,
                text: 'Quên mật khẩu?',
                style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    color: ColorConstants.BLACK,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL,
                    fontWeight: FontWeight.w400)),
          )
        ],
      ),
    );
  }

  Container inputPassword() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        type: InputBaseType.PASSWORD,
        allowEdit: true,
        label: 'Mật khẩu',
        width: DimensionsHelper.iziSize.width,
        placeHolder: 'Nhập ---',
        fillColor: ColorConstants.WHITE,
        isBorder: true,
        controller: password,
      ),
    );
  }

  Container inputUserName() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        type: InputBaseType.TEXT,
        allowEdit: true,
        isBorder: true,
        label: 'Email / Số điện thoại',
        width: DimensionsHelper.iziSize.width,
        placeHolder: 'Nhập ---',
        fillColor: ColorConstants.WHITE,
        controller: userName,
      ),
    );
  }

  Center imgLogoApp() {
    return Center(
      child: ImageBase(
        ImagePathConstants.LOGO_APP,
        width: DimensionsHelper.ONE_UNIT_SIZE * 260,
        height: DimensionsHelper.ONE_UNIT_SIZE * 90,
      ),
    );
  }
}
