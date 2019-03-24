import 'dart:async' show Future;
import 'dart:io';
import 'package:ben_n_liq_app/liquid.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class LiquidService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/liquids.json');
  }

  Future<String> _loadALiquidAsset() async {
    return await rootBundle.loadString('assets/liquid.json');
  }

  Future<String> _loadSomeLiquidsAsset() async {
    return await rootBundle.loadString('assets/liquids.json');
  }

  Future<List<Liquid>> loadLiquidsAssets() async {
    print('Begining to load liquids');
    String jsonString = await _loadSomeLiquidsAsset();
    List<dynamic> jsonResponse = json.decode(jsonString);
    List<Liquid> liquids = jsonResponse.map((i) => Liquid.fromJson(i)).toList();
    print('Finish to load liquidsDirectory');
    return liquids;
  }

  Future<List<Liquid>> loadLiquidsDirectory() async {
    print('Begining to load liquidsDirectory');
    File file = await _localFile;
    List<dynamic> jsonResponse = jsonDecode(await file.readAsString());
    List<Liquid> liquids = jsonResponse.map((i) => Liquid.fromJson(i)).toList();
    print('Finish to load liquidsDirectory');
    return liquids;
  }

  Future<Liquid> loadLiquid() async {
    print('Begining to load liquid');
    String jsonString = await _loadALiquidAsset();
    final jsonResponse = json.decode(jsonString);
    Liquid liquid = new Liquid.fromJson(jsonResponse);
    print('Fininsh to load liquid');
    return liquid;
  }

  Future saveLiquids(List<Liquid> liquids) async {
    print('Begining to save liquids');
    String tmp = jsonEncode(liquids);
    final file = await _localFile;
    file.writeAsString(tmp);
    print('Finish to save liquids');
  }
}
