import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  const ShimmerWidget({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(.8),
        highlightColor: Colors.grey.withOpacity(0.04),
        period: const Duration(seconds: 5),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.8),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
        ));
  }
}
