import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_assessment/presentation/viewmodels/photos_viewmodel.dart';
import 'package:earnipay_assessment/presentation/views/photo_description_view.dart';
import 'package:earnipay_assessment/presentation/views/shared/custom_spacer.dart';
import 'package:earnipay_assessment/presentation/views/shared/palette.dart';
import 'package:earnipay_assessment/presentation/views/shared/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PhotosView extends StatefulWidget {
  const PhotosView({super.key});

  @override
  State<PhotosView> createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PhotosViewModel>().fetchPhotos(reset: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("EarniPhotos"),
        backgroundColor: Palette.earniPayGreen,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Consumer<PhotosViewModel>(builder: (_, photosVM, __) {
          if (photosVM.pageLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Palette.earniPayGreen),
              ),
            );
          }
          return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels <
                scrollInfo.metrics.minScrollExtent - 70) {
              photosVM.fetchPhotos(refresh: true);
            } else if (scrollInfo.metrics.pixels >
                scrollInfo.metrics.maxScrollExtent + 70) {
              photosVM.fetchPhotos(
                  nextPage: true, controller: scrollController);
            } else {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                photosVM.setFetchingPhotos(false);
                photosVM.setPhotosRefreshingStatus(false);
              });
            }
            return true;
          }, child: Builder(
            builder: (_) {
              //If API call fails, display an error widget and allow refreshing
              if (!photosVM.fetchingPhotos &&
                  !photosVM.pageLoading &&
                  photosVM.photos.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => photosVM.fetchPhotos(),
                  child: const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ErrorWidget(
                        text:
                            "An Error has occured, please check your internet connection and pull to refresh"),
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    //Luckily, flutter's gridview already implements lazy loading
                    //So, elements on the grid are loaded as you scroll
                    child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemCount: photosVM.photos.length,
                        controller: scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 15.w,
                            childAspectRatio: 3.5 / 5),
                        itemBuilder: (context, index) {
                          var photoModel = photosVM.photos[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PhotoDescriptionView(
                                    photoModel: photoModel);
                              }));
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.w),
                                    //The CachedNetworkImage widget handles caching and loading of network images efficiently
                                    child: CachedNetworkImage(
                                      imageUrl: photoModel.url!,
                                      fit: BoxFit.cover,
                                      //The placeholder is displayed while the image is still loading
                                      placeholder: (context, url) {
                                        return const PhotoShimmer();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  Column(
                    children: [
                      const CustomSpacer(
                        flex: 3,
                      ),
                      Visibility(
                        visible: photosVM.fetchingPhotos,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Palette.earniPayGreen),
                        ),
                      ),
                      const CustomSpacer(
                        flex: 3,
                      ),
                    ],
                  )
                ],
              );
            },
          ));
        }),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String text;
  const ErrorWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .3,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/error.png"))),
        ),
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class PhotoShimmer extends StatelessWidget {
  const PhotoShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(width: 100.w, height: 20.h),
          CustomSpacer(
            flex: 5.h,
          ),
          ShimmerWidget(width: 120.w, height: 20.h),
          CustomSpacer(
            flex: 5.h,
          ),
          ShimmerWidget(width: 140.w, height: 20.h),
        ],
      ),
    );
  }
}
