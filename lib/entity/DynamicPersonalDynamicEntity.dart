class DynamicPersonalDynamicEntityList {
  int _code;
  DynamicPersonalDynamicEntityData _data;
  String _message;

  DynamicPersonalDynamicEntityList(
      {int code, DynamicPersonalDynamicEntityData data, String message}) {
    this._code = code;
    this._data = data;
    this._message = message;
  }

  int get code => _code;
  set code(int code) => _code = code;
  DynamicPersonalDynamicEntityData get data => _data;
  set data(DynamicPersonalDynamicEntityData data) => _data = data;
  String get message => _message;
  set message(String message) => _message = message;

  DynamicPersonalDynamicEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _data = json['data'] != null
        ? new DynamicPersonalDynamicEntityData.fromJson(json['data'])
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

class DynamicPersonalDynamicEntityData {
  int _currentPage;
  int _nextPage;
  List<DynamicPersonalDynamicEntity> _result;
  int _totalPage;

  DynamicPersonalDynamicEntityData(
      {int currentPage,
      int nextPage,
      List<DynamicPersonalDynamicEntity> result,
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
  List<DynamicPersonalDynamicEntity> get result => _result;
  set result(List<DynamicPersonalDynamicEntity> result) => _result = result;
  int get totalPage => _totalPage;
  set totalPage(int totalPage) => _totalPage = totalPage;

  DynamicPersonalDynamicEntityData.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    _nextPage = json['next_page'];
    if (json['result'] != null) {
      _result = new List<DynamicPersonalDynamicEntity>();
      json['result'].forEach((v) {
        _result.add(new DynamicPersonalDynamicEntity.fromJson(v));
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

class DynamicPersonalDynamicEntity {
  int _dynamicCommentCount;
  int _dynamicId;
  String _dynamicImg;
  String _dynamicIntroduce;
  int _dynamicSatisfiedCount;
  int _dynamicShareCount;
  String _dynamicText;
  String _dynamicTime;
  int _dynamicTop;
  int _dynamicType;
  int _opusId;
  int _userId;
  DynamicPersonalDynamicEntityUserInfo _userInfo;

  DynamicPersonalDynamicEntity(
      {int dynamicCommentCount,
      int dynamicId,
      String dynamicImg,
      String dynamicIntroduce,
      int dynamicSatisfiedCount,
      int dynamicShareCount,
      String dynamicText,
      String dynamicTime,
      int dynamicTop,
      int dynamicType,
      int opusId,
      int userId,
      DynamicPersonalDynamicEntityUserInfo userInfo}) {
    this._dynamicCommentCount = dynamicCommentCount;
    this._dynamicId = dynamicId;
    this._dynamicImg = dynamicImg;
    this._dynamicIntroduce = dynamicIntroduce;
    this._dynamicSatisfiedCount = dynamicSatisfiedCount;
    this._dynamicShareCount = dynamicShareCount;
    this._dynamicText = dynamicText;
    this._dynamicTime = dynamicTime;
    this._dynamicTop = dynamicTop;
    this._dynamicType = dynamicType;
    this._opusId = opusId;
    this._userId = userId;
    this._userInfo = userInfo;
  }

  int get dynamicCommentCount => _dynamicCommentCount;
  set dynamicCommentCount(int dynamicCommentCount) =>
      _dynamicCommentCount = dynamicCommentCount;
  int get dynamicId => _dynamicId;
  set dynamicId(int dynamicId) => _dynamicId = dynamicId;
  String get dynamicImg => _dynamicImg;
  set dynamicImg(String dynamicImg) => _dynamicImg = dynamicImg;
  String get dynamicIntroduce => _dynamicIntroduce;
  set dynamicIntroduce(String dynamicIntroduce) =>
      _dynamicIntroduce = dynamicIntroduce;
  int get dynamicSatisfiedCount => _dynamicSatisfiedCount;
  set dynamicSatisfiedCount(int dynamicSatisfiedCount) =>
      _dynamicSatisfiedCount = dynamicSatisfiedCount;
  int get dynamicShareCount => _dynamicShareCount;
  set dynamicShareCount(int dynamicShareCount) =>
      _dynamicShareCount = dynamicShareCount;
  String get dynamicText => _dynamicText;
  set dynamicText(String dynamicText) => _dynamicText = dynamicText;
  String get dynamicTime => _dynamicTime;
  set dynamicTime(String dynamicTime) => _dynamicTime = dynamicTime;
  int get dynamicTop => _dynamicTop;
  set dynamicTop(int dynamicTop) => _dynamicTop = dynamicTop;
  int get dynamicType => _dynamicType;
  set dynamicType(int dynamicType) => _dynamicType = dynamicType;
  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  DynamicPersonalDynamicEntityUserInfo get userInfo => _userInfo;
  set userInfo(DynamicPersonalDynamicEntityUserInfo userInfo) =>
      _userInfo = userInfo;

  DynamicPersonalDynamicEntity.fromJson(Map<String, dynamic> json) {
    _dynamicCommentCount = json['dynamic_comment_count'];
    _dynamicId = json['dynamic_id'];
    _dynamicImg = json['dynamic_img'];
    _dynamicIntroduce = json['dynamic_introduce'];
    _dynamicSatisfiedCount = json['dynamic_satisfied_count'];
    _dynamicShareCount = json['dynamic_share_count'];
    _dynamicText = json['dynamic_text'];
    _dynamicTime = json['dynamic_time'];
    _dynamicTop = json['dynamic_top'];
    _dynamicType = json['dynamic_type'];
    _opusId = json['opus_id'];
    _userId = json['user_id'];
    _userInfo = json['user_info'] != null
        ? new DynamicPersonalDynamicEntityUserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dynamic_comment_count'] = this._dynamicCommentCount;
    data['dynamic_id'] = this._dynamicId;
    data['dynamic_img'] = this._dynamicImg;
    data['dynamic_introduce'] = this._dynamicIntroduce;
    data['dynamic_satisfied_count'] = this._dynamicSatisfiedCount;
    data['dynamic_share_count'] = this._dynamicShareCount;
    data['dynamic_text'] = this._dynamicText;
    data['dynamic_time'] = this._dynamicTime;
    data['dynamic_top'] = this._dynamicTop;
    data['dynamic_type'] = this._dynamicType;
    data['opus_id'] = this._opusId;
    data['user_id'] = this._userId;
    if (this._userInfo != null) {
      data['user_info'] = this._userInfo.toJson();
    }
    return data;
  }
}

class DynamicPersonalDynamicEntityUserInfo {
  String _userHeadImg;
  int _userId;
  String _userNickname;

  DynamicPersonalDynamicEntityUserInfo(
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

  DynamicPersonalDynamicEntityUserInfo.fromJson(Map<String, dynamic> json) {
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
