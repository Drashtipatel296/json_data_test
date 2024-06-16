import 'package:flutter/material.dart';
import 'package:json_data_test/data_model.dart';

class DataProvider extends ChangeNotifier {
  Map data = {};
  DataModel? dataModel;

  void convert(Map data){
    dataModel = DataModel.fromJson(data);
  }
}
