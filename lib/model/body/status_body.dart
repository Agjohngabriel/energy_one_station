class UpdateStatusBody {
  String? token;
  int? orderId;
  String? status;
  // String otp;
  String method = 'put';

  UpdateStatusBody({
    this.token,
    this.orderId,
    this.status,
    // this.otp
  });

  UpdateStatusBody.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    orderId = json['order_id'];
    status = json['status'];
    // otp = json['otp'];
    status = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['order_id'] = orderId;
    data['status'] = status;
    // data['otp'] = this.otp;
    data['_method'] = method;
    return data;
  }
}
