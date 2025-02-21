class PostData {
  String? test;
  String? clientRefnum;
  String? billing;
  String? limit;
  String? page;

  Map toMap() {
    return {};
  }

  Map<String, dynamic> toMapTransactionTrack() {
    return {
      'limit': limit,
      'page': page,
      'billing': billing,
    };
  }

  Map<String, dynamic> toMapTracking() {
    return {
      'client_refnum': clientRefnum,
    };
  }
}
