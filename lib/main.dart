import 'dart:io';

import 'package:ben_n_liq_app/home/ben_n_liq_home_page.dart';
import 'package:ben_n_liq_app/error/error_page.dart';
import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool permissionError = true;

  if (Platform.isAndroid) {
    PermissionStatus permissionStatus = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permissionStatus != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permissionStatus = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }

    permissionError = permissionStatus == PermissionStatus.denied;
  }

  if (permissionError) {
    runApp(ErrorPermissionPage());
  } else {
    LiquidService liquidService = LiquidService();
//  List<Liquid> liquids = List<Liquid>();

//  liquids = await liquidService.loadVisibleLiquidsDirectory();
//  liquidService.saveLiquids(liquids);
//  liquidService.saveVisibleLiquids(liquids);

    runApp(BenNLiqApp(liquidService));
  }
}

