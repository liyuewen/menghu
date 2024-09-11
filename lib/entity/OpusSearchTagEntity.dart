class OpusSearchTagEntityList {
  int _code;
  String _message;
  OpusSearchTagEntityData _data;

  OpusSearchTagEntityList(
      {int code, Null message, OpusSearchTagEntityData data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  Null get message => _message;
  set message(Null message) => _message = message;
  OpusSearchTagEntityData get data => _data;
  set data(OpusSearchTagEntityData data) => _data = data;

  OpusSearchTagEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new OpusSearchTagEntityData.fromJson(json['data'])
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

class OpusSearchTagEntityData {
  int _nextPage;
  List<OpusSearchTagEntityResult> _result;
  List<String> _keywords;
  int _totalPage;
  int _currentPage;

  OpusSearchTagEntityData(
      {int nextPage,
      List<OpusSearchTagEntityResult> result,
      List<String> keywords,
      int totalPage,
      int currentPage}) {
    this._nextPage = nextPage;
    this._result = result;
    this._keywords = keywords;
    this._totalPage = totalPage;
    this._currentPage = currentPage;
  }

  int get nextPage => _nextPage;
  set nextPage(int nextPage) => _nextPage = nextPage;
  List<OpusSearchTagEntityResult> get result => _result;
  set result(List<OpusSearchTagEntityResult> result) => _result = result;
  List<String> get keywords => _keywords;
  set keywords(List<String> keywords) => _keywords = keywords;
  int get totalPage => _totalPage;
  set totalPage(int totalPage) => _totalPage = totalPage;
  int get currentPage => _currentPage;
  set currentPage(int currentPage) => _currentPage = currentPage;

  OpusSearchTagEntityData.fromJson(Map<String, dynamic> json) {
    _nextPage = json['next_page'];
    if (json['result'] != null) {
      _result = new List<OpusSearchTagEntityResult>();
      json['result'].forEach((v) {
        _result.add(new OpusSearchTagEntityResult.fromJson(v));
      });
    }
    _keywords = json['keywords'].cast<String>();
    _totalPage = json['total_page'];
    _currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page'] = this._nextPage;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    data['keywords'] = this._keywords;
    data['total_page'] = this._totalPage;
    data['current_page'] = this._currentPage;
    return data;
  }
}

class OpusSearchTagEntityResult {
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

  OpusSearchTagEntityResult(
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
      int opusJurisdiction}) {
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

  OpusSearchTagEntityResult.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
