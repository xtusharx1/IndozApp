class HireStudioRequest {
  final String userId;
  final String email;
  final String phoneNumber;
  final String query;

  HireStudioRequest({
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.query,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': email,
        'phoneNumber': phoneNumber,
        'query': query,
      };
}
