/// id : 28
/// first_name : "trttt"
/// last_name : "sdfdsf"
/// name : "trttt sdfdsf"
/// email : "jp464@gmail.com"
/// mobile_no : "4546546798"
/// dob : null
/// gender : "f"
/// mobile_otp : null
/// email_verified_at : null
/// profile_photo_path : null
/// login_type : null
/// social_media_id : null
/// type : "3"
/// status : "1"
/// device_type : "1"
/// device_id : "sfffffffffff"
/// created_at : "2021-11-01T16:57:04.000000Z"
/// updated_at : "2021-11-16T18:21:56.000000Z"
/// image : "http://fitness.kriyaninfotech.com/users/1637084057.png"
/// skills : "hjjjj"

class TrainerModel {
  TrainerModel({
      int? id, 
      String? firstName, 
      String? lastName, 
      String? name, 
      String? email, 
      String? mobileNo, 
      dynamic dob, 
      String? gender, 
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
      String? image, 
      String? skills,}){
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
    _skills = skills;
}

  TrainerModel.fromJson(dynamic json) {
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
    _skills = json['skills'];
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _name;
  String? _email;
  String? _mobileNo;
  dynamic _dob;
  String? _gender;
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
  String? _image;
  String? _skills;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get name => _name;
  String? get email => _email;
  String? get mobileNo => _mobileNo;
  dynamic get dob => _dob;
  String? get gender => _gender;
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
  String? get image => _image;
  String? get skills => _skills;

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
    map['skills'] = _skills;
    return map;
  }

}