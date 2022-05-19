class Farmacia {
  String nome;

  String user;

  String token;

  String url;

  String resource;

  String login;

  int? porta;

  Farmacia({required this.nome, required this.user, required this.token, required this.url, required this.resource, required this.login, this.porta});

  factory Farmacia.fromJSON(Map<dynamic, dynamic> json) {
    return Farmacia(
      nome: (json['nome'] == '') ? "FARMACIA SENZA NOME" : json['nome'],
      url: json['url'] ?? '',
      login: json['login'] ?? '/login',
      resource: json['resource'] ?? '',
      token: json['token'] ?? '',
      user: json['user'] ?? '',
      porta: json['port'] ?? 6100,
    );
  }

  Map<String, dynamic> toJson() => {
    'nome' : nome,
    'url': url,
    'login': login,
    'resource': resource,
    'token': token,
    'user': user,
    'port' : porta,
  };
}