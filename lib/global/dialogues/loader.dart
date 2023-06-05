import 'package:flutter/material.dart';

import '../constants/resources/resources.dart';

// ignore: must_be_immutable
class ProgressLoader extends StatefulWidget {
  String? msg = "";

  ProgressLoader({this.msg});

  @override
  // ignore: library_private_types_in_public_api
  _ProgressLoaderState createState() => _ProgressLoaderState();
}

class _ProgressLoaderState extends State<ProgressLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Container(
                  height: 75,
                  width: 75,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: const EdgeInsets.all(20),
                  child: CircularProgressIndicator(color: R.colors.kcRed)),
              Text(widget.msg ?? "", textAlign: TextAlign.center)
            ])));
  }
}
