import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raabta/Config/strings.dart';
import 'package:raabta/Pages/Homepage/widgets/list_view.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              'assets/icons/app_icon.svg',
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Get.toNamed('/userProfile');
              },
            ),
          ],
          title: Text(
            AppString.appName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          bottom: TabBar(
              controller: tabController,
              unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
              labelStyle: Theme.of(context).textTheme.headlineSmall,
              tabs: [
                Tab(
                  text: 'Chat',
                ),
                Tab(
                  text: 'Groups',
                ),
                Tab(
                  text: 'Calls',
                ),
              ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Get.toNamed('/contactPage');
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TabBarView(controller: tabController, children: [
            ChatList(),
            Center(
              child: Text('Groups'),
            ),
            Center(
              child: Text('Calls'),
            ),
          ]),
        ));
  }
}
