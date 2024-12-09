import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/input_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/loading_image_card.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/profile_entity.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_event.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_profile_payload.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_event.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_state.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  XFile? pickImage;
  File? imageAvatar;
  String? urlAvatar;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController addressDetail = TextEditingController();

  late String photo = ImagePathConstants.IMAGE_USER_TEST;
  late String userName = '';

  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  @override
  void initState() {
    setState(() {
      photo = context.read<MainBloc>().state.profile!.photo!;
    });
    final p = context.read<MainBloc>().state.profile!;
    email.text = p.email!;
    phone.text = p.phone!;
    addressDetail.text = p.addressDetail!;
    fullName.text = p.name!;
    userName = p.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_5X,
              ),
              avatar(),
              line(),
              inputFullName(),
              line(),
              inputEmail(),
              line(),
              inputPhone(),
              line(),
              inputAddress(),
              line(),
              btnSubmit(context)
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    if (StringValid.nullOrEmpty(fullName.text)) {
      ToastHelper.toastWarning(
          title: "Họ và tên không được để trống!", context: context);
      return false;
    }

    final emailMessage = StringValid.email(email.text.trim());
    if (emailMessage != null) {
      ToastHelper.toastWarning(title: emailMessage, context: context);
      return false;
    }

    final phoneMessage = StringValid.phone(phone.text.trim());
    if (phoneMessage != null) {
      ToastHelper.toastWarning(title: phoneMessage, context: context);
      return false;
    }

    return true;
  }

  BlocBuilder btnSubmit(context) {
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (previous, current) {
        if (current is ChangeProfileSuccess) {
          ToastHelper.toastSuccess(
              title: "Thay đổi thông tin tài khoản thành công!",
              context: context);

          Profile profile = Profile(
              photo: !StringValid.nullOrEmpty(urlAvatar)
                  ? StringValid.url(urlAvatar!)
                  : StringValid.url(photo),
              addressDetail: addressDetail.text.trim(),
              email: email.text.trim(),
              name: fullName.text.trim(),
              phone: phone.text.trim(),
              username: userName);

          _sharedHelper.setProfile(jsonEncode(profile.toJson()));

          Navigator.pop(context);
        }

        if (current is ChangeProfileFailure) {
          ToastHelper.toastError(
              title: current.error.toString(), context: context);
        }
        return current is ChangeProfileLoading ||
            current is ChangeProfileSuccess ||
            current is ChangeProfileFailure;
      },
      builder: (context, state) {
        if (state is ChangeProfileSuccess) {
          context.read<MainBloc>().add(LoadProfile());
        }
        return ButtonBase(
          margin: EdgeInsets.symmetric(
              horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
          onTap: () {
            if (validate()) {
              ChangeProfilePayload payload = ChangeProfilePayload(
                  email: email.text.trim(),
                  addressDetail: addressDetail.text.trim(),
                  phone: phone.text.trim(),
                  name: fullName.text.trim());

              context.read<UserBloc>().add(ChangeProfile(payload));
            }
          },
          isLoading: state is ChangeProfileLoading ? true : false,
          height: DimensionsHelper.ONE_UNIT_SIZE * 65,
          label: "Thay đổi",
          borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
          fontSizedLabel: DimensionsHelper.ONE_UNIT_SIZE * 25,
        );
      },
    );
  }

  SizedBox line() {
    return SizedBox(
      height: DimensionsHelper.SPACE_SIZE_3X,
    );
  }

  Container inputFullName() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        type: InputBaseType.TEXT,
        allowEdit: true,
        label: 'Họ và tên',
        width: DimensionsHelper.iziSize.width,
        placeHolder: 'Nhập ---',
        fillColor: ColorConstants.WHITE,
        isBorder: true,
        controller: fullName,
      ),
    );
  }

  Container inputEmail() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        type: InputBaseType.TEXT,
        allowEdit: true,
        label: 'Email',
        width: DimensionsHelper.iziSize.width,
        placeHolder: 'Nhập ---',
        fillColor: ColorConstants.WHITE,
        isBorder: true,
        controller: email,
      ),
    );
  }

  Container inputPhone() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        type: InputBaseType.NUMBER,
        allowEdit: true,
        label: 'Số điện thoại',
        width: DimensionsHelper.iziSize.width,
        placeHolder: 'Nhập --- ',
        fillColor: ColorConstants.WHITE,
        isBorder: true,
        controller: phone,
      ),
    );
  }

  Container inputAddress() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: InputBase(
        height: DimensionsHelper.ONE_UNIT_SIZE * 70,
        borderRadius: DimensionsHelper.BORDER_RADIUS_4X,
        type: InputBaseType.TEXT,
        allowEdit: true,
        label: 'Địa chỉ',
        width: DimensionsHelper.iziSize.width,
        placeHolder: 'Nhập ---',
        fillColor: ColorConstants.WHITE,
        isBorder: true,
        controller: addressDetail,
      ),
    );
  }

  void updateProfile(String url) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<MainBloc>().add(UpdateAvatar(url));
    });
  }

  Center avatar() {
    return Center(
      key: const Key('avatar'),
      child: Stack(children: [
        GestureDetector(
            onTap: () {
              pickAvatar();
            },
            child: Column(
              children: [
                BlocBuilder<UserBloc, UserState>(
                  buildWhen: (previous, current) {
                    if (current is UploadAvatarSuccess) {
                      ToastHelper.toastSuccess(
                          title: "Thay đổi avatar thành công!",
                          context: context);
                      updateProfile(current.message);
                    }
                    return current is UploadAvatarLoading ||
                        current is UploadAvatarSuccess ||
                        current is UploadAvatarFailure;
                  },
                  builder: (context, state) {
                    if (state is UploadAvatarLoading) {
                      return LoadingImageCard(
                        width: DimensionsHelper.ONE_UNIT_SIZE * 180,
                        height: DimensionsHelper.ONE_UNIT_SIZE * 180,
                        borderSize: DimensionsHelper.ONE_UNIT_SIZE * 180,
                      );
                    }
                    if (state is UploadAvatarFailure) {
                      ToastHelper.toastError(
                          title: "Cập nhật ảnh đại diện thất bại.",
                          context: context);
                    }
                    if (state is UploadAvatarSuccess && imageAvatar != null) {
                      urlAvatar = state.message;

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            DimensionsHelper.ONE_UNIT_SIZE * 180),
                        child: Stack(children: [
                          SizedBox(
                            width: DimensionsHelper.ONE_UNIT_SIZE * 180,
                            height: DimensionsHelper.ONE_UNIT_SIZE * 180,
                            child: ImageBase.file(
                              imageAvatar,
                              width: DimensionsHelper.ONE_UNIT_SIZE * 180,
                              height: DimensionsHelper.ONE_UNIT_SIZE * 180,
                            ),
                          ),
                        ]),
                      );
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(
                          DimensionsHelper.ONE_UNIT_SIZE * 180),
                      child: Stack(children: [
                        SizedBox(
                          width: DimensionsHelper.ONE_UNIT_SIZE * 180,
                          height: DimensionsHelper.ONE_UNIT_SIZE * 180,
                          child: ImageBase(
                            photo,
                            width: DimensionsHelper.ONE_UNIT_SIZE * 180,
                            height: DimensionsHelper.ONE_UNIT_SIZE * 180,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(169, 169, 169, 0.4),
                            ),
                            height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                            width: DimensionsHelper.ONE_UNIT_SIZE * 180,
                            child: Center(
                                child: TextBase(
                              text: 'Tải ảnh lên',
                              style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  color: ColorConstants.WHITE,
                                  fontWeight: FontWeight.w200,
                                  fontSize:
                                      DimensionsHelper.FONT_SIZE_SPAN_SMALL *
                                          0.95),
                            )),
                          ),
                        )
                      ]),
                    );
                  },
                )
              ],
            ))
      ]),
    );
  }

  Future<void> pickAvatar() async {
    final images = await ImagePicker().pickImage(source: ImageSource.gallery);
    pickImage = images;

    if (images == null) return;
    setState(() {
      imageAvatar = File(images.path);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(UploadAvatar(images));
    });
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Thông tin tài khoản",
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
