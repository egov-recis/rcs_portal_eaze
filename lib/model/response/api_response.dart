class ApiResponse<T> {
  String? timestamp;
  int? code;
  String? status;
  String? message;
  T? data;
  String? _error;

  ApiResponse({
    this.timestamp,
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) create,
  ) {
    return ApiResponse<T>(
      timestamp: json['timestamp'],
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? create(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (this.data != null) {
      map['data'] = this.data;
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

  setData(Map map, T Function(Map<String, dynamic> data) builder) {
    this.code = map['code'];
    this.timestamp = map['timestamp'];
    this.status = map['status'];
    this.message = map['message'];
    this.data = map['data'] != null ? builder(map['data']) : null;
  }

  get getException {
    return _error;
  }
}
