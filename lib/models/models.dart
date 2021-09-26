class Models {
  Models({
    this.missionName,
    this.launchDateUtc,
    this.rocket,
    this.launchSite,
    this.links,
    this.details,
    this.launchSuccess,
  });

  String missionName;
  DateTime launchDateUtc;
  Rocket rocket;
  LaunchSite launchSite;
  Links links;
  dynamic details;
  bool launchSuccess;

  factory Models.fromJson(Map<String, dynamic> json) => Models(
    missionName: json["mission_name"],
    launchDateUtc: DateTime.parse(json["launch_date_utc"]),
    rocket: Rocket.fromJson(json["rocket"]),
    launchSite: LaunchSite.fromJson(json["launch_site"]),
    links: Links.fromJson(json["links"]),
    details: json["details"],
    launchSuccess: json["launch_success"],
  );

  Map<String, dynamic> toJson() => {
    "mission_name": missionName,
    "launch_date_utc": launchDateUtc.toIso8601String(),
    "rocket": rocket.toJson(),
    "launch_site": launchSite.toJson(),
    "links": links.toJson(),
    "details": details,
    "launch_success": launchSuccess,
  };
}

class LaunchSite {
  LaunchSite({
    this.siteName,
  });

  String siteName;

  factory LaunchSite.fromJson(Map<String, dynamic> json) => LaunchSite(
    siteName: json["site_name"],
  );

  Map<String, dynamic> toJson() => {
    "site_name": siteName,
  };
}

class Links {
  Links({
    this.flickrImages,
  });

  List<dynamic> flickrImages;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    flickrImages: List<dynamic>.from(json["flickr_images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "flickr_images": List<dynamic>.from(flickrImages.map((x) => x)),
  };
}

class Rocket {
  Rocket({
    this.rocketName,
    this.rocketType,
  });

  String rocketName;
  String rocketType;

  factory Rocket.fromJson(Map<String, dynamic> json) => Rocket(
    rocketName: json["rocket_name"],
    rocketType: json["rocket_type"],
  );

  Map<String, dynamic> toJson() => {
    "rocket_name": rocketName,
    "rocket_type": rocketType,
  };
}
