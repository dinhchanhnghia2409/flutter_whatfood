class Ai {
  String label;
  String index;
  String confidence;

  Ai({this.label, this.index, this.confidence});

  Ai.fromlist(json) {
    label = json['label'];
    index = json['index'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> tolist() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['index'] = this.index;
    data['confidence'] = this.confidence;
    return data;
  }
}
