import 'order_model.dart';

class ReviewModel {
  int? id;
  String? comment;
  int? rating;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  ReviewModel(
      {this.id,
      this.comment,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.customer});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['rating'] = rating;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (customer != null) {
      data['customer'] = customer?.toJson();
    }
    return data;
  }
}
