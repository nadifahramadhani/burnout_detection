
class DetectionResultModel {
  final Map<String, dynamic> journal;
  final Map<String, dynamic> hasilDeteksi;
  final Map<String, dynamic> lifestyle;

  DetectionResultModel({
    required this.journal,
    required this.hasilDeteksi,
    required this.lifestyle,
  });

  factory DetectionResultModel.fromJson(Map<String, dynamic> json) {
    return DetectionResultModel(
      journal: json['journal'] ?? {},
      hasilDeteksi: json['hasil_deteksi'] ?? {},
      lifestyle: json['lifestyle'] ?? {},
    );
  }
}
