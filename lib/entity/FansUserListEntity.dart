class FansUserListEntityList {
  int _code;
  String _message;
  FansUserListEntityData _data;

  FansUserListEntityList(
      {int code, String message, FansUserListEntityData data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get message => _message;
  set message(String message) => _message = message;
  FansUserListEntityData get data => _data;
  set data(FansUserListEntityData data) => _data = data;

  FansUserListEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new FansUserListEntityData.fromJson(json['data'])
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

class FansUserListEntityData {
  int _nextPage;
  List<FansUserListEntityResult> _result;
  int _totalPage;
  int _currentPage;

  FansUserListEntityData(
      {int nextPage,
      List<FansUserListEntityResult> result,
      int totalPage,
      int currentPage}) {
    this._nextPage = nextPage;
    this._result = result;
    this._totalPage = totalPage;
    this._currentPage = currentPage;
  }

  int get nextPage => _nextPage;
  set nextPage(int nextPage) => _nextPage = nextPage;
  List<FansUserListEntityResult> get result => _result;
  set result(List<FansUserListEntityResult> result) => _result = result;
  int get totalPage => _totalPage;
  set totalPage(int totalPage) => _totalPage = totalPage;
  int get currentPage => _currentPage;
  set currentPage(int currentPage) => _currentPage = currentPage;

  FansUserListEntityData.fromJson(Map<String, dynamic> json) {
    _nextPage = json['next_page'];
    if (json['result'] != null) {
      _result = new List<FansUserListEntityResult>();
      json['result'].forEach((v) {
        _result.add(new FansUserListEntityResult.fromJson(v));
      });
    }
    _totalPage = json['total_page'];
    _currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page'] = this._nextPage;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    data['total_page'] = this._totalPage;
    data['current_page'] = this._currentPage;
    return data;
  }
}

class FansUserListEntityResult {
  int _userId;
  String _userPhone;
  String _userRealName;
  String _userIdCard;
  String _userEmail;
  String _userBankCard;
  String _userSex;
  String _userWork;
  String _userHeadImg;
  String _userNickname;
  String _userUid;
  String _userRegTime;
  String _userBirthday;
  String _userConstellation;
  String _userAutograph;
  bool _haveFollow;

  FansUserListEntityResult(
      {int userId,
      String userPhone,
      String userRealName,
      String userIdCard,
      String userEmail,
      String userBankCard,
      String userSex,
      String userWork,
      String userHeadImg,
      String userNickname,
      String userUid,
      String userRegTime,
      String userBirthday,
      String userConstellation,
      String userAutograph,
      bool haveFollow}) {
    this._userId = userId;
    this._userPhone = userPhone;
    this._userRealName = userRealName;
    this._userIdCard = userIdCard;
    this._userEmail = userEmail;
    this._userBankCard = userBankCard;
    this._userSex = userSex;
    this._userWork = userWork;
    this._userHeadImg = userHeadImg;
    this._userNickname = userNickname;
    this._userUid = userUid;
    this._userRegTime = userRegTime;
    this._userBirthday = userBirthday;
    this._userConstellation = userConstellation;
    this._userAutograph = userAutograph;
    this._haveFollow = haveFollow;
  }

  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get userPhone => _userPhone;
  set userPhone(String userPhone) => _userPhone = userPhone;
  String get userRealName => _userRealName;
  set userRealName(String userRealName) => _userRealName = userRealName;
  String get userIdCard => _userIdCard;
  set userIdCard(String userIdCard) => _userIdCard = userIdCard;
  String get userEmail => _userEmail;
  set userEmail(String userEmail) => _userEmail = userEmail;
  String get userBankCard => _userBankCard;
  set userBankCard(String userBankCard) => _userBankCard = userBankCard;
  String get userSex => _userSex;
  set userSex(String userSex) => _userSex = userSex;
  String get userWork => _userWork;
  set userWork(String userWork) => _userWork = userWork;
  String get userHeadImg => _userHeadImg;
  set userHeadImg(String userHeadImg) => _userHeadImg = userHeadImg;
  String get userNickname => _userNickname;
  set userNickname(String userNickname) => _userNickname = userNickname;
  String get userUid => _userUid;
  set userUid(String userUid) => _userUid = userUid;
  String get userRegTime => _userRegTime;
  set userRegTime(String userRegTime) => _userRegTime = userRegTime;
  String get userBirthday => _userBirthday;
  set userBirthday(String userBirthday) => _userBirthday = userBirthday;
  String get userConstellation => _userConstellation;
  set userConstellation(String userConstellation) =>
      _userConstellation = userConstellation;
  String get userAutograph => _userAutograph;
  set userAutograph(String userAutograph) => _userAutograph = userAutograph;
  bool get haveFollow => _haveFollow;
  set haveFollow(bool haveFollow) => _haveFollow = haveFollow;

  FansUserListEntityResult.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _userPhone = json['user_phone'];
    _userRealName = json['user_real_name'];
    _userIdCard = json['user_id_card'];
    _userEmail = json['user_email'];
    _userBankCard = json['user_bank_card'];
    _userSex = json['user_sex'];
    _userWork = json['user_work'];
    _userHeadImg = json['user_head_img'];
    _userNickname = json['user_nickname'];
    _userUid = json['user_uid'];
    _userRegTime = json['user_reg_time'];
    _userBirthday = json['user_birthday'];
    _userConstellation = json['user_constellation'];
    _userAutograph = json['user_autograph'];
    _haveFollow = json['have_follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['user_phone'] = this._userPhone;
    data['user_real_name'] = this._userRealName;
    data['user_id_card'] = this._userIdCard;
    data['user_email'] = this._userEmail;
    data['user_bank_card'] = this._userBankCard;
    data['user_sex'] = this._userSex;
    data['user_work'] = this._userWork;
    data['user_head_img'] = this._userHeadImg;
    data['user_nickname'] = this._userNickname;
    data['user_uid'] = this._userUid;
    data['user_reg_time'] = this._userRegTime;
    data['user_birthday'] = this._userBirthday;
    data['user_constellation'] = this._userConstellation;
    data['user_autograph'] = this._userAutograph;
    data['have_follow'] = this._haveFollow;
    return data;
  }
}
