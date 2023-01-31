import 'package:flutter/cupertino.dart';

class TagItemModel {
  String title;
  IconData icon;
  bool isSelection;

  TagItemModel(this.title, this.icon, [this.isSelection = false]);
}
