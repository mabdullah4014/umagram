import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/main.dart';
import 'package:umagram/utils/pref_util.dart';

class MyInAppPurchase {
  static const PAID_SUBSCRIPTION_ID = 'my_non_consumable';

  static void listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
      } else {
        if (purchaseDetails.status == PurchaseStatus.error &&
            purchaseDetails.error.message != null &&
            purchaseDetails.error.message.isNotEmpty) {
          if (callback != null)
            callback.value = (InAppPurchaseItem(mainItem, false, null,
                error: InAppPurchaseError.error
                    .errorMessage(error: purchaseDetails.error.message)));
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            // success
            PreferenceUtils.setBool("item_purchased", true);
            if (callback != null) {
              callback.value =
                  (InAppPurchaseItem(mainItem, true, purchaseDetails));
            }
          } else {
            if (callback != null)
              callback.value = (InAppPurchaseItem(mainItem, false, null,
                  error: InAppPurchaseError.invalidPurchase
                      .errorMessage(error: purchaseDetails.error.message)));
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  static Future<void> purchaseProduct(String productId, NavItem item) async {
    if (await InAppPurchase.instance.isAvailable()) {
      List<String> productIdList = <String>[productId];
      ProductDetailsResponse productDetailResponse = await InAppPurchase
          .instance
          .queryProductDetails(productIdList.toSet());
      if (productDetailResponse.error == null &&
          productDetailResponse.productDetails != null &&
          productDetailResponse.productDetails.isNotEmpty) {
        _buyProduct(productDetailResponse.productDetails[0]);
      }else{
        if (callback != null)
          callback.value = (InAppPurchaseItem(item, false, null,
              error: InAppPurchaseError.error
                  .errorMessage(error: productDetailResponse.error.message)));
      }
    } else {
      if (callback != null)
        callback.value = (InAppPurchaseItem(item, false, null,
            error: InAppPurchaseError.connectionUnavailable.errorMessage()));
    }
  }

  static Future<void> _buyProduct(ProductDetails productDetails) async {
    PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    if (await InAppPurchase.instance.isAvailable()) {
      if (Platform.isAndroid) {
        // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
        // verify the latest status of you your subscription by using server side receipt validation
        // and update the UI accordingly. The subscription purchase status shown
        // inside the app may not be accurate.
        // final oldSubscription =
        //     _getOldSubscription(productDetails, purchases);

        purchaseParam = GooglePlayPurchaseParam(
            productDetails: productDetails,
            applicationUserName: null,
            changeSubscriptionParam: null);
      } else {
        purchaseParam = PurchaseParam(
          productDetails: productDetails,
          applicationUserName: null,
        );
      }
      InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  static Future<bool> _verifyPurchase(PurchaseDetails purchase) {
    return Future<bool>.value(
        purchase.verificationData.serverVerificationData != null &&
            purchase.verificationData.serverVerificationData.isNotEmpty);
  }

  static Map<String, PurchaseDetails> getVerifiedPurchases(
      List<PurchaseDetails> verifiedPurchases) {
    Map<String, PurchaseDetails> map = Map();
    verifiedPurchases.forEach((purchase) {
      if (purchase.pendingCompletePurchase) {
        InAppPurchase.instance.completePurchase(purchase);
      }
      map[purchase.productID] = purchase;
    });
    return map;
  }
}

class InAppPurchaseItem extends ChangeNotifier {
  final NavItem navItem;
  final bool isPurchased;
  final PurchaseDetails purchaseDetails;
  String error;

  InAppPurchaseItem(this.navItem, this.isPurchased, this.purchaseDetails,
      {this.error});

  @override
  String toString() {
    return 'InAppPurchaseItem{navItem: $navItem, isPurchased: $isPurchased, purchaseDetails: $purchaseDetails, error: $error}';
  }
}

enum InAppPurchaseError {
  pending,
  error,
  invalidPurchase,
  errorAfterPurchase,
  pastPurchaseError,
  connectionUnavailable,
}

extension InAppPurchaseErrorExtension on InAppPurchaseError {
  String errorMessage({String error}) {
    switch (this) {
      case InAppPurchaseError.pending:
        return 'Purchase is pending${_appendError(error)}';
      case InAppPurchaseError.error:
        return 'Error has occurred while purchasing${_appendError(error)}';
      case InAppPurchaseError.invalidPurchase:
        return 'Invalid purchase, please contact developer${_appendError(error)}';
      case InAppPurchaseError.pastPurchaseError:
        return 'There is an error in you past purchase for this item${_appendError(error)}';
      case InAppPurchaseError.connectionUnavailable:
        return 'Connection is unavailable right now${_appendError(error)}';
      case InAppPurchaseError.errorAfterPurchase:
        return 'An error has occurred while purchasing${_appendError(error)}';
        break;
      default:
        return 'Error';
        break;
    }
  }

  String _appendError(String error) {
    return ' ${error != null ? '-- $error' : ''}';
  }
}
