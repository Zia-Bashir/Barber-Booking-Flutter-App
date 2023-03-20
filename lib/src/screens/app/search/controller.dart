import 'package:get/get.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/screens/app/search/index.dart';

class SearchController extends GetxController {
  final state = SearchState();
  SearchController();
  @override
  void onInit() {
    fetchServicesList();
    state.contentFocus.requestFocus();
    super.onInit();
  }

  @override
  void onClose() {
    state.contentFocus.dispose();
    state.searchController.dispose();
    super.onClose();
  }

  //* ------------------ Fetch Servives List from FireStire and Store in Map ------------------

  fetchServicesList() async {
    try {
      final snapshot = await servicesRF.get();
      final List<Map<String, dynamic>> fetchedItems =
          snapshot.docs.map((doc) => doc.data()).toList();
      state.servicesList.assignAll(fetchedItems);
    } catch (e) {
      // ignore: avoid_print
      print('Error in Fetching Services List ----- ${e.toString()}');
    }
  }

//* ------------------ Search Text Observable ------------------

  void setSearchText(String text) {
    state.searchText.value = text;
  }

  //* ------------------ Get the List according to the title search ------------------

  List<Map<String, dynamic>> get filteredItems {
    if (state.searchText.value.isEmpty) {
      return state.servicesList;
    }
    return state.servicesList
        .where((item) => item['title']
            .toLowerCase()
            .contains(state.searchText.value.toLowerCase()))
        .toList();
  }
}
