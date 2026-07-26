class Ad {
  final int id;
  final String adImage;
  final String redirectUrl;
  final bool isActive;
  final String type;

  Ad({
    required this.id,
    required this.adImage,
    required this.redirectUrl,
    required this.isActive,
    required this.type,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'],
      adImage: json['ad_image'],
      redirectUrl: json['redirect_url'],
      isActive: json['is_active'],
      type: json['type'],
    );
  }
}