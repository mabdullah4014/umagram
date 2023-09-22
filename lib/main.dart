import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/my_in_app_purchase.dart';
import 'package:umagram/utils/pref_util.dart';
import 'package:umagram/utils/route_generator.dart';

import 'generated/l10n.dart';

ValueNotifier<InAppPurchaseItem> callback = new ValueNotifier(null);
NavItem mainItem;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceUtils.init();
  if (defaultTargetPlatform == TargetPlatform.android) {
    // For play billing library 2.0 on Android, it is mandatory to call
    // [enablePendingPurchases](https://developer.android.com/reference/com/android/billingclient/api/BillingClient.Builder.html#enablependingpurchases)
    // as part of initializing the app.
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }

  StreamSubscription<List<PurchaseDetails>> stream;
  stream = InAppPurchase.instance.purchaseStream.listen((purchaseDetailsList) {
    MyInAppPurchase.listenToPurchaseUpdated(purchaseDetailsList);
  }, onError: (error) {
    log(error);
    if (callback != null)
      callback.value = (InAppPurchaseItem(null, false, null,
          error: InAppPurchaseError.errorAfterPurchase
              .errorMessage(error: error)));
  }, onDone: () {
    stream.cancel();
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: RouteGenerator.SPLASH,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [S.delegate],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: HexColor.fromHex(Constants.COLOR_APP_LIGHT_RED),
        ));
  }
}
