import 'package:dartz/dartz.dart';
import 'package:earnipay_assessment/models/photo_model.dart';

import 'api_response.dart';

class FetchPhotosResponse {
  final bool success;
  final List<PhotoModel>? photos;
  FetchPhotosResponse({this.success = false, this.photos});

  factory FetchPhotosResponse.fromJson(Either<Failure, Success> json) {
    return json.fold(
        (failure) => FetchPhotosResponse(),
        (success) => FetchPhotosResponse(
            success: true,
            photos:
                (success.data).map((e) => PhotoModel.fromJson(e)).toList()));
  }
}
