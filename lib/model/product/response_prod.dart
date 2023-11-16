class ResponseProducts {
  int ?id;
  String? name;
  String ?summary;

  ResponseProducts({ this.id, this.name, this.summary});

  ResponseProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['summary'] = this.summary;
    return data;
  }
}