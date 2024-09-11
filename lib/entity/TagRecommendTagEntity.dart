class TagRecommendTagEntityList {
  int _code;
  List<TagRecommendTagEntityData> _data;
  String _message;

  TagRecommendTagEntityList(
      {int code, List<TagRecommendTagEntityData> data, String message}) {
    this._code = code;
    this._data = data;
    this._message = message;
  }

  int get code => _code;
  set code(int code) => _code = code;
  List<TagRecommendTagEntityData> get data => _data;
  set data(List<TagRecommendTagEntityData> data) => _data = data;
  String get message => _message;
  set message(String message) => _message = message;

  TagRecommendTagEntityList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    if (json['data'] != null) {
      _data = new List<TagRecommendTagEntityData>();
      json['data'].forEach((v) {
        _data.add(new TagRecommendTagEntityData.fromJson(v));
      });
    }
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    data['message'] = this._message;
    return data;
  }
}

class TagRecommendTagEntityData {
  int _opusId;
  int _tagsId;
  int _tagsRecommend;
  String _tagsTitle;
  int _userId;

  TagRecommendTagEntityData(
      {int opusId,
      int tagsId,
      int tagsRecommend,
      String tagsTitle,
      int userId}) {
    this._opusId = opusId;
    this._tagsId = tagsId;
    this._tagsRecommend = tagsRecommend;
    this._tagsTitle = tagsTitle;
    this._userId = userId;
  }

  int get opusId => _opusId;
  set opusId(int opusId) => _opusId = opusId;
  int get tagsId => _tagsId;
  set tagsId(int tagsId) => _tagsId = tagsId;
  int get tagsRecommend => _tagsRecommend;
  set tagsRecommend(int tagsRecommend) => _tagsRecommend = tagsRecommend;
  String get tagsTitle => _tagsTitle;
  set tagsTitle(String tagsTitle) => _tagsTitle = tagsTitle;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;

  TagRecommendTagEntityData.fromJson(Map<String, dynamic> json) {
    _opusId = json['opus_id'];
    _tagsId = json['tags_id'];
    _tagsRecommend = json['tags_recommend'];
    _tagsTitle = json['tags_title'];
    _userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['opus_id'] = this._opusId;
    data['tags_id'] = this._tagsId;
    data['tags_recommend'] = this._tagsRecommend;
    data['tags_title'] = this._tagsTitle;
    data['user_id'] = this._userId;
    return data;
  }
}
