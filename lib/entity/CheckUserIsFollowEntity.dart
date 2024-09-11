class CheckUserIsFollowEntityList {
  int _code;
  String _message;
  bool _data;

  CheckUserIsFollowEntityList({int code, String message, bool data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get message => _message;
  set message(String message) => _message = message;
  bool get data => _data;
  set data(bool data) => _data = data;

  CheckUserIsFollowEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['message'] = this._message;
    data['data'] = this._data;
    return data;
  }
}
