import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controller/planet_controller.dart';

class Detail_Page extends StatefulWidget {
  const Detail_Page({super.key});

  @override
  State<Detail_Page> createState() => _Detail_PageState();
}

class _Detail_PageState extends State<Detail_Page>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController opacityController;

  late Animation<double> planetRotation;
  late Animation<double> opacity;
  late Animation<double> scale;
  late Animation<AlignmentGeometry> descriptionAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 40,
      ),
    )..repeat();

    opacityController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    )..forward();

    planetRotation = Tween<double>(
      begin: pi,
      end: pi / 4,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    descriptionAnimation = Tween(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).animate(
      CurvedAnimation(
        parent: opacityController,
        curve: const Interval(0.0, 0.4),
      ),
    );

    scale = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: opacityController,
        curve: const Interval(0.4, 0.7),
      ),
    );

    opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: opacityController,
        curve: const Interval(0.7, 1.0),
      ),
    );
  }

  Color primaryTextColor = const Color(0xFF414C6B);
  Color secondaryTextColor = const Color(0xFFE4979E);
  Color contentTextColor = const Color(0xff868686);
  Color navigationColor = const Color(0xFF6751B5);
  Color gradientStartColor = const Color(0xFF0050AC);
  Color gradientEndColor = const Color(0xFF9354B9);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, val) {
          return Consumer<planet_Provider>(builder: (context, provider, _) {
            return Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 32),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 300,
                        ),
                        AnimatedOpacity(
                          opacity: opacity.value,
                          duration: const Duration(seconds: 1),
                          child: Text(
                            "${provider.allPlanets[index].name}",
                            style: TextStyle(
                              fontSize: 55,
                              color: primaryTextColor,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Transform.scale(
                          scale: scale.value,
                          child: Text(
                            "Solar System",
                            style: TextStyle(
                              fontSize: 30,
                              color: primaryTextColor,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 320),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.favorite_border_rounded,
                              size: 30,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black38,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Opacity(
                          opacity: scale.value,
                          child: SizedBox(
                            height: 180,
                            width: s.width * 0.95,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                "${provider.allPlanets[index].description}",
                                style: TextStyle(
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis,
                                  color: contentTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                                maxLines: 60,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(
                          color: Colors.black38,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: 24,
                            overflow: TextOverflow.ellipsis,
                            color: contentTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 40,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) => Card(
                              shadowColor: Colors.black,
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                provider.allPlanets[index].images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(130, -260),
                  child: Hero(
                    tag: index,
                    child: RotationTransition(
                      turns: planetRotation,
                      child: SizedBox(
                        height: s.height * 0.8,
                        width: s.width * 1,
                        child: Image.asset(
                          "${provider.allPlanets[index].iconImage}",
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 32,
                  child: Opacity(
                    opacity: opacity.value,
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 247,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        },
      ),
    );
  }
}
