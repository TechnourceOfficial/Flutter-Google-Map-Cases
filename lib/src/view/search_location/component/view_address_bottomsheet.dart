import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/resources/resources.dart';

class ViewAddressBottomSheet extends StatelessWidget {
  final String name,
      address,
      latitude,
      longitude,
      subLocality,
      locality,
      subAdministrativeArea,
      postalCode,
      administrativeArea;

  const ViewAddressBottomSheet(
      {Key? key,
      required this.name,
      required this.subLocality,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.locality,
      required this.subAdministrativeArea,
      required this.postalCode,
      required this.administrativeArea})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(children: [
          GestureDetector(
              onVerticalDragUpdate: (details) {
                int sensitivity = 8;
                if (details.delta.dy > sensitivity) {
                  // Down Swipe
                  Get.back();
                } else if (details.delta.dy < -sensitivity) {
                  // Up Swipe
                }
              },
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                      width: Get.width * 0.9,
                      height: 30,
                      child: Column(children: [
                        Container(
                            height: 5,
                            width: 70,
                            decoration: BoxDecoration(
                                color: R.colors.lightGrey,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const SizedBox())
                      ])))),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitleText(title: R.strings.ksAddress),
                      const SizedBox(width: 5),
                      buildText(name: address)
                    ]),
                const SizedBox(height: 5),
                Row(children: [
                  buildTitleText(title: R.strings.latitude),
                  buildText(name: latitude)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  buildTitleText(title: R.strings.longitude),
                  buildText(name: longitude)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  buildTitleText(title: R.strings.ksName),
                  buildText(name: name)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  buildTitleText(title: R.strings.ksSubLocality),
                  const SizedBox(width: 5),
                  buildText(name: subLocality)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  buildTitleText(title: R.strings.ksCity),
                  const SizedBox(width: 5),
                  buildText(name: locality)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  buildTitleText(title: R.strings.ksPostalCode),
                  const SizedBox(width: 5),
                  buildText(name: postalCode)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  buildTitleText(title: R.strings.ksState),
                  const SizedBox(width: 5),
                  buildText(name: administrativeArea)
                ])
              ])
        ]),
      ],
    );
  }

  buildTitleText({required String title}) {
    return Text(title,
        style: R.styles.black14500
            .merge(const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)));
  }

  buildText({required String name}) {
    return Expanded(
        child: Text(name,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: R.styles.black14500.merge(
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 16))));
  }
}
