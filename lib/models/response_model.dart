class ResponseModel {
  bool _isSuccessful;
  String _message;
  ResponseModel(this._isSuccessful, this._message);
  String get messsage => _message;
  bool get isSuccessful => _isSuccessful;
}
