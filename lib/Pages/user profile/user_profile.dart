import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raabta/Controller/auth_controller.dart';
import 'package:raabta/Controller/image_picker.dart';
import 'package:raabta/Controller/profile_controller.dart';
import 'package:raabta/Widget/primary_button.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());

    // Create TextEditingController instances with initial values
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = ''.obs;

    // Update the controllers when profileController.currentUser changes
    void updateTextFields() {
      nameController.text = profileController.currentUser.value.name ?? '';
      emailController.text = profileController.currentUser.value.email ?? '';
      phoneController.text = profileController.currentUser.value.phone ?? '';
      bioController.text = profileController.currentUser.value.bio ?? '';
    }

    // Call updateTextFields() when the widget builds or profileController updates
    profileController.currentUser.listen((_) {
      updateTextFields();
    });

    // Ensure fields are initialized when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateTextFields();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthController().signOutUser();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              // Profile Image Container with Upload Icon
                              Obx(
                                () => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                      width: 200,
                                      height: 200,
                                      child: Center(
                                        child: ClipOval(
                                          child: imagePath.value == ""
                                              ? Icon(
                                                  Icons.person,
                                                  size: 100,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                )
                                              : Image.network(
                                                  imagePath.value,
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    if (isEdit.value)
                                      Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: GestureDetector(
                                          onTap: () async {
                                            imagePath.value =
                                                await imagePickerController
                                                    .pickImage();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            radius: 20,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    'Personal Information',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => TextField(
                                        controller: nameController,
                                        enabled: isEdit.value,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          filled: isEdit.value,
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            'Name',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          hintText: 'Enter your name',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => TextField(
                                        controller: bioController,
                                        enabled: isEdit.value,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          filled: isEdit.value,
                                          prefixIcon: Icon(
                                            Icons.info,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            'Bio',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          hintText: 'Bio',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => TextField(
                                        controller: phoneController,
                                        enabled: false,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          filled: isEdit.value,
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            'Phone',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          hintText: 'Phone',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => TextField(
                                        controller: emailController,
                                        enabled: false,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          filled: isEdit.value,
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            'Email',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          hintText: 'Email',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => isEdit.value
                                        ? PrimaryButton(
                                            btnName: 'Save',
                                            icon: Icons.save,
                                            ontap: () => {
                                              // Trigger the updateProfile method
                                              isEdit.value = false,
                                              profileController.updateProfile(
                                                nameController.text,
                                                bioController.text,
                                                phoneController.text,
                                                emailController.text,
                                              ),
                                            },
                                          )
                                        : PrimaryButton(
                                            btnName: 'Edit',
                                            icon: Icons.edit,
                                            ontap: () => {
                                              isEdit.value = true,
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
