import 'package:energyone_station/model/response/product_model.dart';

class OrderDetailsModel {
  late int id;
  late int productId;
  late int orderId;
  late double price;
  late Product productDetails;
  double? discountOnProduct;
  String? discountType;
  late int quantity;
  late String createdAt;
  late String updatedAt;

  OrderDetailsModel({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.price,
    required this.productDetails,
    this.discountOnProduct,
    this.discountType,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    price = json['price'].toDouble();
    productDetails = (json['product_details'] != null
        ? Product.fromJson(json['product_details'])
        : null)!;
    discountOnProduct = json['discount_on_product'].toDouble();
    discountType = json['discount_type'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['order_id'] = orderId;
    data['price'] = price;
    if (productDetails != null) {
      data['product_details'] = productDetails.toJson();
    }
    data['discount_on_product'] = discountOnProduct;
    data['discount_type'] = discountType;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
