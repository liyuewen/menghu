class OpusOpusInfoEntityList {
  int _code;
  String _message;
  OpusOpusInfoEntityData _data;

  OpusOpusInfoEntityList(
      {int code, String message, OpusOpusInfoEntityData data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get message => _message;
  set message(String message) => _message = message;
  OpusOpusInfoEntityData get data => _data;
  set data(OpusOpusInfoEntityData data) => _data = data;

  OpusOpusInfoEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new OpusOpusInfoEntityData.fromJson(json['data'])
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

class OpusOpusInfoEntityData {
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
  List<NewsOpus> _newsOpus;
  OpusOpusInfoEntityUserInfo _userInfo;
  List<OpusImgs> _opusImgs;
  List<Tags> _tags;

  OpusOpusInfoEntityData(
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
      List<NewsOpus> newsOpus,
      OpusOpusInfoEntityUserInfo userInfo,
      List<OpusImgs> opusImgs,
      List<Tags> tags}) {
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
    this._newsOpus = newsOpus;
    this._userInfo = userInfo;
    this._opusImgs = opusImgs;
    this._tags = tags;
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
  List<NewsOpus> get newsOpus => _newsOpus;
  set newsOpus(List<NewsOpus> newsOpus) => _newsOpus = newsOpus;
  OpusOpusInfoEntityUserInfo get userInfo => _userInfo;
  set userInfo(OpusOpusInfoEntityUserInfo userInfo) => _userInfo = userInfo;
  List<OpusImgs> get opusImgs => _opusImgs;
  set opusImgs(List<OpusImgs> opusImgs) => _opusImgs = opusImgs;
  List<Tags> get tags => _tags;
  set tags(List<Tags> tags) => _tags = tags;

  OpusOpusInfoEntityData.fromJson(Map<String, dynamic> json) {
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
    if (json['news_opus'] != null) {
      _newsOpus = new List<NewsOpus>();
      json['news_opus'].forEach((v) {
        _newsOpus.add(new NewsOpus.fromJson(v));
      });
    }
    _userInfo = json['user_info'] != null
        ? new OpusOpusInfoEntityUserInfo.fromJson(json['user_info'])
        : null;
    if (json['opus_imgs'] != null) {
      _opusImgs = new List<OpusImgs>();
      json['opus_imgs'].forEach((v) {
        _opusImgs.add(new OpusImgs.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      _tags = new List<Tags>();
      json['tags'].forEach((v) {
        _tags.add(new Tags.fromJson(v));
      });
    }
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
    if (this._newsOpus != null) {
      data['news_opus'] = this._newsOpus.map((v) => v.toJson()).toList();
    }
    if (this._userInfo != null) {
      data['user_info'] = this._userInfo.toJson();
    }
    if (this._opusImgs != null) {
      data['opus_imgs'] = this._opusImgs.map((v) => v.toJson()).toList();
    }
    if (this._tags != null) {
      data['tags'] = this._tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsOpus {
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

  NewsOpus(
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
      int opusIsEdit}) {
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

  NewsOpus.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class OpusOpusInfoEntityUserInfo {
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

  OpusOpusInfoEntityUserInfo(
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
      Null userBirthday,
      Null userConstellation,
      String userAutograph}) {
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
  Null get userBirthday => _userBirthday;
  set userBirthday(Null userBirthday) => _userBirthday = userBirthday;
  Null get userConstellation => _userConstellation;
  set userConstellation(Null userConstellation) =>
      _userConstellation = userConstellation;
  String get userAutograph => _userAutograph;
  set userAutograph(String userAutograph) => _userAutograph = userAutograph;

  OpusOpusInfoEntityUserInfo.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class OpusImgs {
  int _opusId;
  String _imgUrl;
  int _userId;
  int _imgId;
  int _imgWidth;
  int _imgHeight;

  OpusImgs(
      {int opusId,
      String imgUrl,
      int userId,
      int imgId,
      int imgWidth,
      int imgHeight}) {
    this._opusId = opusId;
    this._imgUrl = imgUrl;
    this._userId = userId;
    this._imgId = imgId;
    this._imgWidth = _imgWidth;
    this._imgHeight = _imgHeight;
  }

  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  String get imgUrl => _imgUrl;
  set imgUrl(String imgUrl) => _imgUrl = imgUrl;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  int get imgId => _imgId;
  set imgId(int imgId) => _imgId = imgId;
  int get imgWidth => _imgWidth;
  set imgWidth(int imgWidth) => _imgWidth = imgWidth;
  int get imgHeight => _imgHeight;
  set imgHeight(int imgHeight) => _imgHeight = imgHeight;

  OpusImgs.fromJson(Map<String, dynamic> json) {
    _opusId = json['opus_id'];
    _imgUrl = json['img_url'];
    _userId = json['user_id'];
    _imgId = json['img_id'];
    _imgWidth = json['img_width'];
    _imgHeight = json['img_height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['opus_id'] = this._opusId;
    data['img_url'] = this._imgUrl;
    data['user_id'] = this._userId;
    data['img_id'] = this._imgId;
    return data;
  }
}

class Tags {
  int _tagsId;
  int _opusId;
  String _tagsTitle;
  int _tagsRecommend;
  int _userId;

  Tags(
      {int tagsId,
      int opusId,
      String tagsTitle,
      int tagsRecommend,
      int userId}) {
    this._tagsId = tagsId;
    this._opusId = opusId;
    this._tagsTitle = tagsTitle;
    this._tagsRecommend = tagsRecommend;
    this._userId = userId;
  }

  int get tagsId => _tagsId;
  set tagsId(int tagsId) => _tagsId = tagsId;
  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  String get tagsTitle => _tagsTitle;
  set tagsTitle(String tagsTitle) => _tagsTitle = tagsTitle;
  int get tagsRecommend => _tagsRecommend;
  set tagsRecommend(int tagsRecommend) => _tagsRecommend = tagsRecommend;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;

  Tags.fromJson(Map<String, dynamic> json) {
    _tagsId = json['tags_id'];
    _opusId = json['opus_id'];
    _tagsTitle = json['tags_title'];
    _tagsRecommend = json['tags_recommend'];
    _userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tags_id'] = this._tagsId;
    data['opus_id'] = this._opusId;
    data['tags_title'] = this._tagsTitle;
    data['tags_recommend'] = this._tagsRecommend;
    data['user_id'] = this._userId;
    return data;
  }
}
