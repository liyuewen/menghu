class OpusRankingEntityList {
  int _code;
  String _message;
  OpusRankingEntityData _data;

  OpusRankingEntityList({int code, Null message, OpusRankingEntityData data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  Null get message => _message;
  set message(Null message) => _message = message;
  OpusRankingEntityData get data => _data;
  set data(OpusRankingEntityData data) => _data = data;

  OpusRankingEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new OpusRankingEntityData.fromJson(json['data'])
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

class OpusRankingEntityData {
  int _nextPage;
  List<OpusRankingEntity> _result;
  int _totalPage;
  int _currentPage;

  OpusRankingEntityData(
      {int nextPage,
      List<OpusRankingEntity> result,
      int totalPage,
      int currentPage}) {
    this._nextPage = nextPage;
    this._result = result;
    this._totalPage = totalPage;
    this._currentPage = currentPage;
  }

  int get nextPage => _nextPage;
  set nextPage(int nextPage) => _nextPage = nextPage;
  List<OpusRankingEntity> get result => _result;
  set result(List<OpusRankingEntity> result) => _result = result;
  int get totalPage => _totalPage;
  set totalPage(int totalPage) => _totalPage = totalPage;
  int get currentPage => _currentPage;
  set currentPage(int currentPage) => _currentPage = currentPage;

  OpusRankingEntityData.fromJson(Map<String, dynamic> json) {
    _nextPage = json['next_page'];
    if (json['result'] != null) {
      _result = new List<OpusRankingEntity>();
      json['result'].forEach((v) {
        _result.add(new OpusRankingEntity.fromJson(v));
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

class OpusRankingEntity {
  int _opusId;
  int _userId;
  String _opusTitle;
  String _opusIntroduce;
  String _opusTime;
  int _opusSatisfied;
  int _opusSee;
  int _opusFollow;
  int _opusCollection;
  String _opusImg;
  int _opusStatus;
  int _opusType;
  int _opusOriginal;
  int _opusJurisdiction;
  int _opusIsEdit;
  String _userHeadImg;
  String _userNickname;
  String _userAutograph;

  OpusRankingEntity(
      {int opusId,
      int userId,
      String opusTitle,
      String opusIntroduce,
      String opusTime,
      int opusSatisfied,
      int opusSee,
      int opusFollow,
      int opusCollection,
      String opusImg,
      int opusStatus,
      int opusType,
      int opusOriginal,
      int opusJurisdiction,
      int opusIsEdit,
      String userHeadImg,
      String userNickname,
      String userAutograph}) {
    this._opusId = opusId;
    this._userId = userId;
    this._opusTitle = opusTitle;
    this._opusIntroduce = opusIntroduce;
    this._opusTime = opusTime;
    this._opusSatisfied = opusSatisfied;
    this._opusSee = opusSee;
    this._opusFollow = opusFollow;
    this._opusCollection = opusCollection;
    this._opusImg = opusImg;
    this._opusStatus = opusStatus;
    this._opusType = opusType;
    this._opusOriginal = opusOriginal;
    this._opusJurisdiction = opusJurisdiction;
    this._opusIsEdit = opusIsEdit;
    this._userHeadImg = userHeadImg;
    this._userNickname = userNickname;
    this._userAutograph = userAutograph;
  }

  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get opusTitle => _opusTitle;
  set opusTitle(String opusTitle) => _opusTitle = opusTitle;
  String get opusIntroduce => _opusIntroduce;
  set opusIntroduce(String opusIntroduce) => _opusIntroduce = opusIntroduce;
  String get opusTime => _opusTime;
  set opusTime(String opusTime) => _opusTime = opusTime;
  int get opusSatisfied => _opusSatisfied;
  set opusSatisfied(int opusSatisfied) => _opusSatisfied = opusSatisfied;
  int get opusSee => _opusSee;
  set opusSee(int opusSee) => _opusSee = opusSee;
  int get opusFollow => _opusFollow;
  set opusFollow(int opusFollow) => _opusFollow = opusFollow;
  int get opusCollection => _opusCollection;
  set opusCollection(int opusCollection) => _opusCollection = opusCollection;
  String get opusImg => _opusImg;
  set opusImg(String opusImg) => _opusImg = opusImg;
  int get opusStatus => _opusStatus;
  set opusStatus(int opusStatus) => _opusStatus = opusStatus;
  int get opusType => _opusType;
  set opusType(int opusType) => _opusType = opusType;
  int get opusOriginal => _opusOriginal;
  set opusOriginal(int opusOriginal) => _opusOriginal = opusOriginal;
  int get opusJurisdiction => _opusJurisdiction;
  set opusJurisdiction(int opusJurisdiction) =>
      _opusJurisdiction = opusJurisdiction;
  int get opusIsEdit => _opusIsEdit;
  set opusIsEdit(int opusIsEdit) => _opusIsEdit = opusIsEdit;
  String get userHeadImg => _userHeadImg;
  set userHeadImg(String userHeadImg) => _userHeadImg = userHeadImg;
  String get userNickname => _userNickname;
  set userNickname(String userNickname) => _userNickname = userNickname;
  String get userAutograph => _userAutograph;
  set userAutograph(String userAutograph) => _userAutograph = userAutograph;

  OpusRankingEntity.fromJson(Map<String, dynamic> json) {
    _opusId = json['opus_id'];
    _userId = json['user_id'];
    _opusTitle = json['opus_title'];
    _opusIntroduce = json['opus_introduce'];
    _opusTime = json['opus_time'];
    _opusSatisfied = json['opus_satisfied'];
    _opusSee = json['opus_see'];
    _opusFollow = json['opus_follow'];
    _opusCollection = json['opus_collection'];
    _opusImg = json['opus_img'];
    _opusStatus = json['opus_status'];
    _opusType = json['opus_type'];
    _opusOriginal = json['opus_original'];
    _opusJurisdiction = json['opus_jurisdiction'];
    _opusIsEdit = json['opus_is_edit'];
    _userHeadImg = json['user_head_img'];
    _userNickname = json['user_nickname'];
    _userAutograph = json['user_autograph'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['opus_id'] = this._opusId;
    data['user_id'] = this._userId;
    data['opus_title'] = this._opusTitle;
    data['opus_introduce'] = this._opusIntroduce;
    data['opus_time'] = this._opusTime;
    data['opus_satisfied'] = this._opusSatisfied;
    data['opus_see'] = this._opusSee;
    data['opus_follow'] = this._opusFollow;
    data['opus_collection'] = this._opusCollection;
    data['opus_img'] = this._opusImg;
    data['opus_status'] = this._opusStatus;
    data['opus_type'] = this._opusType;
    data['opus_original'] = this._opusOriginal;
    data['opus_jurisdiction'] = this._opusJurisdiction;
    data['opus_is_edit'] = this._opusIsEdit;
    data['user_head_img'] = this._userHeadImg;
    data['user_nickname'] = this._userNickname;
    data['user_autograph'] = this._userAutograph;
    return data;
  }
}
