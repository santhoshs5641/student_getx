
import 'package:hive/hive.dart';
import 'package:student_getx/db/db/student_model.dart';

class StudentService {
  late Box<StudentProfile> _studentBox;

  StudentService(Box<StudentProfile> studentBox) {
    _studentBox = studentBox;
  }

  

  Future<void> addStudent(StudentProfile student) async {
    await _studentBox.add(student);
  }

  Future<void> deleteStudent(int studentId) async {
    await _studentBox.delete(studentId);
  }

  StudentProfile? getStudent(int id) {
    return _studentBox.get(id);
  }

  Future<void> updateStudent(StudentProfile student) async {
    await _studentBox.put(student.id, student);
  }

  Future<List<StudentProfile>> getAllStudents() async {
    // Assuming your Hive box contains a list of students
    final List<StudentProfile> students = _studentBox.values.toList();
    return students;
  }

  List<StudentProfile> searchStudents(String query) {
    // Implement your search logic here
    // For simplicity, let's assume you are searching by name
    final List<StudentProfile> allStudents = _studentBox.values.toList();
    return allStudents
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
