import 'package:earnipay_assessment/models/api/fetch_photos_response.dart';
import 'package:earnipay_assessment/models/photo_model.dart';
import 'package:earnipay_assessment/presentation/viewmodels/photos_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'util.dart';

void main() {
  late PhotosViewModel photosViewModel;
  final fetchPhotosService = getAndRegisterPhotosService();
  setUp(() {
    photosViewModel = PhotosViewModel();
  });

  test(
    "Values are initialized properly",
    () {
      expect(photosViewModel.fetchingPhotos, false);
      expect(photosViewModel.pageLoading, false);
      expect(photosViewModel.refreshingPhotos, false);
      expect(photosViewModel.photos, []);
    },
  );

  group('getPhotos when API is called successfully', () {
    List<PhotoModel> mockPhotos = [
      const PhotoModel(
          url: "",
          authorBio: "",
          authorImage: "",
          authorName: "",
          availbleForHire: true)
    ];
    when(() => fetchPhotosService.fetchPhotos(any())).thenAnswer(
      (invocation) async =>
          FetchPhotosResponse(success: true, photos: mockPhotos),
    );
    test('Verify that fetchPhotosService is called', () async {
      await photosViewModel.fetchPhotos();
      verify(() => fetchPhotosService.fetchPhotos(any())).called(1);
    });

    test('''Verify that loading is indicated and
     loading stops after method call is done ''', () async {
      final future = photosViewModel.fetchPhotos();
      expect(photosViewModel.fetchingPhotos, true);
      await future;
      expect(photosViewModel.fetchingPhotos, false);
    });
    test('Verify that new photos are added to the list when next page is true',
        () async {
      final initialPhotosCount = photosViewModel.photos.length;
      await photosViewModel.fetchPhotos(nextPage: true);
      expect(photosViewModel.photos.length, greaterThan(initialPhotosCount));
    });
    test('Verify that when reset is true, the photos list is empty', () async {
      final future = photosViewModel.fetchPhotos(reset: true);
      expect(photosViewModel.photos, []);
      await future;
    });
  });

  test('fetchPhotos handles API error and retains current page', () async {
    when(() => fetchPhotosService.fetchPhotos(any())).thenAnswer(
      (invocation) async => FetchPhotosResponse(success: false),
    );
    final initialLength = photosViewModel.photos.length;
    await photosViewModel.fetchPhotos(reset: true);
    expect(photosViewModel.photos.length, initialLength);
  });
}
