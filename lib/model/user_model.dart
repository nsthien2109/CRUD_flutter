class UserModel {
  int? userID;
  String? userName;
  String? userPhone;

  UserModel({this.userID, this.userName, this.userPhone});

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['id'];
    userName = json['userName'];
    userPhone = json['userPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.userID;
    data['userName'] = this.userName;
    data['userPhone'] = this.userPhone;
    return data;
  }
}