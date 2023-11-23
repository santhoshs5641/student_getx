import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/db/db/student_model.dart';
import 'package:student_getx/getx_controller/getx_controller.dart';
import 'package:student_getx/ui/add.dart';
import 'package:student_getx/ui/edit.dart';
import 'package:student_getx/ui/search.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.to(() => StudentSearch(
                
  students: controller.students,
  onSearchResultsUpdated: (filteredResults) {
    // Handle the updated search results here
    // You might want to update the UI or perform other actions
  },
));

              // Note: You can refresh the data here if needed
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Obx(
              () => controller.students.isEmpty
                  ? Text('No students available.')
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.students.length,
                        itemBuilder: (context, index) {
                          StudentProfile student = controller.students[index];
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
      controller.onDelete();
      // You may need to update the state or fetch students again if needed
    },
    onEdit: controller.onEdit,
  ));
},

                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
