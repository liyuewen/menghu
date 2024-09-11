class UserInfoPersonalEntityList {
  int _code;
  String _message;
  UserInfoPersonalEntityData _data;

  UserInfoPersonalEntityList(
      {int code, String message, UserInfoPersonalEntityData data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get message => _message;
  set message(String message) => _message = message;
  UserInfoPersonalEntityData get data => _data;
  set data(UserInfoPersonalEntityData data) => _data = data;

  UserInfoPersonalEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new UserInfoPersonalEntityData.fromJson(json['data'])
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

class UserInfoPersonalEntityData {
  int _fansNums;
  int _satisfiedNums;
  int _userId;
  String _userAutograph;
  String _userNickname;
  int _followNums;
  String _userHeadImg;

  UserInfoPersonalEntityData(
      {int fansNums,
      int satisfiedNums,
      int userId,
      String userAutograph,
      String userNickname,
      int followNums,
      String userHeadImg}) {
    this._fansNums = fansNums;
    this._satisfiedNums = satisfiedNums;
    this._userId = userId;
    this._userAutograph = userAutograph;
    this._userNickname = userNickname;
    this._followNums = followNums;
    this._userHeadImg = userHeadImg;
  }

  int get fansNums => _fansNums;
  set fansNums(int fansNums) => _fansNums = fansNums;
  int get satisfiedNums => _satisfiedNums;
  set satisfiedNums(int satisfiedNums) => _satisfiedNums = satisfiedNums;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get userAutograph => _userAutograph;
  set userAutograph(String userAutograph) => _userAutograph = userAutograph;
  String get userNickname => _userNickname;
  set userNickname(String userNickname) => _userNickname = userNickname;
  int get followNums => _followNums;
  set followNums(int followNums) => _followNums = followNums;
  String get userHeadImg => _userHeadImg;
  set userHeadImg(String userHeadImg) => _userHeadImg = userHeadImg;

  UserInfoPersonalEntityData.fromJson(Map<String, dynamic> json) {
    _fansNums = json['fans_nums'];
    _satisfiedNums = json['satisfied_nums'];
    _userId = json['user_id'];
    _userAutograph = json['user_autograph'];
    _userNickname = json['user_nickname'];
    _followNums = json['follow_nums'];
    _userHeadImg = json['user_head_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fans_nums'] = this._fansNums;
    data['satisfied_nums'] = this._satisfiedNums;
    data['user_id'] = this._userId;
    data['user_autograph'] = this._userAutograph;
    data['user_nickname'] = this._userNickname;
    data['follow_nums'] = this._followNums;
    data['user_head_img'] = this._userHeadImg;
    return data;
  }
}
