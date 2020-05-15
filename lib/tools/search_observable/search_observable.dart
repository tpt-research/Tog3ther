import 'package:flutter/cupertino.dart';
import 'package:tog3ther/model/searchcluster/SearchCluster.dart';
import 'package:tog3ther/model/shuvi/Shuvi.dart';
import 'package:tog3ther/services/shuvi/shuvi_request_provider.dart';

class SearchObservable extends ValueNotifier<Shuvi> {
  SearchObservable(Shuvi value, this.searchCluster) : super(value);

  final SearchCluster searchCluster;

  Future<void> search() async {
    var result = await ShuviRequestProvider.get(searchCluster);

    value = result;
    notifyListeners();
  }

  Future<void> retry() async {
    value = null;
    notifyListeners();

    var result = await ShuviRequestProvider.get(searchCluster);

    value = result;
    notifyListeners();
  }

  Future<void> next(Shuvi res) async {
    value = null;
    notifyListeners();

    searchCluster.date = DateTime.parse(searchCluster.date).add(Duration(minutes: 30)).toIso8601String();

    var result = await ShuviRequestProvider.get(searchCluster);

    while (res.result == result.result) {
      searchCluster.date = DateTime.parse(searchCluster.date).add(Duration(minutes: 10)).toIso8601String();
      result = await ShuviRequestProvider.get(searchCluster);
    }

    value = result;
    notifyListeners();
  }

  Future<void> prev(Shuvi res) async {
    value = null;
    notifyListeners();

    searchCluster.date = DateTime.parse(searchCluster.date).subtract(Duration(minutes: 10)).toIso8601String();

    var result = await ShuviRequestProvider.get(searchCluster);

    while (res.result == result.result) {
      searchCluster.date = DateTime.parse(searchCluster.date).subtract(Duration(minutes: 10)).toIso8601String();
      result = await ShuviRequestProvider.get(searchCluster);
    }

    value = result;
    notifyListeners();
  }

  Future<void> now() async {
    value = null;
    notifyListeners();

    searchCluster.date = DateTime.now().toIso8601String();

    var result = await ShuviRequestProvider.get(searchCluster);

    value = result;
    notifyListeners();
  }

}
