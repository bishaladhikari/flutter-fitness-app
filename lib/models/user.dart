class User {
  int id;
  String firstName;
  String lastName;
  String fullName;
  String userImage;
  Customer customer;

  User({this.id, this.firstName, this.lastName, this.fullName, this.customer,this.userImage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    userImage = json['user_image'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : Customer();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['user_image'] = this.userImage;
    data['customer'] = this.customer;
    return data;
  }
}

class Customer {
  bool status;
  bool verified;
  String referCode;
  String userId;
  String ip;
  String actor;
  String subject;
  String imageLink;
  String totalPoints;
  String totalReferrals;
  String totalReferralPoints;
  String totalOrderPoints;

  Customer(
      {this.status,
      this.verified,
      this.referCode,
      this.userId,
      this.ip,
      this.actor,
      this.subject,
      this.imageLink,
      this.totalPoints,
      this.totalReferrals,
      this.totalReferralPoints,
      this.totalOrderPoints});

  Customer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    verified = json['verified'];
    referCode = json['refer_code'];
    userId = json['user_id'].toString();
    ip = json['ip'];
    actor = json['actor'];
    subject = json['subject'];
    imageLink = json['image_link'];
    totalPoints = json['total_points'].toString();
    totalReferrals = json['total_referrals'].toString();
    totalReferralPoints = json['total_referral_points'].toString();
    totalOrderPoints = json['total_order_points'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['verified'] = this.verified;
    data['refer_code'] = this.referCode;
    data['user_id'] = this.userId;
    data['ip'] = this.ip;
    data['actor'] = this.actor;
    data['subject'] = this.subject;
    data['image_link'] = this.imageLink;
    data['total_points'] = this.totalPoints;
    data['total_referrals'] = this.totalReferrals;
    data['total_referral_points'] = this.totalReferralPoints;
    data['total_order_points'] = this.totalOrderPoints;
    return data;
  }
}
