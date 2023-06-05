import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_modules/google_map_module.dart';

import 'global/google_map/google_map_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarIconBrightness: Brightness.dark // dark text for status bar
      ));
  repositoryInit();

  runApp(const GoogleMapModule());
}

void repositoryInit() {
  GoogleMapRepo.init();
}