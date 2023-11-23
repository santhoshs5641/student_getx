import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/getx_controller/getx_controller.dart';
import 'package:student_getx/ui/home.dart';

class AddScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Editor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () =>controller.pickImage(),
                child: Obx(() {
                  return controller.imagePath.isNotEmpty
                      ? CircleAvatar(
                          radius: 50.0,
                          child: Image.file(File(controller.imagePath.value)),
                        )
                      : CircleAvatar(
                          radius: 50.0,
                          child: Icon(Icons.camera),
                        );
                }),
              ),
              SizedBox(height: 20.0),
              TextField(
                onChanged: (value) => controller.id.value = int.parse(value),
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) => controller.name.value = value,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) => controller.age.value = int.parse(value),
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) => controller.phone.value = value,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                onChanged: (value) => controller.address.value = value,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  controller.addStudent();
                  Get.offAll(() => HomeScreen());
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
