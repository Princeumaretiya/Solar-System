import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:provider/provider.dart';

import '../../controller/planet_controller.dart';
import '../../controller/themeController.dart';
import '../../utiles/routes_utiles.dart';
import 'Favorite_screen.dart';

class home_Page extends StatefulWidget {
  const home_Page({super.key});

  @override
  State<home_Page> createState() => _home_PageState();
}

class _home_PageState extends State<home_Page> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController rotationController;
  late Animation<double> rotation;
  late Animation<double> inRotation;
  final GetXSwitchState getXSwitchState = Get.put(GetXSwitchState());

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 20,
      ),
    )..repeat();

    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 20,
      ),
    )..repeat();

    rotation = Tween<double>(
      begin: pi,
      end: (pi / 2.8).toDouble(),
    ).animate(
      CurvedAnimation(
        parent: rotationController,
        curve: Curves.easeInOut,
      ),
    );

    inRotation = Tween<double>(
      begin: 0.0,
      end: (pi / 2).toDouble(),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "       Galaxy Planets",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bgsplashe.jpg"),
                      fit: BoxFit.cover)),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                accountName: Text(
                  "Prince Umaretiya",
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(0.0),
                accountEmail: Text("prince2003@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    "PU",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.arrow_right_sharp,
                size: 25,
                color: Colors.black,
              ),
            ),
            ListTile(
                leading: const Icon(
                  Icons.dark_mode_rounded,
                  color: Colors.black,
                ),
                title: const Text('Dark Mode'),
                trailing: GetBuilder<GetXSwitchState>(
                    builder: (_) => Switch(
                        value: getXSwitchState.isSwitcheded,
                        onChanged: (value) {
                          getXSwitchState.changeSwitchState(value);
                          Get.changeTheme(
                            getXSwitchState.isSwitcheded
                                ? ThemeData.light()
                                : ThemeData.dark(),
                          );
                        }))),
            // ListTile(
            //   leading: Icon(Icons.favorite),
            //   title: Text("Favorite"),
            //   trailing: Icon(Icons.arrow_right_sharp, size: 25),
            // ),
            ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_right_sharp,
                size: 25,
                color: Colors.black,
              ),
              title: const Text(
                'Favorite',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteScreen(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text(
                "Setting",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.arrow_right_sharp,
                size: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<planet_Provider>(builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: s.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://i.pinimg.com/originals/da/2f/4d/da2f4d68c53ce74aab96e956d9037854.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(-70, 70),
                    child: RotationTransition(
                      turns: Tween(
                        begin: pi,
                        end: pi / 2,
                      ).animate(controller),
                      child: Container(
                        height: 170,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/sun.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-70, 70),
                    child: RotationTransition(
                      turns: rotation,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(200, 150),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AllRoutes.infoPage,
                                      arguments: 0);
                                },
                                child: RotationTransition(
                                  turns: inRotation,
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "${provider.allPlanets[2].iconImage}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-70, 70),
                    child: RotationTransition(
                      turns: rotation,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(310, -220),
                              child: RotationTransition(
                                turns: inRotation,
                                child: AnimatedContainer(
                                  height: 120,
                                  width: 120,
                                  duration: const Duration(
                                    minutes: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "${provider.allPlanets[4].iconImage}",
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-70, 70),
                    child: RotationTransition(
                      turns: rotation,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(-10, -320),
                              child: RotationTransition(
                                turns: inRotation,
                                child: AnimatedContainer(
                                  height: 120,
                                  width: 120,
                                  duration: const Duration(
                                    minutes: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "${provider.allPlanets[5].iconImage}",
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-70, 70),
                    child: RotationTransition(
                      turns: rotation,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(10, 300),
                              child: RotationTransition(
                                turns: inRotation,
                                child: AnimatedContainer(
                                  height: 120,
                                  width: 120,
                                  duration: const Duration(
                                    minutes: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "${provider.allPlanets[6].iconImage}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-70, 70),
                    child: RotationTransition(
                      turns: rotation,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(200, -400),
                              child: RotationTransition(
                                turns: inRotation,
                                child: AnimatedContainer(
                                  height: 120,
                                  width: 120,
                                  duration: const Duration(
                                    minutes: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "${provider.allPlanets[6].iconImage}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-70, 70),
                    child: RotationTransition(
                      turns: rotation,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(400, 200),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AllRoutes.infoPage,
                                      arguments: 7);
                                },
                                child: RotationTransition(
                                  turns: inRotation,
                                  child: AnimatedContainer(
                                    height: 120,
                                    width: 120,
                                    duration: const Duration(
                                      minutes: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "${provider.allPlanets[7].iconImage}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 650),
                    child: Container(
                      height: 120,
                      child: Row(
                        children: [
                          Container(
                            height: 400,
                            width: s.width * 1,
                            child: ListView.builder(
                              itemCount: provider.allPlanets.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AllRoutes.infoPage,
                                      arguments: index,
                                    );
                                  },
                                  child: RotationTransition(
                                    turns: inRotation,
                                    child: Hero(
                                      tag: index,
                                      child: Container(
                                        height: 100,
                                        width: 150,
                                        margin: const EdgeInsets.all(00),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "${provider.allPlanets[index].iconImage}",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
