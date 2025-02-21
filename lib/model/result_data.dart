class ResultData<T> {
  dynamic rc;
  String? rcm;
  String? _error;
  T? data;

  setException(String error) {
    _error = error;
  }

  setData(dynamic map, T Function(Map<String, dynamic>? data) builder) {
    this.rc = map?['rc'] ?? map?['RC'];
    this.rcm = map?['rcm'] ?? map?['RCM'];
    this.data =
        map?['data'] is List ? null : builder(map?['data'] ?? map?['Data']);
  }

  setDataList(Map? map, T Function(List<dynamic>? data) builder) {
    this.rc = map?['rc'] ?? map?['RC'];
    this.rcm = map?['rcm'] ?? map?['RCM'];
    this.data = builder(map?['data'] ?? map?['Data']);
  }

  get getException {
    return _error;
  }
}
