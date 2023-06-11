import 'package:earnipay_assessment/services/fetch_photos_service.dart';
import 'package:earnipay_assessment/utils/locator.dart';
import 'package:flutter/material.dart';

///Base view model with shared dependencies injected.
///All view models must extends this class.
class BaseViewModel extends ChangeNotifier {
  late FetchPhotosService fetchPhotosService;

  BaseViewModel({
    FetchPhotosService? fetchPhotosService,
  }) {
    this.fetchPhotosService = fetchPhotosService ?? locator();
  }

}
