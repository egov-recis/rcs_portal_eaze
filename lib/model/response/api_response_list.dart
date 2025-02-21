class ApiResponseList<T> {
  String? timestamp;
  int? code;
  String? status;
  String? message;
  List<T>? data;
  String? _error;

  ApiResponseList({
    this.timestamp,
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory ApiResponseList.fromJson(
    Map<String, dynamic> json,
    List<T> Function(List<dynamic>) create,
  ) {
    return ApiResponseList<T>(
      timestamp: json['timestamp'],
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? create(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.map((v) => v).toList();
    }
    map['message'] = message;
    map['status'] = status;
    map['code'] = code;
    map['timestamp'] = timestamp;
    return map;
  }

  setException(String error) {
    _error = error;
  }

  setData(Map map, List<T> Function(List<dynamic> data) builder) {
    this.code = map['code'];
    this.timestamp = map['timestamp'];
    this.status = map['status'];
    this.message = map['message'];
    this.data = builder(map['data']);
  }

  get getException {
    return _error;
  }
}
