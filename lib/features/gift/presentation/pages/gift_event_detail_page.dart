import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/features/gift/data/models/gift_event_detail_page_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_bloc.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_event.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_state.dart';
import 'package:suri_checking_event_app/features/gift/presentation/widgets/item_gift.dart';
import 'package:suri_checking_event_app/features/gift/presentation/widgets/item_gift_loading.dart';

class GiftEventDetailPage extends StatefulWidget {
  const GiftEventDetailPage({super.key, required this.args});

  final GiftEventDetailPageArguments args;

  @override
  State<GiftEventDetailPage> createState() => _GiftEventDetailPageState();
}

class _GiftEventDetailPageState extends State<GiftEventDetailPage> {
  late int id;

  @override
  void initState() {
    super.initState();

    id = widget.args.id;

    context.read<GiftBloc>().add(GetListGiftOfEvent(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        margin:
            EdgeInsets.symmetric(vertical: DimensionsHelper.HORIZONTAL_SCREEN),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GiftBloc, GiftState>(
                buildWhen: (previous, current) {
                  return current is ListGiftOfEventLoading ||
                      current is ListGiftOfEventSuccess ||
                      current is ListGiftOfEventFailure;
                },
                builder: (context, state) {
                  if (state is ListGiftOfEventLoading) {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: DimensionsHelper.HORIZONTAL_SCREEN,
                        );
                      },
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const ItemGiftLoading();
                      },
                    );
                  }

                  if (state is ListGiftOfEventSuccess) {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: DimensionsHelper.HORIZONTAL_SCREEN,
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.list.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ItemGift(
                          item: state.list[index],
                        );
                      },
                    );
                  }

                  return SizedBox(
                    height: DimensionsHelper.iziSize.height -
                        DimensionsHelper.ONE_UNIT_SIZE * 200,
                    child: const Center(
                      child: BoxEmpty(
                        title: 'Hiện tại sự kiện chưa có quà',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Danh sách quà tặng",
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
