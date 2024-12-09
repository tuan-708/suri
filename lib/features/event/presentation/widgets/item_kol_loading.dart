import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/loading_image_card.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class ItemKOLLoading extends StatelessWidget {
  const ItemKOLLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: DimensionsHelper.SPACE_SIZE_2X,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingImageCard(
              height: DimensionsHelper.ONE_UNIT_SIZE * 245,
              width: DimensionsHelper.ONE_UNIT_SIZE * 245,
            ),
            SizedBox(
              width: DimensionsHelper.SPACE_SIZE_2X,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingImageCard(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                    width: DimensionsHelper.ONE_UNIT_SIZE * 250,
                  ),
                  SizedBox(
                    height: DimensionsHelper.SPACE_SIZE_2X,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoadingImageCard(
                        height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                        width: DimensionsHelper.ONE_UNIT_SIZE * 100,
                      ),
                      LoadingImageCard(
                        height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                        width: DimensionsHelper.ONE_UNIT_SIZE * 80,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: DimensionsHelper.SPACE_SIZE_2X,
                  ),
                  LoadingImageCard(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 35,
                    width: DimensionsHelper.ONE_UNIT_SIZE * 150,
                  ),
                  SizedBox(
                    height: DimensionsHelper.SPACE_SIZE_2X,
                  ),
                  LoadingImageCard(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 65,
                    width: DimensionsHelper.ONE_UNIT_SIZE * 180,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
