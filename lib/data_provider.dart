import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_data_test/data_model.dart';

class DataProvider extends ChangeNotifier{
  List data = [];
  List<DataModel> dataList = [];

  DataProvider(){
    jsonParsing();
  }

  Future<void> jsonParsing() async {
    String json = await rootBundle.loadString('assets/json_data.dart');
    // dataList =
  }



}