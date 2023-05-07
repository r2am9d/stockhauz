import 'package:isar/isar.dart';

part 'permission.g.dart';

@Collection()
class Permission {
  Id id = Isar.autoIncrement;
  bool isGranted = false;
}
