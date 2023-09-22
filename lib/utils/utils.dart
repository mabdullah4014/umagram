import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/main.dart';
import 'package:umagram/utils/pref_util.dart';

import 'my_in_app_purchase.dart';

class Utils {
  static Future<String> loadFromAsset(String fileName) async {
    return await rootBundle.loadString("assets/cfg/$fileName");
  }

  static showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(S.of(context).loading),
              ],
            ),
          ),
        );
      },
    );
  }

  static void purchaseProduct(BuildContext context, NavItem item,
      {bool fromDrawer = false}) {
    mainItem = item;
    if (PreferenceUtils.getBool("item_purchased", false)) {
      navigateToScreen(context, mainItem, fromDrawer: fromDrawer);
    } else {
      _showPurchaseDialog(context, item, fromDrawer);
    }
  }

  static navigateToScreen(BuildContext context, NavItem item,
      {bool fromDrawer = false}) {
    BlocProvider.of<NavDrawerBloc>(context)
        .add(NavigateTo(NavItemClass(item, null)));
    if (fromDrawer) Navigator.of(context).pop();
  }

  static void _showPurchaseDialog(
      BuildContext context, NavItem item, bool fromDrawer) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(S.of(dialogContext).umagram),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('自分の魅力診断のアプリ内課金'),
                  Text(S.of(dialogContext).in_app_purchase),
                  Text(S.of(dialogContext).t_and_c),
                  Text(S.of(dialogContext).t_and_c_url),
                  Text(S.of(dialogContext).privacy_policy),
                  Text(S.of(dialogContext).privacy_policy_url),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(S.of(dialogContext).purchase),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  MyInAppPurchase.purchaseProduct(
                      MyInAppPurchase.PAID_SUBSCRIPTION_ID, mainItem);
                  callback.addListener(() {
                    if (callback.value.isPurchased) {
                      navigateToScreen(context, mainItem,
                          fromDrawer: fromDrawer);
                    } else {
                      print(callback.value.error);
                    }
                  });
                },
              ),
              TextButton(
                child: Text(S.of(dialogContext).cancel),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        });
  }
}
