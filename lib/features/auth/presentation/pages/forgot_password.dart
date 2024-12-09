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
import 'package:suri_checking_event_app/features/auth/data/models/send_otp_payload.dart';
import 'package:suri_checking_event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:suri_checking_event_app/di_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
        child: Column(
          children: [
            SizedBox(
              height: DimensionsHelper.HORIZONTAL_SCREEN,
            ),
            title(),
            inputEmail(),
            btnSubmit()
          ],
        ),
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
        label: 'Email ',
        placeHolder: 'Nhập email',
        isBorder: true,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        controller: email,
      ),
    );
  }

  TextBase title() {
    return TextBase(
        maxLine: 2,
        textAlign: TextAlign.center,
        text: 'Vui lòng nhập thông tin đăng nhập của bạn',
        style: TextStyle(
            fontFamily: Fonts.Lexend.name,
            color: ColorConstants.BLACK,
            fontSize: DimensionsHelper.FONT_SIZE_SPAN_SMALL,
            fontWeight: FontWeight.w300));
  }

  bool validate() {
    final emailMessage = StringValid.email(email.text.trim());
    if (emailMessage != null) {
      ToastHelper.toastWarning(title: emailMessage, context: context);
      return false;
    }
    return true;
  }

  bool validateSendOtp() {
    final emailMessage = StringValid.email(email.text.trim());
    if (emailMessage != null) {
      ToastHelper.toastWarning(title: emailMessage, context: context);
      return false;
    }
    final passwordMessage = StringValid.password(newPassword.text.trim());
    if (passwordMessage != null) {
      ToastHelper.toastWarning(title: passwordMessage, context: context);
      return false;
    }
    if (otp.text.length < 6) {
      ToastHelper.toastWarning(title: "OTP không hợp lệ!", context: context);
      return false;
    }
    return true;
  }

  void showModalOtp(BuildContext contextParent) async {
    final result = await showDialog(
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
                        height: DimensionsHelper.ONE_UNIT_SIZE * 510,
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextBase(
                                text: "Nhập thông tin",
                                style: TextStyle(
                                    fontFamily: Fonts.Lexend.name,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: DimensionsHelper.FONT_SIZE_SPAN),
                              ),
                              SizedBox(
                                height: DimensionsHelper.SPACE_SIZE_3X,
                              ),
                              InputBase(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                                type: InputBaseType.PASSWORD,
                                isRequired: true,
                                allowEdit: true,
                                label: 'Mật khẩu mới ',
                                placeHolder: 'Nhập mật khẩu mới',
                                isBorder: true,
                                borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
                                controller: newPassword,
                              ),
                              SizedBox(
                                height: DimensionsHelper.SPACE_SIZE_3X,
                              ),
                              InputBase(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                                type: InputBaseType.NUMBER,
                                isRequired: true,
                                allowEdit: true,
                                label: 'OTP',
                                placeHolder: 'Nhập otp',
                                isBorder: true,
                                borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
                                controller: otp,
                                onChanged: (value) {
                                  if (value.length > 6) {
                                    otp.text = value.substring(0, 6);
                                  }
                                },
                              ),
                              SizedBox(
                                height: DimensionsHelper.SPACE_SIZE_3X,
                              ),
                              BlocBuilder<AuthBloc, AuthState>(
                                buildWhen: (previous, current) {
                                  if (current is PostSendOtpSuccess) {
                                    ToastHelper.toastSuccess(
                                        title: "Thay đổi mật khẩu thành công!",
                                        context: context);
                                    Navigator.pushNamed(
                                        context, AppRoutes.LOGIN_PAGE);
                                  }
                                  if (current is PostSendOtpFailure) {
                                    ToastHelper.toastError(
                                        title: current.error, context: context);
                                    Navigator.pop(context);
                                  }
                                  return current is PostSendOtpLoading ||
                                      current is PostSendOtpSuccess ||
                                      current is PostSendOtpFailure;
                                },
                                builder: (context, state) {
                                  return ButtonBase(
                                    isLoading: state is PostSendOtpLoading
                                        ? true
                                        : false,
                                    onTap: () {
                                      if (validateSendOtp()) {
                                        SendOTPPayload payload = SendOTPPayload(
                                            Email: email.text,
                                            newPassword: newPassword.text,
                                            hash: otp.text);

                                        context
                                            .read<AuthBloc>()
                                            .add(PostSendOtp(payload));
                                      }
                                    },
                                    label: "Xác nhận ",
                                    height: DimensionsHelper.ONE_UNIT_SIZE * 65,
                                    fontSizedLabel:
                                        DimensionsHelper.ONE_UNIT_SIZE * 24,
                                  );
                                },
                              )
                            ])))),
          ),
        );
      },
    );

    if (result == null) {
      newPassword.text = "";
      otp.text = "";
    }
  }

  Container btnSubmit() {
    return Container(
        padding: EdgeInsets.only(top: DimensionsHelper.HORIZONTAL_SCREEN),
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            if (current is ForgotPasswordSuccess) {
              ToastHelper.toastSuccess(
                  title: "Gửi otp thành công!", context: context);
              showModalOtp(context);
            }
            if (current is ForgotPasswordFailure) {
              ToastHelper.toastError(title: current.error, context: context);
            }
            return current is ForgotPasswordLoading ||
                current is ForgotPasswordSuccess ||
                current is ForgotPasswordFailure;
          },
          builder: (context, state) {
            return ButtonBase(
                onTap: () {
                  if (validate()) {
                    context
                        .read<AuthBloc>()
                        .add(PostForgotPassword(email.text.trim()));
                  }
                },
                isLoading: state is ForgotPasswordLoading ? true : false,
                label: 'Gửi yêu cầu',
                fontSizedLabel: DimensionsHelper.FONT_SIZE_SPAN,
                colorBG: ColorConstants.PRIMARY_1,
                borderRadius: DimensionsHelper.BLUR_RADIUS_3X,
                height: DimensionsHelper.ONE_UNIT_SIZE * 65,
                fontWeight: FontWeight.w400);
          },
        ));
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Quên mật khẩu",
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
