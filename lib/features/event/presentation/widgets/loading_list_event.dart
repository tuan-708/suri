import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/loading_image_card.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class LoadingListEvents extends StatelessWidget {
  const LoadingListEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Container(
          width: DimensionsHelper.iziSize.width,
          height: 2,
          color: ColorConstants.BORDER,
          margin: EdgeInsets.symmetric(
              horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
        );
      },
      itemBuilder: (context, index) {
        return Container(
            padding: EdgeInsets.symmetric(
              horizontal: DimensionsHelper.HORIZONTAL_SCREEN,
              vertical: DimensionsHelper.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                LoadingImageCard(
                  height: DimensionsHelper.ONE_UNIT_SIZE * 180,
                  width: DimensionsHelper.ONE_UNIT_SIZE * 220,
                ),
                SizedBox(
                  width: DimensionsHelper.SPACE_SIZE_2X,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoadingImageCard(
                      height: DimensionsHelper.ONE_UNIT_SIZE * 40,
                      width: DimensionsHelper.ONE_UNIT_SIZE * 250,
                    ),
                    SizedBox(
                      height: DimensionsHelper.SPACE_SIZE_2X,
                    ),
                    LoadingImageCard(
                      height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                      width: DimensionsHelper.ONE_UNIT_SIZE * 180,
                    ),
                    SizedBox(
                      height: DimensionsHelper.SPACE_SIZE_2X,
                    ),
                    LoadingImageCard(
                      height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                      width: DimensionsHelper.ONE_UNIT_SIZE * 150,
                    ),
                  ],
                )
              ],
            ));
      },
      itemCount: 10,
    );
  }
}
