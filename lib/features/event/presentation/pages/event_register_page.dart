import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/drop_down_button_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/input_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_register_payload.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_detail_entity.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';

class EventRegisterPage extends StatefulWidget {
  const EventRegisterPage({super.key, required this.args});
  final EventDetailEntity args;

  @override
  State<EventRegisterPage> createState() => _EventRegisterPageState();
}

class _EventRegisterPageState extends State<EventRegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController gmail = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController expectedDueDate = TextEditingController();
  TextEditingController motherType = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController phone = TextEditingController();

  final _sharedHelper = sl.get<SharedPreferenceHelper>();
  String typeAccount = '1';

  void getProfile() async {
    final profile = await _sharedHelper.getProfile();
    username.text = profile!.name!;
    phone.text = profile.phone!;
    gmail.text = profile.email!;
    address.text = profile.addressDetail!;
  }

  @override
  void initState() {
    super.initState();

    getProfile();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _boxContent(),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: DimensionsHelper.SPACE_SIZE_3X),
                child: TextBase(
                    text: "Thông tin của bạn",
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.BLACK,
                    )),
              ),
              Container(
                key: const Key('Tên của bạn'),
                child: InputBase(
                  controller: username,
                  borderRadius: DimensionsHelper.BORDER_RADIUS_3X,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                  type: InputBaseType.TEXT,
                  allowEdit: false,
                  placeHolder: 'Tên của bạn',
                  isBorder: true,
                  colorBorder: ColorConstants.PLACE1,
                  fillColor: ColorConstants.WHITE,
                ),
              ),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              Container(
                key: const Key('Số điện thoại'),
                child: InputBase(
                  borderRadius: DimensionsHelper.BORDER_RADIUS_3X,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                  type: InputBaseType.TEXT,
                  allowEdit: true,
                  placeHolder: 'Số điện thoại',
                  isBorder: true,
                  colorBorder: ColorConstants.PLACE1,
                  fillColor: ColorConstants.WHITE,
                  controller: phone,
                ),
              ),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              Container(
                key: const Key('Email'),
                child: InputBase(
                  borderRadius: DimensionsHelper.BORDER_RADIUS_3X,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                  type: InputBaseType.TEXT,
                  allowEdit: true,
                  placeHolder: 'Email',
                  isBorder: true,
                  colorBorder: ColorConstants.PLACE1,
                  fillColor: ColorConstants.WHITE,
                  controller: gmail,
                ),
              ),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              Container(
                key: const Key('Địa chỉ'),
                child: InputBase(
                  borderRadius: DimensionsHelper.BORDER_RADIUS_3X,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                  type: InputBaseType.TEXT,
                  allowEdit: true,
                  placeHolder: 'Địa chỉ',
                  isBorder: true,
                  colorBorder: ColorConstants.PLACE1,
                  fillColor: ColorConstants.WHITE,
                  controller: address,
                ),
              ),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              SingleDropDownBase(
                  hint: 'Mẹ bầu',
                  items: [
                    Item(key: '1', value: 'Mẹ bầu'),
                    Item(key: '2', value: 'Mẹ bỉm')
                  ],
                  selectedValue: typeAccount,
                  borderBtn: DimensionsHelper.BORDER_RADIUS_3X,
                  backgroundButton: ColorConstants.WHITE,
                  heightBtn: DimensionsHelper.ONE_UNIT_SIZE * 70,
                  borderColor: ColorConstants.BORDER,
                  widthBtn: DimensionsHelper.iziSize.width -
                      2 * DimensionsHelper.HORIZONTAL_SCREEN,
                  borderSize: 1,
                  onChanged: (value) {
                    setState(() {
                      typeAccount = value!;
                    });
                  }),
              if (typeAccount == "1")
                Column(
                  children: [
                    SizedBox(
                      height: DimensionsHelper.HORIZONTAL_SCREEN,
                    ),
                    InputBase(
                      isRequired: true,
                      type: InputBaseType.TEXT,
                      isBorder: true,
                      colorBorder: ColorConstants.PLACE1,
                      fillColor: ColorConstants.WHITE,
                      isDatePicker: true,
                      iziPickerDate: PickerDateType.CUPERTINO,
                      borderRadius: DimensionsHelper.SPACE_SIZE_1X,
                      textInputAction: TextInputAction.next,
                      initDate: DateTime.now(),
                      maximumDate:
                          DateTime.now().add(const Duration(days: 365)),
                      height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                      contentPaddingIncrement: EdgeInsets.only(
                          top: DimensionsHelper.ONE_UNIT_SIZE * 33,
                          left: 10,
                          right: 10),
                      placeHolder: 'Ngày dự kiến sinh',
                      onChanged: (value) {},
                      controller: expectedDueDate,
                    ),
                  ],
                ),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              Container(
                key: const Key('Ghi chú'),
                child: InputBase(
                  borderRadius: DimensionsHelper.BORDER_RADIUS_3X,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 150,
                  type: InputBaseType.TEXT,
                  maxLine: 5,
                  allowEdit: true,
                  placeHolder: 'Ghi chú',
                  isBorder: true,
                  colorBorder: ColorConstants.PLACE1,
                  fillColor: ColorConstants.WHITE,
                  controller: notes,
                ),
              ),
              SizedBox(
                height: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              _button()
            ],
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    final phoneMessage = StringValid.phone(phone.text);

    if (phoneMessage != null) {
      ToastHelper.toastWarning(title: phoneMessage, context: context);
      return false;
    }

    final emailMessage = StringValid.email(gmail.text);
    if (emailMessage != null) {
      ToastHelper.toastWarning(title: emailMessage, context: context);
      return false;
    }

    if (StringValid.nullOrEmpty(address.text)) {
      ToastHelper.toastWarning(
          title: 'Địa chỉ không được để trống', context: context);
      return false;
    }

    if (typeAccount == "1") {
      if (StringValid.nullOrEmpty(expectedDueDate.text)) {
        ToastHelper.toastWarning(
            title: 'Ngày sinh dự kiến không được để trống', context: context);
        return false;
      }
    }

    return true;
  }

  GestureDetector _button() {
    return GestureDetector(
      onTap: () {
        if (validateForm()) {
          EventRegisterPayload payload = EventRegisterPayload(
              Address: address.text.trim(),
              Description: notes.text.trim(),
              EventAccountTypeId: statusEvent['Sắp diễn ra'],
              EventId: widget.args.id,
              Gmail: gmail.text.trim(),
              Name: username.text.trim(),
              Note: expectedDueDate.text.trim(),
              Phone: phone.text.trim(),
              Info: '',
              TypeAccount: int.parse(typeAccount));

          context.read<EventBloc>().add(PostEventRegisterEvent(payload));
        }
      },
      child: AbsorbPointer(
        child: BlocBuilder<EventBloc, EventState>(
          buildWhen: (previous, current) {
            if (current is EventRegisterSuccess) {
              context.read<EventBloc>().add(GetEventDetail(widget.args.id));
              ToastHelper.toastSuccess(
                  title: 'Đăng ký sự kiện thành công', context: context);

              Navigator.pop(context);
            }

            if (current is EventRegisterFailure) {
              ToastHelper.toastError(
                  title: 'Đăng ký sự kiện thất bại', context: context);
            }

            return current is EventRegisterLoading ||
                current is EventRegisterSuccess ||
                current is EventRegisterFailure;
          },
          builder: (context, state) {
            return Container(
              width: DimensionsHelper.iziSize.width,
              height: DimensionsHelper.ONE_UNIT_SIZE * 70,
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
              child: Center(
                child: TextBase(
                  text: state is EventRegisterLoading
                      ? "Đang tải ..."
                      : "Đăng ký tham gia",
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.WHITE,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _boxContent() {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
      margin: EdgeInsets.only(top: DimensionsHelper.HORIZONTAL_SCREEN),
      width: DimensionsHelper.iziSize.width -
          DimensionsHelper.HORIZONTAL_SCREEN * 2,
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
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBase(
              text: widget.args.name,
              maxLine: 2,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              )),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_1X * 0.7,
          ),
          Row(
            children: [
              ImageBase(ImagePathConstants.IC_ADDRESS),
              SizedBox(
                width: DimensionsHelper.SPACE_SIZE_1X,
              ),
              Expanded(
                child: TextBase(
                    maxLine: 2,
                    text: widget.args.info,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                      fontWeight: FontWeight.w200,
                      color: ColorConstants.BLACK,
                    )),
              )
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_1X * 0.7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBase(
                  text: DateFormat('dd.MM.yyyy - hh:mm')
                      .format(widget.args.startDate),
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.PRIMARY_1,
                  )),
              TextBase(
                  text: widget.args.eventStatusName,
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.PRIMARY_3,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Đăng ký tham gia",
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
