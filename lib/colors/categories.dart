import 'dart:ui';

import 'package:equatable/equatable.dart';

class Categories {
  static const accident =
      Category("Accidente de tránsito", Color(0xFFcb1a1a), Color(0xFFfbcdcd));
  static const serviceCut =
      Category("Corte de servicio", Color(0xFFcd5904), Color(0xFFf9ddcb));
  static const protest =
      Category("Manifestaciones", Color(0xFFcda104), Color(0xFFf6ecc9));
  static const transportProblem = Category(
      "Problema en transporte público", Color(0xFF468927), Color(0xFFd7e8d2));
  static const robbery = Category("Robo", Color(0xFF21539d), Color(0xFFd1dded));
  static const noises =
      Category("Ruidos molestos", Color(0xFF9904cd), Color(0xFFf1cbf8));

  static List<Category> getCategories() {
    var list = [
      accident,
      serviceCut,
      protest,
      transportProblem,
      robbery,
      noises
    ];
    return list;
  }

  static Category getCategory(String title) {
    if (title == accident.name) {
      return accident;
    } else if (title == serviceCut.name) {
      return serviceCut;
    } else if (title == protest.name) {
      return protest;
    } else if (title == transportProblem.name) {
      return transportProblem;
    } else if (title == robbery.name) {
      return robbery;
    } else {
      return noises;
    }
  }
}

class Category extends Equatable {
  final String name;
  final Color darkColor;
  final Color lightColor;

  const Category(this.name, this.darkColor, this.lightColor);

  @override
  List<Object?> get props => [name];
}
