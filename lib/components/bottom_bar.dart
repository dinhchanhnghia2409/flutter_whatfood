import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Destination {
  const Destination(
    this.icon,
  );
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination(
    Foundation.home,
  ),
  Destination(AntDesign.search1),
  Destination(FontAwesome.plus_square_o),
  Destination(Feather.heart),
  Destination(MaterialIcons.person_outline),
];
