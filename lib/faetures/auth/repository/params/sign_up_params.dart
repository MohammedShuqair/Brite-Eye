class SignUpParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String gender;
  final String role;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.gender,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "gender": gender,
      "role": role,
    };
  }
}
