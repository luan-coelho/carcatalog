class RegisterRequest {
  String name;
  String login;
  String password;

  RegisterRequest(this.name, this.login, this.password);

  RegisterRequest.factory({
    required this.name,
    required this.login,
    required this.password,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      json['name'],
      json['login'],
      json['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'login': login,
      'password': password,
    };
  }
}
