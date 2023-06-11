import 'package:earnipay_assessment/services/fetch_photos_service.dart';
import 'package:earnipay_assessment/utils/locator.dart';
import 'package:mocktail/mocktail.dart';

///Mock dependencies are registered for testing in this file

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

class MockFetchPhotosService extends Mock implements FetchPhotosService {}

FetchPhotosService getAndRegisterPhotosService() {
  _removeRegistrationIfExists<FetchPhotosService>();
  final service = MockFetchPhotosService();
  locator.registerSingleton<FetchPhotosService>(service);
  return service;
}
