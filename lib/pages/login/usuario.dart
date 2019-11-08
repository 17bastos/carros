class Usuario {
  String login;
  String nome;
  String email;
  String token;

  List<String> roles;

  Usuario.fromJson(Map<String, dynamic> map) :
    login = map['nome'],
    nome = map['nome'],
    email = map['email'],
    token = map['token'],
    roles = map['roles'] != null ? map['roles'].map<String>((role) => role.toString()).toList() : null;
}