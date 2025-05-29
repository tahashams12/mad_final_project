import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raabta/Controller/contact_contoller.dart';
import 'package:raabta/Pages/ContactPage/Widgets/contact_search.dart';
import 'package:raabta/Pages/ContactPage/Widgets/add_contact_dialog.dart';
import 'package:raabta/pages/ContactPage/Widgets/newContact_tile.dart';
import 'package:raabta/Pages/homepage/widgets/chat_tile.dart';
import 'package:raabta/Config/image.dart';

class Contactpage extends StatelessWidget {
  const Contactpage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactContoller contactContoller = Get.put(ContactContoller());
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Contact"),
        actions: [
          Obx(
            () => IconButton(
                onPressed: () {
                  isSearchEnable.value = !isSearchEnable.value;
                },
                icon: isSearchEnable.value
                    ? Icon(Icons.close)
                    : Icon(Icons.search)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Obx(() => isSearchEnable.value
                ? ContactSearch()
                : SizedBox(
                    height: 10,
                  )),
            SizedBox(height: 10),
            NewcontactTile(
              btnName: "New Contact",
              icon: Icons.person_add,
              ontap: () {
                showDialog(
                  context: context,
                  builder: (context) => AddContactDialog(
                    controller: contactContoller,
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            NewcontactTile(
              btnName: "New Group",
              icon: Icons.group_add,
              ontap: () {},
            ),
            SizedBox(height: 10),
            Row(
              children: [Text("Contacts")],
            ),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children: contactContoller.userList
                    .map((e) => InkWell(
                          onTap: () {
                            Get.toNamed('/chat', arguments: e);
                          },
                          child: ChatTile(
                            imageUrl:
                                e.profile ?? AssetsImage.defaultProfileUrl,
                            name: e.name ?? 'Unknown',
                            message: e.bio ?? "Hello",
                            time: "",
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
