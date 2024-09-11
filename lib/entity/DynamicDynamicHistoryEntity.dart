class DynamicDynamicHistoryEntityList {
  int _code;
  DynamicDynamicHistoryEntityData _data;
  String _message;

  DynamicDynamicHistoryEntityList(
      {int code, DynamicDynamicHistoryEntityData data, String message}) {
    this._code = code;
    this._data = data;
    this._message = message;
  }

  int get code => _code;
  set code(int code) => _code = code;
  DynamicDynamicHistoryEntityData get data => _data;
  set data(DynamicDynamicHistoryEntityData data) => _data = data;
  String get message => _message;
  set message(String message) => _message = message;

  DynamicDynamicHistoryEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _data = json['data'] != null
        ? new DynamicDynamicHistoryEntityData.fromJson(json['data'])
        : null;
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    data['message'] = this._message;
    return data;
  }
}

class DynamicDynamicHistoryEntityData {
  int _currentPage;
  int _nextPage;
  List<DynamicDynamicHistoryEntity> _result;
  int _totalPage;

  DynamicDynamicHistoryEntityData(
      {int currentPage,
      int nextPage,
      List<DynamicDynamicHistoryEntity> result,
      int totalPage}) {
    this._currentPage = currentPage;
    this._nextPage = nextPage;
    this._result = result;
    this._totalPage = totalPage;
  }

  int get currentPage => _currentPage;
  set currentPage(int currentPage) => _currentPage = currentPage;
  int get nextPage => _nextPage;
  set nextPage(int nextPage) => _nextPage = nextPage;
  List<DynamicDynamicHistoryEntity> get result => _result;
  set result(List<DynamicDynamicHistoryEntity> result) => _result = result;
  int get totalPage => _totalPage;
  set totalPage(int totalPage) => _totalPage = totalPage;

  DynamicDynamicHistoryEntityData.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    _nextPage = json['next_page'];
    if (json['result'] != null) {
      _result = new List<DynamicDynamicHistoryEntity>();
      json['result'].forEach((v) {
        _result.add(new DynamicDynamicHistoryEntity.fromJson(v));
      });
    }
    _totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this._currentPage;
    data['next_page'] = this._nextPage;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    data['total_page'] = this._totalPage;
    return data;
  }
}

class DynamicDynamicHistoryEntity {
  String _userHeadImg;
  int _userId;
  String _userNickname;

  DynamicDynamicHistoryEntity(
      {String userHeadImg, int userId, String userNickname}) {
    this._userHeadImg = userHeadImg;
    this._userId = userId;
    this._userNickname = userNickname;
  }

  String get userHeadImg => _userHeadImg;
  set userHeadImg(String userHeadImg) => _userHeadImg = userHeadImg;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get userNickname => _userNickname;
  set userNickname(String userNickname) => _userNickname = userNickname;

  DynamicDynamicHistoryEntity.fromJson(Map<String, dynamic> json) {
    _userHeadImg = json['user_head_img'];
    _userId = json['user_id'];
    _userNickname = json['user_nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_head_img'] = this._userHeadImg;
    data['user_id'] = this._userId;
    data['user_nickname'] = this._userNickname;
    return data;
  }
}
