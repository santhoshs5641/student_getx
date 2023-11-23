import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:student_getx/db/db/student_model.dart';
import 'package:student_getx/getx_controller/getx_controller.dart';
import 'package:student_getx/ui/home.dart'; // Make sure to import the correct controller

class EditProfileScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final StudentProfile student;
  final Function onDelete;
  final Function onEdit;

  EditProfileScreen({required this.student, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    // Set initial values when the screen is created
    controller.setInitialValues(student);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Add code here to delete the item from the database
              student.delete();
              onDelete();
              Get.back(); // Close the screen after deletion
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: controller.ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextFormField(
                controller: controller.phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextFormField(
                controller: controller.addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Save the updated data using the controller
                  controller.onSave(student, onEdit);
                  Get.off(HomeScreen());
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
