import 'package:hive/hive.dart';

part 'screen_model.g.dart';

@HiveType(typeId: 0)
class ScreenModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  const ScreenModel(this.name, this.email);
}