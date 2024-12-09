import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/loading_image_card.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class ItemGiftLoading extends StatelessWidget {
  const ItemGiftLoading({super.key});

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
                  LoadingImageCard(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 120,
                    width: DimensionsHelper.ONE_UNIT_SIZE * 120,
                    borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
                  ),
                  SizedBox(
                    width: DimensionsHelper.SPACE_SIZE_2X,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingImageCard(
                        height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                        width: DimensionsHelper.ONE_UNIT_SIZE * 150,
                        borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
                      ),
                      SizedBox(
                        height: DimensionsHelper.SPACE_SIZE_2X,
                      ),
                      LoadingImageCard(
                        height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                        width: DimensionsHelper.ONE_UNIT_SIZE * 250,
                        borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
                      ),
                    ],
                  ),
                ],
              ),
              LoadingImageCard(
                height: DimensionsHelper.ONE_UNIT_SIZE * 70,
                width: DimensionsHelper.ONE_UNIT_SIZE * 70,
                borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
              ),
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_4X,
          ),
          Row(
            children: [
              LoadingImageCard(
                height: DimensionsHelper.ONE_UNIT_SIZE * 130,
                width: DimensionsHelper.ONE_UNIT_SIZE * 130,
                borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
              ),
              SizedBox(
                width: DimensionsHelper.SPACE_SIZE_2X,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoadingImageCard(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                    width: DimensionsHelper.ONE_UNIT_SIZE * 300,
                    borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
                  ),
                  LoadingImageCard(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                    width: DimensionsHelper.ONE_UNIT_SIZE * 120,
                    borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
                  ),
                  LoadingImageCard(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                    width: DimensionsHelper.ONE_UNIT_SIZE * 170,
                    borderSize: DimensionsHelper.ONE_UNIT_SIZE * 13,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_5X,
          )
        ],
      ),
    );
  }
}
