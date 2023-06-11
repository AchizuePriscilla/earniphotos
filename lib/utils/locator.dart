import 'package:earnipay_assessment/services/fetch_photos_repo.dart';
import 'package:earnipay_assessment/services/fetch_photos_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

///Registers dependencies
Future<void> setupLocator() async {
  const String baseApi =
      "https://api.unsplash.com/photos/";

//Services

  locator.registerLazySingleton<FetchPhotosService>(
      () => FetchPhotosService(locator()));

//Repos
  locator
      .registerLazySingleton<FetchPhotosRepo>(() => FetchPhotosRepo(baseApi));
}
