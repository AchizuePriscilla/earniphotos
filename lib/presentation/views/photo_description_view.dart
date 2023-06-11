import 'package:earnipay_assessment/models/photo_model.dart';
import 'package:earnipay_assessment/presentation/views/shared/custom_spacer.dart';
import 'package:earnipay_assessment/presentation/views/shared/palette.dart';
import 'package:earnipay_assessment/presentation/views/shared/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoDescriptionView extends StatelessWidget {
  final PhotoModel photoModel;
  const PhotoDescriptionView({super.key, required this.photoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Description"),
        backgroundColor: Palette.earniPayGreen,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            const CustomSpacer(
              flex: 2,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 55.h,
                  width: 55.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Palette.earniPayGreen),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70.h),
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: CachedNetworkImage(
                        imageUrl: photoModel.authorImage!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return ShimmerWidget(
                            width: 70.h,
                            height: 70.h,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const CustomSpacer(
                  flex: 2,
                  horizontal: true,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      photoModel.authorName!,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.sp),
                    ),
                    const CustomSpacer(
                      flex: 1.5,
                    ),
                    Text(
                      photoModel.availbleForHire!
                          ? "Available for hire"
                          : "Not available for hire",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.sp),
                    )
                  ],
                )
              ],
            ),
            const CustomSpacer(
              flex: 5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .45,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return ShimmerWidget(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .45);
                  },
                  imageUrl: photoModel.url!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const CustomSpacer(
              flex: 5,
            ),
            Expanded(
                child: Text(
              photoModel.description!.isEmpty
                  ? "This photo has no description"
                  : photoModel.description!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }
}
