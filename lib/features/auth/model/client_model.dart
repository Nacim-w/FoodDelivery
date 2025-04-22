class Client {
  final String id;
  final String email;
  final String token;

  Client({
    required this.id,
    required this.email,
    required this.token,
  });

  factory Client.empty() {
    return Client(
      id: '',
      email: '',
      token: '',
    );
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      email: json['email'],
      token: json['token'],
    );
  }

  Client copyWith({
    String? id,
    String? email,
    String? token,
  }) {
    return Client(
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }
}
