import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:shimmer/shimmer.dart';

class LoadingImageCard extends StatelessWidget {
  const LoadingImageCard(
      {super.key,
      this.width,
      this.height,
      this.borderSize,
      this.baseColor,
      this.highlightColor});
  final double? width;
  final double? height;
  final double? borderSize;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? DimensionsHelper.ONE_UNIT_SIZE * 100,
      height: height ?? DimensionsHelper.ONE_UNIT_SIZE * 100,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          borderSize ?? DimensionsHelper.BORDER_RADIUS_2X,
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: baseColor ?? ColorConstants.NEUTRALS_6,
        highlightColor: highlightColor ?? Colors.grey.withOpacity(0.2),
        child: Container(
          width: width ?? DimensionsHelper.ONE_UNIT_SIZE * 100,
          height: height ?? DimensionsHelper.ONE_UNIT_SIZE * 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              borderSize ?? DimensionsHelper.BORDER_RADIUS_2X,
            ),
          ),
        ),
      ),
    );
  }
}
