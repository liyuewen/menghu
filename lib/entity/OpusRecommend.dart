class OpusRecommendList {
  int _code;
  OpusRecommendData _data;
  String _message;

  OpusRecommendList({int code, OpusRecommendData data, String message}) {
    this._code = code;
    this._data = data;
    this._message = message;
  }

  int get code => _code;
  set code(int code) => _code = code;
  OpusRecommendData get data => _data;
  set data(OpusRecommendData data) => _data = data;
  String get message => _message;
  set message(String message) => _message = message;

  OpusRecommendList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _data = json['data'] != null
        ? new OpusRecommendData.fromJson(json['data'])
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

class OpusRecommendData {
  int _currentPage;
  int _nextPage;
  List<OpusRecommendResult> _result;
  int _totalPage;

  OpusRecommendData(
      {int currentPage,
      int nextPage,
      List<OpusRecommendResult> result,
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
  List<OpusRecommendResult> get result => _result;
  set result(List<OpusRecommendResult> result) => _result = result;
  int get totalPage => _totalPage;
  set totalPage(int totalPage) => _totalPage = totalPage;

  OpusRecommendData.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    _nextPage = json['next_page'];
    if (json['result'] != null) {
      _result = new List<OpusRecommendResult>();
      json['result'].forEach((v) {
        _result.add(new OpusRecommendResult.fromJson(v));
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

class OpusRecommendResult {
  int _opusFollow;
  int _opusId;
  String _opusImg;
  String _opusIntroduce;
  int _opusSatisfied;
  int _opusSee;
  int _opusStatus;
  String _opusTime;
  String _opusTitle;
  int _opusType;
  int _userId;

  OpusRecommendResult(
      {int opusFollow,
      int opusId,
      String opusImg,
      String opusIntroduce,
      int opusSatisfied,
      int opusSee,
      int opusStatus,
      String opusTime,
      String opusTitle,
      int opusType,
      int userId}) {
    this._opusFollow = opusFollow;
    this._opusId = opusId;
    this._opusImg = opusImg;
    this._opusIntroduce = opusIntroduce;
    this._opusSatisfied = opusSatisfied;
    this._opusSee = opusSee;
    this._opusStatus = opusStatus;
    this._opusTime = opusTime;
    this._opusTitle = opusTitle;
    this._opusType = opusType;
    this._userId = userId;
  }

  int get opusFollow => _opusFollow;
  set opusFollow(int opusFollow) => _opusFollow = opusFollow;
  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  String get opusImg => _opusImg;
  set opusImg(String opusImg) => _opusImg = opusImg;
  String get opusIntroduce => _opusIntroduce;
  set opusIntroduce(String opusIntroduce) => _opusIntroduce = opusIntroduce;
  int get opusSatisfied => _opusSatisfied;
  set opusSatisfied(int opusSatisfied) => _opusSatisfied = opusSatisfied;
  int get opusSee => _opusSee;
  set opusSee(int opusSee) => _opusSee = opusSee;
  int get opusStatus => _opusStatus;
  set opusStatus(int opusStatus) => _opusStatus = opusStatus;
  String get opusTime => _opusTime;
  set opusTime(String opusTime) => _opusTime = opusTime;
  String get opusTitle => _opusTitle;
  set opusTitle(String opusTitle) => _opusTitle = opusTitle;
  int get opusType => _opusType;
  set opusType(int opusType) => _opusType = opusType;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;

  OpusRecommendResult.fromJson(Map<String, dynamic> json) {
    _opusFollow = json['opus_follow'];
    _opusId = json['opus_id'];
    _opusImg = json['opus_img'];
    _opusIntroduce = json['opus_introduce'];
    _opusSatisfied = json['opus_satisfied'];
    _opusSee = json['opus_see'];
    _opusStatus = json['opus_status'];
    _opusTime = json['opus_time'];
    _opusTitle = json['opus_title'];
    _opusType = json['opus_type'];
    _userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['opus_follow'] = this._opusFollow;
    data['opus_id'] = this._opusId;
    data['opus_img'] = this._opusImg;
    data['opus_introduce'] = this._opusIntroduce;
    data['opus_satisfied'] = this._opusSatisfied;
    data['opus_see'] = this._opusSee;
    data['opus_status'] = this._opusStatus;
    data['opus_time'] = this._opusTime;
    data['opus_title'] = this._opusTitle;
    data['opus_type'] = this._opusType;
    data['user_id'] = this._userId;
    return data;
  }
}
