
import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentProfile extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int age;

  @HiveField(3)
  late String phoneNumber;

  @HiveField(4)
  late String address;

  @HiveField(5)
  late String imagePath; // Change this to String

  StudentProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.phoneNumber,
    required this.address,
    required String imagePath, // Change the parameter type to String
  }) : imagePath = imagePath;
}
