class LoginList {
  int _code;
  LoginData _data;
  String _message;

  LoginList({int code, LoginData data, String message}) {
    this._code = code;
    this._data = data;
    this._message = message;
  }

  int get code => _code;
  set code(int code) => _code = code;
  LoginData get data => _data;
  set data(LoginData data) => _data = data;
  String get message => _message;
  set message(String message) => _message = message;

  LoginList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
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

class LoginData {
  UserInfo _userInfo;
  String _userToken;

  LoginData({UserInfo userInfo, String userToken}) {
    this._userInfo = userInfo;
    this._userToken = userToken;
  }

  UserInfo get userInfo => _userInfo;
  set userInfo(UserInfo userInfo) => _userInfo = userInfo;
  String get userToken => _userToken;
  set userToken(String userToken) => _userToken = userToken;

  LoginData.fromJson(Map<String, dynamic> json) {
    _userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    _userToken = json['user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._userInfo != null) {
      data['user_info'] = this._userInfo.toJson();
    }
    data['user_token'] = this._userToken;
    return data;
  }
}

class UserInfo {
  String _userAutograph;
  String _userBankCard;
  String _userBirthday;
  String _userConstellation;
  String _userEmail;
  String _userHeadImg;
  int _userId;
  String _userIdCard;
  String _userNickname;
  String _userPhone;
  String _userRealName;
  String _userRegTime;
  String _userSex;
  String _userUid;
  String _userWork;

  UserInfo(
      {String userAutograph,
      String userBankCard,
      String userBirthday,
      String userConstellation,
      String userEmail,
      String userHeadImg,
      int userId,
      String userIdCard,
      String userNickname,
      String userPhone,
      String userRealName,
      String userRegTime,
      String userSex,
      String userUid,
      String userWork}) {
    this._userAutograph = userAutograph;
    this._userBankCard = userBankCard;
    this._userBirthday = userBirthday;
    this._userConstellation = userConstellation;
    this._userEmail = userEmail;
    this._userHeadImg = userHeadImg;
    this._userId = userId;
    this._userIdCard = userIdCard;
    this._userNickname = userNickname;
    this._userPhone = userPhone;
    this._userRealName = userRealName;
    this._userRegTime = userRegTime;
    this._userSex = userSex;
    this._userUid = userUid;
    this._userWork = userWork;
  }

  String get userAutograph => _userAutograph;
  set userAutograph(String userAutograph) => _userAutograph = userAutograph;
  String get userBankCard => _userBankCard;
  set userBankCard(String userBankCard) => _userBankCard = userBankCard;
  String get userBirthday => _userBirthday;
  set userBirthday(String userBirthday) => _userBirthday = userBirthday;
  String get userConstellation => _userConstellation;
  set userConstellation(String userConstellation) =>
      _userConstellation = userConstellation;
  String get userEmail => _userEmail;
  set userEmail(String userEmail) => _userEmail = userEmail;
  String get userHeadImg => _userHeadImg;
  set userHeadImg(String userHeadImg) => _userHeadImg = userHeadImg;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get userIdCard => _userIdCard;
  set userIdCard(String userIdCard) => _userIdCard = userIdCard;
  String get userNickname => _userNickname;
  set userNickname(String userNickname) => _userNickname = userNickname;
  String get userPhone => _userPhone;
  set userPhone(String userPhone) => _userPhone = userPhone;
  String get userRealName => _userRealName;
  set userRealName(String userRealName) => _userRealName = userRealName;
  String get userRegTime => _userRegTime;
  set userRegTime(String userRegTime) => _userRegTime = userRegTime;
  String get userSex => _userSex;
  set userSex(String userSex) => _userSex = userSex;
  String get userUid => _userUid;
  set userUid(String userUid) => _userUid = userUid;
  String get userWork => _userWork;
  set userWork(String userWork) => _userWork = userWork;

  UserInfo.fromJson(Map<String, dynamic> json) {
    _userAutograph = json['user_autograph'];
    _userBankCard = json['user_bank_card'];
    _userBirthday = json['user_birthday'];
    _userConstellation = json['user_constellation'];
    _userEmail = json['user_email'];
    _userHeadImg = json['user_head_img'];
    _userId = json['user_id'];
    _userIdCard = json['user_id_card'];
    _userNickname = json['user_nickname'];
    _userPhone = json['user_phone'];
    _userRealName = json['user_real_name'];
    _userRegTime = json['user_reg_time'];
    _userSex = json['user_sex'];
    _userUid = json['user_uid'];
    _userWork = json['user_work'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_autograph'] = this._userAutograph;
    data['user_bank_card'] = this._userBankCard;
    data['user_birthday'] = this._userBirthday;
    data['user_constellation'] = this._userConstellation;
    data['user_email'] = this._userEmail;
    data['user_head_img'] = this._userHeadImg;
    data['user_id'] = this._userId;
    data['user_id_card'] = this._userIdCard;
    data['user_nickname'] = this._userNickname;
    data['user_phone'] = this._userPhone;
    data['user_real_name'] = this._userRealName;
    data['user_reg_time'] = this._userRegTime;
    data['user_sex'] = this._userSex;
    data['user_uid'] = this._userUid;
    data['user_work'] = this._userWork;
    return data;
  }
}
