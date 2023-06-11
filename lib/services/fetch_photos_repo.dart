import 'package:earnipay_assessment/services/base_api.dart';
import '../models/api/fetch_photos_response.dart';

class FetchPhotosRepo extends BaseApi {
  FetchPhotosRepo(String baseApi) : super(baseApi);
  Future<FetchPhotosResponse> fetchPhotos(int page) async {
    var response = await makeRequest(dio.get(
        "?page=$page&client_id=_UiJs8V68aPsm75W2wAcZXWXxbUgX6kdrDW0YRK8NKg"));
    return FetchPhotosResponse.fromJson(response);
  }
}
