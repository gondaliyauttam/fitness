/// id : 1
/// title : "sre"
/// description : "fefrtg sfsdf"
/// url : "erer"
/// video : null
/// status : "1"
/// created_at : "2021-10-04T05:20:07.000000Z"
/// updated_at : "2021-10-05T05:09:40.000000Z"
/// image : null

class WodModel {
  WodModel({
      int? id, 
      String? title, 
      String? description, 
      String? url, 
      dynamic video, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      dynamic image,}){
    _id = id;
    _title = title;
    _description = description;
    _url = url;
    _video = video;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
}

  WodModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _url = json['url'];
    _video = json['video'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _image = json['image'];
  }
  int? _id;
  String? _title;
  String? _description;
  String? _url;
  dynamic _video;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _image;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get url => _url;
  dynamic get video => _video;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['url'] = _url;
    map['video'] = _video;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image'] = _image;
    return map;
  }

}