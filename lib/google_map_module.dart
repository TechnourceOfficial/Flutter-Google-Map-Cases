import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/src/routes/app_pages.dart';
import 'package:google_map_modules/src/view/home/view/home_view.dart';

import 'global/utils/config.dart';

class GoogleMapModule extends StatelessWidget {
  const GoogleMapModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: Config.appName,
        enableLog: true,
        textDirection: TextDirection.ltr,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light),
        home: Scaffold(body: HomeView()),
        getPages: AppPages.routes);
  }
}
