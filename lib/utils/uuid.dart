import 'package:uuid/uuid.dart';

String generateUuid() {
  return "${const Uuid().v4()} ${const Uuid().v1()}";
}
