class LoginResponseModel {
  String? token;
  String? zone_wise_topic;

  LoginResponseModel({required this.token, required this.zone_wise_topic});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    zone_wise_topic = json['zone_wise_topic'];
  }
}
