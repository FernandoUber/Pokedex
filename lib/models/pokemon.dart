class Pokemon {
  String nome = '';
  String urlApi = '';
  String spriteUrl = '';

  Pokemon.fromJson(Map<String, dynamic> json) {
    nome = json['name'] ?? '';
    urlApi = json['url'] ?? '';
    spriteUrl = json['sprites']?['front_default'] ?? '';
  }
}
