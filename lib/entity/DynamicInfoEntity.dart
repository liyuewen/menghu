class DynamicInfoEntityList {
  int _code;
  String _message;
  DynamicInfoEntityData _data;

  DynamicInfoEntityList(
      {int code, String message, DynamicInfoEntityData data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get message => _message;
  set message(String message) => _message = message;
  DynamicInfoEntityData get data => _data;
  set data(DynamicInfoEntityData data) => _data = data;

  DynamicInfoEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new DynamicInfoEntityData.fromJson(json['data'])
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

class DynamicInfoEntityData {
  int _dynamicId;
  int _opusId;
  int _userId;
  String _dynamicIntroduce;
  int _dynamicTop;
  String _dynamicTime;
  int _dynamicShareCount;
  int _dynamicCommentCount;
  int _dynamicSatisfiedCount;
  String _dynamicText;
  int _dynamicType;
  Null _dynamicImg;
  DynamicInfoEntityUserInfo _userInfo;
  List<DynamicImgs> _dynamicImgs;

  DynamicInfoEntityData(
      {int dynamicId,
      int opusId,
      int userId,
      String dynamicIntroduce,
      int dynamicTop,
      String dynamicTime,
      int dynamicShareCount,
      int dynamicCommentCount,
      int dynamicSatisfiedCount,
      String dynamicText,
      int dynamicType,
      Null dynamicImg,
      DynamicInfoEntityUserInfo userInfo,
      List<DynamicImgs> dynamicImgs}) {
    this._dynamicId = dynamicId;
    this._opusId = opusId;
    this._userId = userId;
    this._dynamicIntroduce = dynamicIntroduce;
    this._dynamicTop = dynamicTop;
    this._dynamicTime = dynamicTime;
    this._dynamicShareCount = dynamicShareCount;
    this._dynamicCommentCount = dynamicCommentCount;
    this._dynamicSatisfiedCount = dynamicSatisfiedCount;
    this._dynamicText = dynamicText;
    this._dynamicType = dynamicType;
    this._dynamicImg = dynamicImg;
    this._userInfo = userInfo;
    this._dynamicImgs = dynamicImgs;
  }

  int get dynamicId => _dynamicId;
  set dynamicId(int dynamicId) => _dynamicId = dynamicId;
  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get dynamicIntroduce => _dynamicIntroduce;
  set dynamicIntroduce(String dynamicIntroduce) =>
      _dynamicIntroduce = dynamicIntroduce;
  int get dynamicTop => _dynamicTop;
  set dynamicTop(int dynamicTop) => _dynamicTop = dynamicTop;
  String get dynamicTime => _dynamicTime;
  set dynamicTime(String dynamicTime) => _dynamicTime = dynamicTime;
  int get dynamicShareCount => _dynamicShareCount;
  set dynamicShareCount(int dynamicShareCount) =>
      _dynamicShareCount = dynamicShareCount;
  int get dynamicCommentCount => _dynamicCommentCount;
  set dynamicCommentCount(int dynamicCommentCount) =>
      _dynamicCommentCount = dynamicCommentCount;
  int get dynamicSatisfiedCount => _dynamicSatisfiedCount;
  set dynamicSatisfiedCount(int dynamicSatisfiedCount) =>
      _dynamicSatisfiedCount = dynamicSatisfiedCount;
  String get dynamicText => _dynamicText;
  set dynamicText(String dynamicText) => _dynamicText = dynamicText;
  int get dynamicType => _dynamicType;
  set dynamicType(int dynamicType) => _dynamicType = dynamicType;
  Null get dynamicImg => _dynamicImg;
  set dynamicImg(Null dynamicImg) => _dynamicImg = dynamicImg;
  DynamicInfoEntityUserInfo get userInfo => _userInfo;
  set userInfo(DynamicInfoEntityUserInfo userInfo) => _userInfo = userInfo;
  List<DynamicImgs> get dynamicImgs => _dynamicImgs;
  set dynamicImgs(List<DynamicImgs> dynamicImgs) => _dynamicImgs = dynamicImgs;

  DynamicInfoEntityData.fromJson(Map<String, dynamic> json) {
    _dynamicId = json['dynamic_id'];
    _opusId = json['opus_id'];
    _userId = json['user_id'];
    _dynamicIntroduce = json['dynamic_introduce'];
    _dynamicTop = json['dynamic_top'];
    _dynamicTime = json['dynamic_time'];
    _dynamicShareCount = json['dynamic_share_count'];
    _dynamicCommentCount = json['dynamic_comment_count'];
    _dynamicSatisfiedCount = json['dynamic_satisfied_count'];
    _dynamicText = json['dynamic_text'];
    _dynamicType = json['dynamic_type'];
    _dynamicImg = json['dynamic_img'];
    _userInfo = json['user_info'] != null
        ? new DynamicInfoEntityUserInfo.fromJson(json['user_info'])
        : null;
    if (json['dynamic_imgs'] != null) {
      _dynamicImgs = new List<DynamicImgs>();
      json['dynamic_imgs'].forEach((v) {
        _dynamicImgs.add(new DynamicImgs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dynamic_id'] = this._dynamicId;
    data['opus_id'] = this._opusId;
    data['user_id'] = this._userId;
    data['dynamic_introduce'] = this._dynamicIntroduce;
    data['dynamic_top'] = this._dynamicTop;
    data['dynamic_time'] = this._dynamicTime;
    data['dynamic_share_count'] = this._dynamicShareCount;
    data['dynamic_comment_count'] = this._dynamicCommentCount;
    data['dynamic_satisfied_count'] = this._dynamicSatisfiedCount;
    data['dynamic_text'] = this._dynamicText;
    data['dynamic_type'] = this._dynamicType;
    data['dynamic_img'] = this._dynamicImg;
    if (this._userInfo != null) {
      data['user_info'] = this._userInfo.toJson();
    }
    if (this._dynamicImgs != null) {
      data['dynamic_imgs'] = this._dynamicImgs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DynamicInfoEntityUserInfo {
  int _userId;
  String _userHeadImg;
  String _userNickname;

  DynamicInfoEntityUserInfo(
      {int userId, String userHeadImg, String userNickname}) {
    this._userId = userId;
    this._userHeadImg = userHeadImg;
    this._userNickname = userNickname;
  }

  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get userHeadImg => _userHeadImg;
  set userHeadImg(String userHeadImg) => _userHeadImg = userHeadImg;
  String get userNickname => _userNickname;
  set userNickname(String userNickname) => _userNickname = userNickname;

  DynamicInfoEntityUserInfo.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _userHeadImg = json['user_head_img'];
    _userNickname = json['user_nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['user_head_img'] = this._userHeadImg;
    data['user_nickname'] = this._userNickname;
    return data;
  }
}

class DynamicImgs {
  int _imgId;
  String _imgUrl;
  int _opusId;
  int _userId;
  int _dynamicId;

  DynamicImgs(
      {int imgId, String imgUrl, int opusId, int userId, int dynamicId}) {
    this._imgId = imgId;
    this._imgUrl = imgUrl;
    this._opusId = opusId;
    this._userId = userId;
    this._dynamicId = dynamicId;
  }

  int get imgId => _imgId;
  set imgId(int imgId) => _imgId = imgId;
  String get imgUrl => _imgUrl;
  set imgUrl(String imgUrl) => _imgUrl = imgUrl;
  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  int get dynamicId => _dynamicId;
  set dynamicId(int dynamicId) => _dynamicId = dynamicId;

  DynamicImgs.fromJson(Map<String, dynamic> json) {
    _imgId = json['img_id'];
    _imgUrl = json['img_url'];
    _opusId = json['opus_id'];
    _userId = json['user_id'];
    _dynamicId = json['dynamic_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_id'] = this._imgId;
    data['img_url'] = this._imgUrl;
    data['opus_id'] = this._opusId;
    data['user_id'] = this._userId;
    data['dynamic_id'] = this._dynamicId;
    return data;
  }
}
