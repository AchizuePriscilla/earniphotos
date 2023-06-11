import 'package:earnipay_assessment/models/api/fetch_photos_response.dart';
import 'package:earnipay_assessment/services/fetch_photos_repo.dart';

class FetchPhotosService {
  final FetchPhotosRepo fetchPhotosRepo;

  FetchPhotosService(this.fetchPhotosRepo);

  Future<FetchPhotosResponse> fetchPhotos(int page) async {
    var response = await fetchPhotosRepo.fetchPhotos(page);

    return response;
  }
}
