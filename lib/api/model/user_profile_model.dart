/// id : 1
/// first_name : "jyoti"
/// last_name : "patidar"
/// name : "jyoti patidar"
/// email : "jyoti@yopmail.com"
/// mobile_no : "5555555555"
/// dob : "2002-06-15 11:30:00"
/// gender : null
/// mobile_otp : null
/// email_verified_at : null
/// profile_photo_path : null
/// login_type : null
/// social_media_id : null
/// type : "2"
/// status : "2"
/// device_type : "1"
/// device_id : "ffa54ddafc3c77f7"
/// created_at : "2021-09-29T05:19:40.000000Z"
/// updated_at : "2021-11-02T15:28:13.000000Z"
/// image : null

class UserProfileModel {
  UserProfileModel({
      int? id, 
      String? firstName, 
      String? lastName, 
      String? name, 
      String? email, 
      String? mobileNo, 
      String? dob, 
      dynamic gender, 
      dynamic mobileOtp, 
      dynamic emailVerifiedAt, 
      dynamic profilePhotoPath, 
      dynamic loginType, 
      dynamic socialMediaId, 
      String? type, 
      String? status, 
      String? deviceType, 
      String? deviceId, 
      String? createdAt, 
      String? updatedAt, 
      dynamic image,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _name = name;
    _email = email;
    _mobileNo = mobileNo;
    _dob = dob;
    _gender = gender;
    _mobileOtp = mobileOtp;
    _emailVerifiedAt = emailVerifiedAt;
    _profilePhotoPath = profilePhotoPath;
    _loginType = loginType;
    _socialMediaId = socialMediaId;
    _type = type;
    _status = status;
    _deviceType = deviceType;
    _deviceId = deviceId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
}

  UserProfileModel.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _name = json['name'];
    _email = json['email'];
    _mobileNo = json['mobile_no'];
    _dob = json['dob'];
    _gender = json['gender'];
    _mobileOtp = json['mobile_otp'];
    _emailVerifiedAt = json['email_verified_at'];
    _profilePhotoPath = json['profile_photo_path'];
    _loginType = json['login_type'];
    _socialMediaId = json['social_media_id'];
    _type = json['type'];
    _status = json['status'];
    _deviceType = json['device_type'];
    _deviceId = json['device_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _image = json['image'];
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _name;
  String? _email;
  String? _mobileNo;
  String? _dob;
  dynamic _gender;
  dynamic _mobileOtp;
  dynamic _emailVerifiedAt;
  dynamic _profilePhotoPath;
  dynamic _loginType;
  dynamic _socialMediaId;
  String? _type;
  String? _status;
  String? _deviceType;
  String? _deviceId;
  String? _createdAt;
  String? _updatedAt;
  dynamic _image;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get name => _name;
  String? get email => _email;
  String? get mobileNo => _mobileNo;
  String? get dob => _dob;
  dynamic get gender => _gender;
  dynamic get mobileOtp => _mobileOtp;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  dynamic get profilePhotoPath => _profilePhotoPath;
  dynamic get loginType => _loginType;
  dynamic get socialMediaId => _socialMediaId;
  String? get type => _type;
  String? get status => _status;
  String? get deviceType => _deviceType;
  String? get deviceId => _deviceId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['name'] = _name;
    map['email'] = _email;
    map['mobile_no'] = _mobileNo;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['mobile_otp'] = _mobileOtp;
    map['email_verified_at'] = _emailVerifiedAt;
    map['profile_photo_path'] = _profilePhotoPath;
    map['login_type'] = _loginType;
    map['social_media_id'] = _socialMediaId;
    map['type'] = _type;
    map['status'] = _status;
    map['device_type'] = _deviceType;
    map['device_id'] = _deviceId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image'] = _image;
    return map;
  }

}