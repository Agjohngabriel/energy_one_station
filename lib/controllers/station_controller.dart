import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/response/product_model.dart';
import '../model/response/review_model.dart';
import '../repo/station_repo.dart';
import '../services/api.dart';
import '../widget/snackbar.dart';

class StationController extends GetxController implements GetxService {
  // final StationRepo stationRepo;
  final StationRepo stationRepo = Get.put(StationRepo());
  // StationController({required this.stationRepo});

  List<Product>? _productList;
  List<ReviewModel>? _stationReviewList;
  List<ReviewModel>? _productReviewList;
  late bool _isLoading = false;
  late int _pageSize;
  late List<String> _offsetList = [];
  late int _offset = 1;
  XFile? _pickedLogo;
  late XFile _pickedCover;
  late bool _isAvailable = true;
  late String _weekendString;
  late bool _isGstEnabled;

  List<Product>? get productList => _productList;
  List<ReviewModel>? get stationReviewList => _stationReviewList;
  List<ReviewModel>? get productReviewList => _productReviewList;
  bool get isLoading => _isLoading;
  int get pageSize => _pageSize;
  int get offset => _offset;
  XFile? get pickedLogo => _pickedLogo;
  XFile get pickedCover => _pickedCover;
  bool get isAvailable => _isAvailable;
  String get weekendString => _weekendString;
  bool get isGstEnabled => _isGstEnabled;

  Future<void> getProductList(String offset) async {
    if (offset == '1') {
      _offsetList = [];
      _offset = 1;
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      Response response = await stationRepo.getProductList(offset);
      if (response.statusCode == 200) {
        if (offset == '1') {
          _productList = [];
        }
        _productList?.addAll(ProductModel.fromJson(response.body).products!);
        _pageSize = ProductModel.fromJson(response.body).totalSize!;
        _isLoading = false;
        update();
      } else {
        Api.checkApi(response);
      }
    } else {
      if (isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  void setOffset(int offset) {
    _offset = offset;
  }
  // Future<void> updateStation(Station station, String token) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await stationRepo.updateStation(
  //       station, _pickedLogo, _pickedCover, token);
  //   if (response.statusCode == 200) {
  //     Get.back();
  //     Get.find<AuthController>().getProfile();
  //     showCustomSnackBar('station_settings_updated_successfully'.tr,
  //         isError: false);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   _isLoading = false;
  //   update();
  // }

  void pickImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickedLogo;
      _pickedCover;
    } else {
      if (isLogo) {
        _pickedLogo =
            (await ImagePicker().pickImage(source: ImageSource.gallery))!;
      } else {
        _pickedCover =
            (await ImagePicker().pickImage(source: ImageSource.gallery))!;
      }
      update();
    }
  }

  Future<void> addProduct(
    Product product,
  ) async {
    _isLoading = true;
    update();
    Response response = await stationRepo.addProduct(product);
    if (response.statusCode == 200) {
      Get.back();
      showCustomSnackBar('Product added successfully', isError: false);
      getProductList('1');
    } else {
      Api.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  // Future<void> deleteProduct(int productID) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await stationRepo.deleteProduct(productID);
  //   if (response.statusCode == 200) {
  //     Get.back();
  //     showCustomSnackBar('product_deleted_successfully'.tr, isError: false);
  //     getProductList('1');
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   _isLoading = false;
  //   update();
  // }

  Future<void> getStationReviewList(int? stationID) async {
    // Response response =
    // await stationRepo.getStationReviewList(stationID);
    // if (response.statusCode == 200) {
    // _stationReviewList = [];
    // response.body.forEach(
    // (review) => _stationReviewList.add(ReviewModel.fromJson(review)));
    // } else {
    // ApiChecker.checkApi(response);
    // }
    // update();
  }

  // Future<void> getProductReviewList(int productID) async {
  //   _productReviewList = null;
  //   Response response = await stationRepo.getProductReviewList(productID);
  //   if (response.statusCode == 200) {
  //     _productReviewList = [];
  //     response.body.forEach(
  //         (review) => _productReviewList.add(ReviewModel.fromJson(review)));
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }

  void setAvailability(bool isAvailable) {
    _isAvailable = isAvailable;
  }

  // void toggleAvailable(int productID) async {
  //   Response response = await stationRepo.updateProductStatus(
  //       productID, _isAvailable ? 0 : 1);
  //   if (response.statusCode == 200) {
  //     getProductList('1');
  //     _isAvailable = !_isAvailable;
  //     showCustomSnackBar('food_status_updated_successfully'.tr, isError: false);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }

  void initStationData(String weekends, bool gstEnabled) {
    _pickedLogo;
    _pickedCover;
    _isGstEnabled = gstEnabled;
    _weekendString = weekends.trim();
  }

  void toggleGst() {
    _isGstEnabled = !_isGstEnabled;
    update();
  }

  void setWeekendString(String weekDay) {
    if (_weekendString.contains(weekDay)) {
      _weekendString = _weekendString.replaceFirst(weekDay, '');
    } else {
      _weekendString = _weekendString + weekDay;
    }
    update();
  }
}
