import 'dart:convert';

class OrderModel {
  late int id;
  double? orderAmount;
  String? orderStatus;
  String? paymentMethod;
  String? orderNote;
  String? createdAt;
  String? updatedAt;
  String? scheduleAt;
  String? otp;
  String? pending;
  String? accepted;
  String? confirmed;
  String? handover;
  String? pickedUp;
  String? delivered;
  String? canceled;
  String? refundRequested;
  String? refunded;
  late DeliveryAddress deliveryAddress;
  int? scheduled;
  String? stationName;
  String? stationAddress;
  String? stationPhone;
  String? stationLat;
  String? stationLng;
  String? stationLogo;
  int? detailsCount;
  Customer? customer;

  OrderModel(
      {required id,
      orderAmount,
      orderStatus,
      paymentMethod,
      orderNote,
      createdAt,
      updatedAt,
      deliveryCharge,
      scheduleAt,
      otp,
      pending,
      accepted,
      confirmed,
      handover,
      pickedUp,
      delivered,
      canceled,
      refundRequested,
      refunded,
      deliveryAddress,
      scheduled,
      stationName,
      stationAddress,
      stationPhone,
      stationLat,
      stationLng,
      stationLogo,
      detailsCount,
      customer});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderAmount = json['order_amount'].toDouble();
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    orderNote = json['order_note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    scheduleAt = json['schedule_at'];
    otp = json['otp'];
    pending = json['pending'];
    accepted = json['accepted'];
    confirmed = json['confirmed'];
    handover = json['handover'];
    pickedUp = json['picked_up'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    refundRequested = json['refund_requested'];
    refunded = json['refunded'];
    deliveryAddress = (json['delivery_address'] != null
        ? DeliveryAddress.fromJson(jsonDecode(json['delivery_address']))
        : null)!;
    scheduled = json['scheduled'];
    stationName = json['station_name'];
    stationAddress = json['station_address'];
    stationPhone = json['station_phone'];
    stationLat = json['station_lat'];
    stationLng = json['station_lng'];
    stationLogo = json['station_logo'];
    detailsCount = json['details_count'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_amount'] = orderAmount;
    data['order_status'] = orderStatus;
    data['payment_method'] = paymentMethod;
    data['order_note'] = orderNote;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['schedule_at'] = scheduleAt;
    data['otp'] = otp;
    data['pending'] = pending;
    data['accepted'] = accepted;
    data['confirmed'] = confirmed;
    data['handover'] = handover;
    data['picked_up'] = pickedUp;
    data['delivered'] = delivered;
    data['canceled'] = canceled;
    data['refund_requested'] = refundRequested;
    data['refunded'] = refunded;
    if (deliveryAddress != null) {
      data['delivery_address'] = deliveryAddress.toJson();
    }
    data['scheduled'] = scheduled;
    data['station_name'] = stationName;
    data['station_address'] = stationAddress;
    data['station_phone'] = stationPhone;
    data['station_lat'] = stationLat;
    data['station_lng'] = stationLng;
    data['station_logo'] = stationLogo;
    data['details_count'] = detailsCount;
    if (customer != null) {
      data['customer'] = customer?.toJson();
    }
    return data;
  }
}

class DeliveryAddress {
  late String contactPersonName;
  late String contactPersonNumber;
  late String addressType;
  late String address;
  late String longitude;
  late String latitude;

  DeliveryAddress(
      {required contactPersonName,
      required contactPersonNumber,
      required addressType,
      required address,
      required longitude,
      required latitude});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    addressType = json['address_type'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact_person_name'] = contactPersonName;
    data['contact_person_number'] = contactPersonNumber;
    data['address_type'] = addressType;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}

class Customer {
  late int id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  String? createdAt;
  String? updatedAt;

  Customer({id, fName, lName, phone, email, image, createdAt, updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['firstname'];
    lName = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = fName;
    data['lastname'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
