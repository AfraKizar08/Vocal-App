class Track {
  final String id; // Unique identifier for the track
  final String fileName; // Name of the uploaded file
  final String filePath; // Local path of the file
  final String status; // Status of processing (e.g., 'Uploaded', 'Processing', 'Completed')
  final String? vocalsFilePath; // Local path of the extracted vocals
  final DateTime uploadDate; // Date when the track was uploaded

  Track({
    required this.id,
    required this.fileName,
    required this.filePath,
    this.status = 'Uploaded',
    this.vocalsFilePath,
    required this.uploadDate,
  });

  // Factory method to create a new Track instance from a JSON object
  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      fileName: json['fileName'],
      filePath: json['filePath'],
      status: json['status'] ?? 'Uploaded',
      vocalsFilePath: json['vocalsFilePath'],
      uploadDate: DateTime.parse(json['uploadDate']),
    );
  }

  // Method to convert a Track instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'filePath': filePath,
      'status': status,
      'vocalsFilePath': vocalsFilePath,
      'uploadDate': uploadDate.toIso8601String(),
    };
  }
}
