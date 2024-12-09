import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/input_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/auth/presentation/pages/login_page.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_password_payload.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_event.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_state.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        padding:
            EdgeInsets.symmetric(vertical: DimensionsHelper.HORIZONTAL_SCREEN),
        child: Column(
          children: [
            inputOldPassword(),
            line(),
            inputNewPassword(),
            line(),
            inputRePassword(),
            line(),
            BlocBuilder<UserBloc, UserState>(
              buildWhen: (previous, current) {
                if (current is PostChangePasswordSuccess) {
                  ToastHelper.toastSuccess(
                      title: "Thay đỏi mật khẩu thành công!", context: context);

                  _sharedHelper.setJwtToken('');
                  _sharedHelper.setLogged(status: false);
                  _sharedHelper.setProfile('');

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
                }

                if (current is PostChangePasswordFailure) {
                  ToastHelper.toastError(
                      title: "Thay đỏi mật khẩu thất bại!", context: context);
                }

                return current is PostChangePasswordLoading ||
                    current is PostChangePasswordSuccess ||
                    current is PostChangePasswordFailure;
              },
              builder: (context, state) {
                return ButtonBase(
                  margin: EdgeInsets.symmetric(
                      horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
                  onTap: () {
                    if (validate()) {
                      ChangePasswordPayload payload = ChangePasswordPayload(
                          Password: oldPassword.text.trim(),
                          NewPassword: newPassword.text.trim());
                      context.read<UserBloc>().add(PostChangePassword(payload));
                    }
                  },
                  isLoading: state is PostChangePasswordLoading ? true : false,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 65,
                  label: "Thay đổi",
                  borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
                  fontSizedLabel: DimensionsHelper.ONE_UNIT_SIZE * 25,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  SizedBox line() {
    return SizedBox(
      height: DimensionsHelper.HORIZONTAL_SCREEN,
    );
  }

  bool validate() {
    final passwordMessage = StringValid.password(oldPassword.text.trim());
    if (passwordMessage != null) {
      ToastHelper.toastWarning(title: passwordMessage, context: context);
      return false;
    }

    final newPasswordMessage = StringValid.password(newPassword.text.trim());
    if (newPasswordMessage != null) {
      ToastHelper.toastWarning(title: newPasswordMessage, context: context);
      return false;
    }

    if (newPassword.text.trim() != rePassword.text.trim()) {
      ToastHelper.toastWarning(
          title: "Mật khẩu không trùng khớp!", context: context);
      return false;
    }

    if (oldPassword.text.trim() == newPassword.text.trim()) {
      ToastHelper.toastWarning(
          title: "Mật khẩu mới không được trùng mới mật khẩu cũ!",
          context: context);
      return false;
    }

    return true;
  }

  Container inputOldPassword() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        type: InputBaseType.PASSWORD,
        allowEdit: true,
        isRequired: true,
        label: 'Mật khẩu cũ ',
        width: DimensionsHelper.iziSize.width,
        placeHolder: 'Nhập mật khẩu cũ',
        fillColor: ColorConstants.WHITE,
        isBorder: true,
        controller: oldPassword,
      ),
    );
  }

  Container inputNewPassword() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        type: InputBaseType.PASSWORD,
        allowEdit: true,
        isRequired: true,
        label: 'Mật khẩu mới ',
        width: DimensionsHelper.iziSize.width,
        placeHolder: 'Nhập mật khẩu mới',
        fillColor: ColorConstants.WHITE,
        isBorder: true,
        controller: newPassword,
      ),
    );
  }

  Container inputRePassword() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        type: InputBaseType.PASSWORD,
        allowEdit: true,
        isRequired: true,
        label: 'Xác nhận mật khẩu',
        width: DimensionsHelper.iziSize.width,
        placeHolder: 'Xác nhận mật khẩu',
        fillColor: ColorConstants.WHITE,
        isBorder: true,
        controller: rePassword,
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Đổi mật khẩu",
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
