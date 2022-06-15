class ProfileModel {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? orderCount;
  int? todaysOrderCount;
  int? thisWeekOrderCount;
  int? thisMonthOrderCount;
  int? memberSinceDays;
  double? balance;
  double? totalEarning;
  double? todaysEarning;
  double? thisWeekEarning;
  double? thisMonthEarning;
  Station? station;

  ProfileModel(
      {this.id,
      this.fName,
      this.lName,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.orderCount,
      this.todaysOrderCount,
      this.thisWeekOrderCount,
      this.thisMonthOrderCount,
      this.memberSinceDays,
      this.balance,
      this.totalEarning,
      this.todaysEarning,
      this.thisWeekEarning,
      this.thisMonthEarning,
      this.station});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderCount = json['order_count'];
    todaysOrderCount = json['todays_order_count'];
    thisWeekOrderCount = json['this_week_order_count'];
    thisMonthOrderCount = json['this_month_order_count'];
    memberSinceDays = json['member_since_days'];
    balance = json['balance'].toDouble();
    totalEarning = json['total_earning'].toDouble();
    todaysEarning = json['todays_earning'].toDouble();
    thisWeekEarning = json['this_week_earning'].toDouble();
    thisMonthEarning = json['this_month_earning'].toDouble();
    station = Station.fromJson(json['station']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['order_count'] = orderCount;
    data['todays_order_count'] = todaysOrderCount;
    data['this_week_order_count'] = thisWeekOrderCount;
    data['this_month_order_count'] = thisMonthOrderCount;
    data['member_since_days'] = memberSinceDays;
    data['balance'] = balance;
    data['total_earning'] = totalEarning;
    data['todays_earning'] = todaysEarning;
    data['this_week_earning'] = thisWeekEarning;
    data['this_month_earning'] = thisMonthEarning;
    data['station'] = station;
    return data;
  }
}

class Station {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? logo;
  String? latitude;
  String? longitude;
  String? address;
  double? minimumOrder;
  String? createdAt;
  String? updatedAt;
  String? coverPhoto;
  bool? reviewsSection;
  String? availableTimeStarts;
  String? availableTimeEnds;
  double? avgRating;
  int? ratingCount;
  late bool active;
  bool? gstStatus;
  String? gstCode;
  String? offDay;
  Station({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.logo,
    this.latitude,
    this.longitude,
    this.address,
    this.minimumOrder,
    this.createdAt,
    this.updatedAt,
    this.coverPhoto,
    this.reviewsSection,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.avgRating,
    this.ratingCount,
    required this.active,
    this.gstStatus,
    this.gstCode,
    this.offDay,
  });

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    logo = json['logo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    minimumOrder = json['minimum_order'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    coverPhoto = json['cover_photo'];
    reviewsSection = json['reviews_section'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    avgRating = json['avg_rating'].toDouble();
    ratingCount = json['rating_count '];
    active = json['active'];
    gstStatus = json['gst_status'];
    gstCode = json['gst_code'];
    offDay = json['off_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['logo'] = logo;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['minimum_order'] = minimumOrder;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cover_photo'] = coverPhoto;
    data['reviews_section'] = reviewsSection;
    data['available_time_starts'] = availableTimeStarts;
    data['available_time_ends'] = availableTimeEnds;
    data['avg_rating'] = avgRating;
    data['rating_count '] = ratingCount;
    data['active'] = active;
    data['gst_status'] = gstStatus;
    data['gst_code'] = gstCode;
    data['off_day'] = offDay;
    return data;
  }
}
