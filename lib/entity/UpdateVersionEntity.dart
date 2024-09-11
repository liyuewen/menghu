class UpdateVersionEntity {
  int _code;
  Null _message;
  Data _data;

  UpdateVersionEntity({int code, Null message, Data data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  Null get message => _message;
  set message(Null message) => _message = message;
  Data get data => _data;
  set data(Data data) => _data = data;

  UpdateVersionEntity.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int _updateId;
  String _updateVersion;
  int _updateVersionCode;
  String _updateDownUrl;
  String _updateContent;
  int _updateForce;
  int _updateDownCount;
  int _updateSize;
  String _updateTime;

  Data(
      {int updateId,
        String updateVersion,
        int updateVersionCode,
        String updateDownUrl,
        String updateContent,
        int updateForce,
        int updateDownCount,
        int updateSize,
        String updateTime}) {
    this._updateId = updateId;
    this._updateVersion = updateVersion;
    this._updateVersionCode = updateVersionCode;
    this._updateDownUrl = updateDownUrl;
    this._updateContent = updateContent;
    this._updateForce = updateForce;
    this._updateDownCount = updateDownCount;
    this._updateSize = updateSize;
    this._updateTime = updateTime;
  }

  int get updateId => _updateId;
  set updateId(int updateId) => _updateId = updateId;
  String get updateVersion => _updateVersion;
  set updateVersion(String updateVersion) => _updateVersion = updateVersion;
  int get updateVersionCode => _updateVersionCode;
  set updateVersionCode(int updateVersionCode) =>
      _updateVersionCode = updateVersionCode;
  String get updateDownUrl => _updateDownUrl;
  set updateDownUrl(String updateDownUrl) => _updateDownUrl = updateDownUrl;
  String get updateContent => _updateContent;
  set updateContent(String updateContent) => _updateContent = updateContent;
  int get updateForce => _updateForce;
  set updateForce(int updateForce) => _updateForce = updateForce;
  int get updateDownCount => _updateDownCount;
  set updateDownCount(int updateDownCount) =>
      _updateDownCount = updateDownCount;
  int get updateSize => _updateSize;
  set updateSize(int updateSize) => _updateSize = updateSize;
  String get updateTime => _updateTime;
  set updateTime(String updateTime) => _updateTime = updateTime;

  Data.fromJson(Map<String, dynamic> json) {
    _updateId = json['update_id'];
    _updateVersion = json['update_version'];
    _updateVersionCode = json['update_version_code'];
    _updateDownUrl = json['update_down_url'];
    _updateContent = json['update_content'];
    _updateForce = json['update_force'];
    _updateDownCount = json['update_down_count'];
    _updateSize = json['update_size'];
    _updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['update_id'] = this._updateId;
    data['update_version'] = this._updateVersion;
    data['update_version_code'] = this._updateVersionCode;
    data['update_down_url'] = this._updateDownUrl;
    data['update_content'] = this._updateContent;
    data['update_force'] = this._updateForce;
    data['update_down_count'] = this._updateDownCount;
    data['update_size'] = this._updateSize;
    data['update_time'] = this._updateTime;
    return data;
  }
}
