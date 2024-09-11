class EmptyEntityList {
  int _code;
  Null _data;
  String _message;

  EmptyEntityList({int code, Null data, String message}) {
    this._code = code;
    this._data = data;
    this._message = message;
  }

  int get code => _code;
  set code(int code) => _code = code;
  Null get data => _data;
  set data(Null data) => _data = data;
  String get message => _message;
  set message(String message) => _message = message;

  EmptyEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _data = json['data'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['data'] = this._data;
    data['message'] = this._message;
    return data;
  }
}
