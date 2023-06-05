import 'package:flutter/material.dart';

import '../constants/resources/resources.dart';

class LocationListStyle extends StatelessWidget {
  const LocationListStyle(
      {Key? key, required this.location, required this.onTap})
      : super(key: key);

  final String location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return buildListItem();
  }

  buildListItem() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
            onTap: onTap,
            child: Row(children: [
              buildLocationIcon(),
              const SizedBox(width: 15),
              Expanded(
                  child: Text(location,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: R.styles.black14500
                          .merge(const TextStyle(fontWeight: FontWeight.w400))))
            ])));
  }

  buildLocationIcon() {
    return Container(
        decoration: BoxDecoration(
          color: R.colors.lightGrey,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 30,
        width: 30,
        child:
            Icon(Icons.location_on_outlined, color: R.colors.black, size: 18));
  }
}
