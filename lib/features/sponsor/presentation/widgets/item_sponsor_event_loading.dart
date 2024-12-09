import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/loading_image_card.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class ItemSponsorEventLoading extends StatelessWidget {
  const ItemSponsorEventLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            DimensionsHelper.BORDER_RADIUS_4X)),
                    child: LoadingImageCard(
                      height: DimensionsHelper.ONE_UNIT_SIZE * 120,
                      width: DimensionsHelper.ONE_UNIT_SIZE * 120,
                      borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
                    ),
                  ),
                  SizedBox(
                    width: DimensionsHelper.SPACE_SIZE_2X,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                DimensionsHelper.BORDER_RADIUS_4X)),
                        child: LoadingImageCard(
                          height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                          width: DimensionsHelper.ONE_UNIT_SIZE * 150,
                          borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
                        ),
                      ),
                      SizedBox(
                        height: DimensionsHelper.SPACE_SIZE_2X,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                DimensionsHelper.BORDER_RADIUS_4X)),
                        child: LoadingImageCard(
                          height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                          width: DimensionsHelper.ONE_UNIT_SIZE * 250,
                          borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_4X,
          ),
        ],
      ),
    );
  }
}
