import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/db/db/student_model.dart';
import 'package:student_getx/getx_controller/getx_controller.dart';
import 'package:student_getx/ui/edit.dart';


class StudentSearch extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

   final List<StudentProfile> students;
  final Function(List<StudentProfile>) onSearchResultsUpdated;

  StudentSearch({required this.students, required this.onSearchResultsUpdated});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (newQuery) => controller.updateQuery(newQuery),
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              controller.clearQuery();
            },
          ),
        ],
      ),
      body: Obx(() {
        return _buildSearchResults(controller.searchResults);
      }),
    );
  }

  Widget _buildSearchResults(List<StudentProfile> searchResults) {
    if (searchResults.isEmpty) {
      return Center(
        child: Text('No data found'),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        StudentProfile student = searchResults[index];
        return ListTile(
          title: Text(student.name),
          subtitle: Text(student.age.toString()),
          leading: CircleAvatar(
            backgroundImage: FileImage(File(student.imagePath)),
          ),
          onTap: () {
  Get.to(() => EditProfileScreen(
    student: student,
    onDelete: () {
      if (students != null && students.isNotEmpty) {
        controller.onDelete( );
      } else {
        // Handle the case where students is null or empty
        print('No students available.');
      }
    },
    onEdit: controller.onEdit,
  ));
},

        );
      },
    );
  }
}
