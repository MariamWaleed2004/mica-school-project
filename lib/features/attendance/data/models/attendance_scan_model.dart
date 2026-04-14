class AttendanceScanModel {
  final String name;
  final String event;
  final String time;

  AttendanceScanModel({
    required this.name,
    required this.event,
    required this.time,
  });

  factory AttendanceScanModel.fromJson(Map data) {
    return AttendanceScanModel(
      name: data['name'] ?? '',
      event: data['event'] ?? '',
      time: data['time'] ?? '',
    );
  }
}