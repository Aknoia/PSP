


class Notizia {

  String id;
  String url;
  String titolo;
  String contenutoHTML;
  String contenutoTXT;

  DateTime dataPubblicazione;
  DateTime dataModifica;

  AutoreNews autore;

  /// List<String>
  List<dynamic> tags;

  bool notiziaLetta;


  Notizia({
    required this.id,
    required this.url,
    required this.titolo,
    required this.contenutoHTML,
    required this.contenutoTXT,
    required this.dataPubblicazione,
    required this.dataModifica,
    required this.autore,
    required this.tags,
    required this.notiziaLetta,
  });


  factory Notizia.fromJSON(Map<String, dynamic> json) {
    return Notizia(
        id: json['id'],
        url: json['url'],
        titolo: json['title'],
        contenutoHTML: json['content_html'] ?? '',
        contenutoTXT: json['content_text'] ?? '',
        dataPubblicazione: DateTime.parse(json['date_published']),
        dataModifica: DateTime.parse(json['date_modified']),
        autore: AutoreNews.fromJSON(json['author']),
        tags: json['tags'],
        notiziaLetta: json['read'] ?? false,
    );
  }
}




class AutoreNews {

  String nome;

  String url;

  String avatar;

  AutoreNews({
    required this.nome,
    required this.url,
    required this.avatar,
  });

  factory AutoreNews.fromJSON(Map<String, dynamic> json) {
    return AutoreNews(
        nome: json['name'],
        url: json['url'],
        avatar: json['avatar'],
    );
  }
}