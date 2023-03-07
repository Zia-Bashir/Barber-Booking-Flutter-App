import 'package:flutter/Material.dart';
import 'package:get/get.dart';

class SearchState {
  FocusNode contentFocus = FocusNode();
  final searchController = TextEditingController();
  final RxList<Map<String, dynamic>> servicesList =
      RxList<Map<String, dynamic>>([]);

  final searchText = ''.obs;
}
