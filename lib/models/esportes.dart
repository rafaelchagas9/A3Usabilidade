class Esporte {
  List<Esportes>? esportes;

  Esporte({this.esportes});

  Esporte.fromJson(Map<String, dynamic> json) {
    if (json['esportes'] != null) {
      esportes = <Esportes>[];
      json['esportes'].forEach((v) {
        esportes!.add(new Esportes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.esportes != null) {
      data['esportes'] = this.esportes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Esportes {
  int? id;
  String? name;
  String? imageUrl;
  String? descricao;

  Esportes({this.id, this.name, this.imageUrl, this.descricao});

  Esportes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['descricao'] = this.descricao;
    return data;
  }
}
