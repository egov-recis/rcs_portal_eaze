class Token {
  String? token;
  String? name;
  String? email;
  dynamic profilePic;
  AppConfig? appConfig;

  Token({this.token, this.name, this.email, this.profilePic, this.appConfig});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    email = json['email'];
    profilePic = json['profile_pic'];
    appConfig = json['app_config'] != null
        ? new AppConfig.fromJson(json['app_config'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    data['email'] = email;
    data['profile_pic'] = profilePic;
    if (appConfig != null) {
      data['app_config'] = appConfig?.toJson();
    }
    return data;
  }
}

class AppConfig {
  String? title;
  String? showPrintButton;
  String? showShareButton;
  Colors? colors;
  String? logo;
  String? mobileLogo;
  String? showEazeLogo;

  AppConfig(
      {this.title,
      this.showPrintButton,
      this.showShareButton,
      this.colors,
      this.logo,
      this.mobileLogo,
      this.showEazeLogo});

  AppConfig.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    showPrintButton = json['showPrintButton'];
    showShareButton = json['showShareButton'];
    colors = json['colors'] != null ? Colors.fromJson(json['colors']) : null;
    logo = json['logo'];
    mobileLogo = json['mobileLogo'];
    showEazeLogo = json['showEazeLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['showPrintButton'] = showPrintButton;
    data['showShareButton'] = showShareButton;
    if (colors != null) {
      data['colors'] = colors?.toJson();
    }
    data['logo'] = logo;
    data['mobileLogo'] = mobileLogo;
    data['showEazeLogo'] = showEazeLogo;
    return data;
  }
}

class Colors {
  String? primary;
  String? textButton;

  Colors({this.primary, this.textButton});

  Colors.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    textButton = json['textButton'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['primary'] = primary;
    data['textButton'] = textButton;
    return data;
  }
}
