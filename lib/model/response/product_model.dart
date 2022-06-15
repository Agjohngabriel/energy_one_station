class ProductModel {
  int? _totalSize;
  String? _limit;
  String? _offset;
  List<Product>? _products;

  ProductModel(
      {required int totalSize,
      required String limit,
      required String offset,
      required List<Product> products}) {
    _totalSize = totalSize;
    _limit = limit;
    _offset = offset;
    _products = products;
  }

  int? get totalSize => _totalSize;
  String? get limit => _limit;
  String? get offset => _offset;
  List<Product>? get products => _products;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = _totalSize;
    data['limit'] = _limit;
    data['offset'] = _offset;
    if (_products != null) {
      data['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  late int id;
  late String name;
  late String description;
  late String image;
  int? categoryId;
  late double price;
  double? discount;
  String? discountType;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? setMenu;
  late int status;
  late int stationId;
  late String createdAt;
  late String updatedAt;
  late String stationName;
  late double stationDiscount;
  late String stationOpeningTime;
  late String stationClosingTime;
  bool? scheduleOrder;
  double? avgRating;
  int? ratingCount;

  Product(
      {id,
      name,
      description,
      image,
      categoryId,
      price,
      discount,
      discountType,
      availableTimeStarts,
      availableTimeEnds,
      setMenu,
      status,
      stationId,
      createdAt,
      updatedAt,
      stationName,
      stationDiscount,
      stationOpeningTime,
      stationClosingTime,
      scheduleOrder,
      avgRating,
      ratingCount});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'].toDouble();
    discount = json['discount'].toDouble();
    discountType = json['discount_type'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    setMenu = json['set_menu'];
    status = json['status'];
    stationId = json['station_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stationName = json['station_name'];
    stationDiscount = json['station_discount'].toDouble();
    stationOpeningTime = json['station_opening_time'];
    stationClosingTime = json['station_closing_time'];
    scheduleOrder = json['schedule_order'];
    avgRating = json['avg_rating'].toDouble();
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['available_time_starts'] = availableTimeStarts;
    data['available_time_ends'] = availableTimeEnds;
    data['set_menu'] = setMenu;
    data['status'] = status;
    data['station_id'] = stationId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['station_name'] = stationName;
    data['station_discount'] = stationDiscount;
    data['schedule_order'] = scheduleOrder;
    data['avg_rating'] = avgRating;
    data['rating_count'] = ratingCount;
    return data;
  }
}
