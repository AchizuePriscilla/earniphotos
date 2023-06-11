import 'package:earnipay_assessment/models/photo_model.dart';
import 'package:earnipay_assessment/presentation/viewmodels/base_view_model.dart';
import 'package:flutter/material.dart';

class PhotosViewModel extends BaseViewModel {
  List<PhotoModel> _photos = [];
  List<PhotoModel> get photos => _photos;
  bool _fetchingPhotos = false;
  bool get fetchingPhotos => _fetchingPhotos;
  bool _refreshingPhotos = false;
  bool get refreshingPhotos => _refreshingPhotos;
  bool _pageLoading = false;
  bool get pageLoading => _pageLoading;

  void setFetchingPhotos(bool val) {
    if (_fetchingPhotos != val) {
      _fetchingPhotos = val;
    }
    notifyListeners();
  }

  void setPhotosRefreshingStatus(bool val) {
    if (refreshingPhotos != val) {
      _refreshingPhotos = val;
    }
    notifyListeners();
  }

  void togglePageLoading(bool val) {
    if (_pageLoading != val) {
      _pageLoading = val;
    }
    notifyListeners();
  }

  int _currentPage = 1;

  Future<void> fetchPhotos({
    bool nextPage = false,
    bool refresh = false,
    bool reset = false,
    ScrollController? controller,
  }) async {
    try {
      if (_fetchingPhotos || _refreshingPhotos) return;
      if (reset || refresh) {
        togglePageLoading(true);
      }

      setFetchingPhotos(true);
      setPhotosRefreshingStatus(true);
      if (reset) {
        _currentPage = 1;
        _photos = [];
      }
      if (refresh) {
        _currentPage = 1;
      }

      if (nextPage) _currentPage += 1;
      var res = await fetchPhotosService.fetchPhotos(_currentPage);

      //If the API call is not successful:
      if (!res.success) {
        _currentPage <= 1 ? _currentPage = 1 : _currentPage -= 1;
        return;
      }
      final fetchedPhotos = res.photos!;
      if (reset) {
        _photos = fetchedPhotos;
        togglePageLoading(false);
        setFetchingPhotos(false);
        setPhotosRefreshingStatus(false);
        return;
      }
      if (fetchedPhotos.isEmpty) {
        //if no photo is returned, then we've hit the end of the
        //pagination support, decrease [_currentPage]
        _currentPage -= 1;
        if (_currentPage <= 0) _currentPage = 1;
      } else {
        //otherwise, add fetched photos to the end of the list
        _photos += fetchedPhotos;
      }
      notifyListeners();
      //Improve user experience by scrolling up a bit after new photos have been loaded
      //and added to the end of the list
      if (controller != null) {
        controller.animateTo(controller.offset + 200,
            curve: Curves.easeIn, duration: const Duration(milliseconds: 200));
      }
    } catch (e) {
      togglePageLoading(false);
      setPhotosRefreshingStatus(false);
      setFetchingPhotos(false);
      rethrow;
    }

    togglePageLoading(false);
    setPhotosRefreshingStatus(false);
    setFetchingPhotos(false);
  }
}
