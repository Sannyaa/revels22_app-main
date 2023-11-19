import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';

@JsonSerializable()
class RevelsFile {
  String fileName;
  String type;
  String url;
  String key;
  RevelsFile(
      {required this.fileName,
      required this.type,
      required this.url,
      required this.key});
      factory RevelsFile.fromJson(Map<String, dynamic> json) =>
      _$RevelsFileFromJson(json);
}
