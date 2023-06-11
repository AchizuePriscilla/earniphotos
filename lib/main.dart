import 'package:earnipay_assessment/presentation/views/photos_view.dart';
import 'package:earnipay_assessment/utils/locator.dart';
import 'package:earnipay_assessment/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ScreenUtil for responsiveness
    return ScreenUtilInit(
        designSize: const Size(390, 852),
        builder: (_, __) {
          return MultiProvider(
              providers: AppProvider.providers,
              builder: (context, child) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: const PhotosView(),
                );
              });
        });
  }
}
