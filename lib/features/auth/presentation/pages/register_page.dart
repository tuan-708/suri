import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/input_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/auth/data/models/register_payload.dart';
import 'package:suri_checking_event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController Name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              inputName(),
              inputEmail(),
              inputPassword(),
              inputRePassword(),
              btnRegister(),
              footer(context)
            ],
          ),
        ),
      ),
    );
  }

  Container footer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: DimensionsHelper.SPACE_SIZE_3X),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextBase(
            text: 'Bạn đã có tài khoản?',
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
              Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
            },
            child: TextBase(
                text: 'Đăng nhập',
                style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    decoration: TextDecoration.underline,
                    color: ColorConstants.PRIMARY_1,
                    fontWeight: FontWeight.w400,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN)),
          ),
        ],
      ),
    );
  }

  Container inputName() {
    return Container(
      margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_5X),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        type: InputBaseType.TEXT,
        isRequired: true,
        allowEdit: true,
        label: 'Họ và tên',
        placeHolder: 'Nhập họ và tên',
        isBorder: true,
        controller: Name,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
      ),
    );
  }

  Container inputEmail() {
    return Container(
      margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_5X),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        type: InputBaseType.TEXT,
        isRequired: true,
        allowEdit: true,
        label: 'Email',
        placeHolder: 'Nhập email',
        isBorder: true,
        controller: email,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
      ),
    );
  }

  Container inputPassword() {
    return Container(
      margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_5X),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        type: InputBaseType.PASSWORD,
        isRequired: true,
        allowEdit: true,
        label: 'Mật khẩu',
        placeHolder: 'Nhập mật khẩu',
        isBorder: true,
        controller: password,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
      ),
    );
  }

  Container inputRePassword() {
    return Container(
      margin: EdgeInsets.only(top: DimensionsHelper.SPACE_SIZE_5X),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        type: InputBaseType.PASSWORD,
        isRequired: true,
        allowEdit: true,
        label: 'Xác nhận mật khẩu',
        placeHolder: 'Xác nhận mật khẩu',
        isBorder: true,
        controller: rePassword,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Đăng ký",
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

  bool validateForm() {
    if (StringValid.nullOrEmpty(Name.text)) {
      ToastHelper.toastWarning(
          title: "Họ và tên không được để trống!", context: context);
      return false;
    }

    final emailMessage = StringValid.email(email.text);

    if (!StringValid.nullOrEmpty(emailMessage)) {
      ToastHelper.toastWarning(title: emailMessage, context: context);
      return false;
    }

    final passwordMessage = StringValid.password(password.text);
    if (!StringValid.nullOrEmpty(passwordMessage)) {
      ToastHelper.toastWarning(title: passwordMessage, context: context);
      return false;
    }

    if (password.text != rePassword.text) {
      ToastHelper.toastWarning(
          title: "Mật khẩu không trùng khớp!", context: context);
      return false;
    }

    return true;
  }

  void showModalOtp(BuildContext contextParent) {
    showDialog(
      context: contextParent,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: sl<AuthBloc>(),
          child: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(0),
                child: Dialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Container(
                        height: DimensionsHelper.iziSize.height * .25,
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextBase(
                                text: "Vui lòng nhập OTP",
                                style: TextStyle(
                                    fontFamily: Fonts.Lexend.name,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w400,
                                    fontSize: DimensionsHelper.FONT_SIZE_SPAN),
                              ),
                              SizedBox(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 30,
                              ),
                              BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  // Đăng ký email
                                  if (state is RegisterSuccess) {
                                    ToastHelper.toastSuccess(
                                        title: "Đăng ký tài khoản thành công!",
                                        context: contextParent);
                                    Navigator.pushNamed(
                                        contextParent, AppRoutes.LOGIN_PAGE);

                                    setState(() {
                                      isLoading = false;
                                    });

                                    Navigator.pushNamed(
                                        contextParent, AppRoutes.LOGIN_PAGE);
                                  }

                                  if (state is RegisterFailure) {
                                    ToastHelper.toastError(
                                        title: state.error,
                                        context: contextParent);

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  return OtpTextField(
                                    numberOfFields: 6,
                                    borderColor: ColorConstants.PRIMARY_1,
                                    focusedBorderColor:
                                        ColorConstants.PRIMARY_1,
                                    borderWidth: 2,
                                    borderRadius: BorderRadius.circular(10),
                                    textStyle: TextStyle(
                                        fontFamily: Fonts.Lexend.name,
                                        color: ColorConstants.BLACK,
                                        fontSize: DimensionsHelper.FONT_SIZE_H5,
                                        fontWeight: FontWeight.w400),
                                    cursorColor: ColorConstants.PRIMARY_1,
                                    showFieldAsBox: true,
                                    onCodeChanged: (String code) {},
                                    onSubmit: (String verificationCode) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      RegisterPayload payload = RegisterPayload(
                                          hash: verificationCode,
                                          name: Name.text.trim(),
                                          email: email.text.trim(),
                                          password: password.text.trim());

                                      context
                                          .read<AuthBloc>()
                                          .add(PostRegister(payload));
                                    },
                                  );
                                },
                              ),
                            ])))),
          ),
        );
      },
    );
  }

  Container btnRegister() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: DimensionsHelper.SPACE_SIZE_3X),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // Gửi Otp
            if (state is GetOtpRegisterSuccess) {
              ToastHelper.toastSuccess(
                  title: "Gửi mã Otp thành công!", context: context);
              showModalOtp(context);
              setState(() {
                isLoading = false;
              });
            }

            if (state is GetOtpRegisterFailure) {
              ToastHelper.toastError(title: state.error, context: context);

              setState(() {
                isLoading = false;
              });
            }
          },
          builder: (context, state) {
            return ButtonBase(
                isLoading: isLoading,
                onTap: () {
                  if (validateForm()) {
                    setState(() {
                      isLoading = true;
                    });

                    // RegisterPayload payload = RegisterPayload(
                    //     name: Name.text.trim(),
                    //     email: email.text.trim(),
                    //     password: password.text.trim());

                    // context.read<AuthBloc>().add(PostRegister(payload));

                    context
                        .read<AuthBloc>()
                        .add(GetOtpRegister(email.text.trim()));
                  }
                },
                label: 'Đăng ký',
                height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                fontSizedLabel: DimensionsHelper.FONT_SIZE_SPAN,
                colorBG: ColorConstants.PRIMARY_1,
                borderRadius: DimensionsHelper.BLUR_RADIUS_4X,
                fontWeight: FontWeight.w400);
          },
        ));
  }
}
