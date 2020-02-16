class User {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  User.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        login = map["login"],
        nome = map["nome"],
        email = map["email"],
        urlFoto = map["urlFoto"],
        token = map["token"],
        roles = map["roles"] != null ? map["roles"].map<String>((role) => role.toString()).toList() : null;

  @override
  String toString() {
    return 'User{id: $id, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles}';
  }
}
