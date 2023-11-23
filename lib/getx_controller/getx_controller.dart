import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_getx/db/db/functions/services.dart';
import 'package:student_getx/db/db/student_model.dart';

class HomeController extends GetxController {
  late StudentService studentService;

  final RxList<StudentProfile> students = <StudentProfile>[].obs;
  final RxString query = ''.obs;
  final RxList<StudentProfile> searchResults = <StudentProfile>[].obs;
   final RxInt id = RxInt(0);
  final RxString name = RxString('');
  final RxInt age = RxInt(0);
  final RxString phone = RxString('');
  final RxString address = RxString('');
  final RxString imagePath = RxString('');
    

  // Method to pick an image
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;

  @override
  void onInit() {
    super.onInit();
    studentService = StudentService(Hive.box<StudentProfile>('students'));

    // Initialize your text controllers when the controller is initialized
    nameController = TextEditingController();
    ageController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();

    fetchStudents();
  }

  @override
  void onClose() {
    // Close your text controllers when the controller is closed
    nameController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> fetchStudents() async {
    students.value = await studentService.getAllStudents();
  }


  void onStudentDeleted(StudentProfile student) async {
    await studentService.deleteStudent(student.id);
    fetchStudents();
  }

  void onStudentAdded() {
    fetchStudents();
  }

  void clearQuery() {
    query.value = '';
  }

  void updateQuery(String newQuery) {
    query.value = newQuery;
    filterResults();
  }

  void filterResults() {
    searchResults.value = students
        .where((student) => student.name.toLowerCase().contains(query.value.toLowerCase()))
        .toList();
  }

  void onDeleteStudent(
    StudentProfile student,
    List<StudentProfile> students,
    dynamic Function(List<StudentProfile>) onSearchResultsUpdated,
  ) {
    students.remove(student);
    onSearchResultsUpdated(students);
  }

  void onEdit() {
    // Handle the edit operation if needed
  }

  void setInitialValues(StudentProfile student) {
    nameController.text = student.name;
    ageController.text = student.age.toString();
    phoneNumberController.text = student.phoneNumber;
    addressController.text = student.address;
  }

  void onSave(StudentProfile student, Function onEdit) {
    student.name = nameController.text;
    student.age = int.parse(ageController.text);
    student.phoneNumber = phoneNumberController.text;
    student.address = addressController.text;

    onEdit();
  }
    void addStudent() {
    // Assuming you have the required properties like id, name, age, etc.
    StudentProfile newStudent = StudentProfile(
      id: id.value,
      name: name.value,
      age: age.value,
      phoneNumber: phone.value,
      address: address.value,
       imagePath: imagePath.value,
      // ... (other properties)
    );

    studentService.addStudent(newStudent);

    // Clear the input fields after adding a student
    id.value = 0;
    name.value = '';
    age.value = 0;
    phone.value = '';
    address.value = '';

    // Fetch students to update the list
    fetchStudents();
  }

}
