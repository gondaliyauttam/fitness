/// id : 16
/// parent_id : null
/// name : "Upper Body"
/// slug : "Upper Body"
/// type : "2"
/// created_at : "2021-11-15T18:26:39.000000Z"
/// updated_at : "2021-11-15T18:32:00.000000Z"
/// image : "http://fitness.kriyaninfotech.com/public/category/1637001120.jpg"
/// video : null
/// username : "jyoti patidar"

class CategoriesModel {
  CategoriesModel({
      int? id,
      dynamic parentId,
      String? name,
      String? slug,
      String? type,
      String? createdAt,
      String? updatedAt,
      String? image,
      dynamic video,
      String? username,}){
    _id = id;
    _parentId = parentId;
    _name = name;
    _slug = slug;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
    _video = video;
    _username = username;
}

  CategoriesModel.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _slug = json['slug'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _image = json['image'];
    _video = json['video'];
    _username = json['username'];
  }
  int? _id;
  dynamic _parentId;
  String? _name;
  String? _slug;
  String? _type;
  String? _createdAt;
  String? _updatedAt;
  String? _image;
  dynamic _video;
  String? _username;

  int? get id => _id;
  dynamic get parentId => _parentId;
  String? get name => _name;
  String? get slug => _slug;
  String? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get image => _image;
  dynamic get video => _video;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['name'] = _name;
    map['slug'] = _slug;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image'] = _image;
    map['video'] = _video;
    map['username'] = _username;
    return map;
  }

}