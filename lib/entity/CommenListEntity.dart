class CommenListEntityList {
  int _code;
  String _message;
  CommenListEntityData _data;

  CommenListEntityList({int code, Null message, CommenListEntityData data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  Null get message => _message;
  set message(Null message) => _message = message;
  CommenListEntityData get data => _data;
  set data(CommenListEntityData data) => _data = data;

  CommenListEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new CommenListEntityData.fromJson(json['data'])
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

class CommenListEntityData {
  int _nextPage;
  List<CommenListEntity> _result;
  int _totalPage;
  int _currentPage;

  CommenListEntityData(
      {int nextPage,
      List<CommenListEntity> result,
      int totalPage,
      int currentPage}) {
    this._nextPage = nextPage;
    this._result = result;
    this._totalPage = totalPage;
    this._currentPage = currentPage;
  }

  int get nextPage => _nextPage;
  set nextPage(int nextPage) => _nextPage = nextPage;
  List<CommenListEntity> get result => _result;
  set result(List<CommenListEntity> result) => _result = result;
  int get totalPage => _totalPage;
  set totalPage(int totalPage) => _totalPage = totalPage;
  int get currentPage => _currentPage;
  set currentPage(int currentPage) => _currentPage = currentPage;

  CommenListEntityData.fromJson(Map<String, dynamic> json) {
    _nextPage = json['next_page'];
    if (json['result'] != null) {
      _result = new List<CommenListEntity>();
      json['result'].forEach((v) {
        _result.add(new CommenListEntity.fromJson(v));
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

class CommenListEntity {
  int _commentId;
  int _opusId;
  int _dynamicId;
  int _userId;
  String _commentContent;
  String _commentTime;
  int _commentReplyId;
  String _commentToUsername;
  String _userNickname;
  String _userHeadImg;
  int _commentType;
  List<Child> _child;

  CommenListEntity(
      {int commentId,
      int opusId,
      int dynamicId,
      int userId,
      String commentContent,
      String commentTime,
      int commentReplyId,
      String commentToUsername,
      String userNickname,
      String userHeadImg,
      int commentType,
      List<Child> child}) {
    this._commentId = commentId;
    this._opusId = opusId;
    this._dynamicId = dynamicId;
    this._userId = userId;
    this._commentContent = commentContent;
    this._commentTime = commentTime;
    this._commentReplyId = commentReplyId;
    this._commentToUsername = commentToUsername;
    this._userNickname = userNickname;
    this._userHeadImg = userHeadImg;
    this._commentType = commentType;
    this._child = child;
  }

  int get commentId => _commentId;
  set commentId(int commentId) => _commentId = commentId;
  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  int get dynamicId => _dynamicId;
  set dynamicId(int dynamicId) => _dynamicId = dynamicId;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get commentContent => _commentContent;
  set commentContent(String commentContent) => _commentContent = commentContent;
  String get commentTime => _commentTime;
  set commentTime(String commentTime) => _commentTime = commentTime;
  int get commentReplyId => _commentReplyId;
  set commentReplyId(int commentReplyId) => _commentReplyId = commentReplyId;
  String get commentToUsername => _commentToUsername;
  set commentToUsername(String commentToUsername) =>
      _commentToUsername = commentToUsername;
  String get userNickname => _userNickname;
  set userNickname(String userNickname) => _userNickname = userNickname;
  String get userHeadImg => _userHeadImg;
  set userHeadImg(String userHeadImg) => _userHeadImg = userHeadImg;
  int get commentType => _commentType;
  set commentType(int commentType) => _commentType = commentType;
  List<Child> get child => _child;
  set child(List<Child> child) => _child = child;

  CommenListEntity.fromJson(Map<String, dynamic> json) {
    _commentId = json['comment_id'];
    _opusId = json['opus_id'];
    _dynamicId = json['dynamic_id'];
    _userId = json['user_id'];
    _commentContent = json['comment_content'];
    _commentTime = json['comment_time'];
    _commentReplyId = json['comment_reply_id'];
    _commentToUsername = json['comment_to_username'];
    _userNickname = json['user_nickname'];
    _userHeadImg = json['user_head_img'];
    _commentType = json['comment_type'];
    if (json['child'] != null) {
      _child = new List<Child>();
      json['child'].forEach((v) {
        _child.add(new Child.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this._commentId;
    data['opus_id'] = this._opusId;
    data['dynamic_id'] = this._dynamicId;
    data['user_id'] = this._userId;
    data['comment_content'] = this._commentContent;
    data['comment_time'] = this._commentTime;
    data['comment_reply_id'] = this._commentReplyId;
    data['comment_to_username'] = this._commentToUsername;
    data['user_nickname'] = this._userNickname;
    data['user_head_img'] = this._userHeadImg;
    data['comment_type'] = this._commentType;
    if (this._child != null) {
      data['child'] = this._child.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Child {
  int _commentId;
  int _opusId;
  int _dynamicId;
  int _userId;
  String _commentContent;
  String _commentTime;
  int _commentReplyId;
  String _commentToUsername;
  String _userNickname;
  String _userHeadImg;
  int _commentType;

  Child(
      {int commentId,
      int opusId,
      int dynamicId,
      int userId,
      String commentContent,
      String commentTime,
      int commentReplyId,
      String commentToUsername,
      String userNickname,
      String userHeadImg,
      int commentType}) {
    this._commentId = commentId;
    this._opusId = opusId;
    this._dynamicId = dynamicId;
    this._userId = userId;
    this._commentContent = commentContent;
    this._commentTime = commentTime;
    this._commentReplyId = commentReplyId;
    this._commentToUsername = commentToUsername;
    this._userNickname = userNickname;
    this._userHeadImg = userHeadImg;
    this._commentType = commentType;
  }

  int get commentId => _commentId;
  set commentId(int commentId) => _commentId = commentId;
  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  int get dynamicId => _dynamicId;
  set dynamicId(int dynamicId) => _dynamicId = dynamicId;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get commentContent => _commentContent;
  set commentContent(String commentContent) => _commentContent = commentContent;
  String get commentTime => _commentTime;
  set commentTime(String commentTime) => _commentTime = commentTime;
  int get commentReplyId => _commentReplyId;
  set commentReplyId(int commentReplyId) => _commentReplyId = commentReplyId;
  String get commentToUsername => _commentToUsername;
  set commentToUsername(String commentToUsername) =>
      _commentToUsername = commentToUsername;
  String get userNickname => _userNickname;
  set userNickname(String userNickname) => _userNickname = userNickname;
  String get userHeadImg => _userHeadImg;
  set userHeadImg(String userHeadImg) => _userHeadImg = userHeadImg;
  int get commentType => _commentType;
  set commentType(int commentType) => _commentType = commentType;

  Child.fromJson(Map<String, dynamic> json) {
    _commentId = json['comment_id'];
    _opusId = json['opus_id'];
    _dynamicId = json['dynamic_id'];
    _userId = json['user_id'];
    _commentContent = json['comment_content'];
    _commentTime = json['comment_time'];
    _commentReplyId = json['comment_reply_id'];
    _commentToUsername = json['comment_to_username'];
    _userNickname = json['user_nickname'];
    _userHeadImg = json['user_head_img'];
    _commentType = json['comment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this._commentId;
    data['opus_id'] = this._opusId;
    data['dynamic_id'] = this._dynamicId;
    data['user_id'] = this._userId;
    data['comment_content'] = this._commentContent;
    data['comment_time'] = this._commentTime;
    data['comment_reply_id'] = this._commentReplyId;
    data['comment_to_username'] = this._commentToUsername;
    data['user_nickname'] = this._userNickname;
    data['user_head_img'] = this._userHeadImg;
    data['comment_type'] = this._commentType;
    return data;
  }
}
