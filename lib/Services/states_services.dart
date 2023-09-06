import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/WorldStatesModel.dart';
import 'Utils/app_urls.dart';

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesData() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception('Error');
    }
  }

}
