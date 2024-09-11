class ToolUploadFileEntityList {
  int _code;
  String _message;
  ToolUploadFileEntityData _data;

  ToolUploadFileEntityList(
      {int code, String message, ToolUploadFileEntityData data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get message => _message;
  set message(String message) => _message = message;
  ToolUploadFileEntityData get data => _data;
  set data(ToolUploadFileEntityData data) => _data = data;

  ToolUploadFileEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new ToolUploadFileEntityData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class ToolUploadFileEntityData {
  String _imgUrl;

  ToolUploadFileEntityData({String imgUrl}) {
    this._imgUrl = imgUrl;
  }

  String get imgUrl => _imgUrl;
  set imgUrl(String imgUrl) => _imgUrl = imgUrl;

  ToolUploadFileEntityData.fromJson(Map<String, dynamic> json) {
    _imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_url'] = this._imgUrl;
    return data;
  }
}
