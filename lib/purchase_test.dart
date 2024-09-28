import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseTest extends StatefulWidget {
  const PurchaseTest({super.key});

  @override
  State<PurchaseTest> createState() => _PurchaseTestState();

}

class _PurchaseTestState extends State<PurchaseTest> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _testPurchases();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Button background color
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Increase button size
            textStyle: TextStyle(fontSize: 20), // Increase font size
          ),
          child:  const Text(
            'TEST',
            style: TextStyle(
              fontSize: 40, // Increase font size
              color: Colors.black, // Set font color to white
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    super.initState();

  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

}

Future<void> _testPurchases() async {
  _connectToStoreTest();
  _purchaseProduct(await _loadProducts());
}


Future<void> _connectToStoreTest() async {
  final bool available = await InAppPurchase.instance.isAvailable();
  if (!available) {
    print('Cannot Connect to google play store');
  }
  else {
    print('Connected to Google Play store');
  }
}

Future<ProductDetails> _loadProducts() async {
  const Set<String> kIds = <String>{'buy_credits','test_product'};
  // const Set<String> kIds = <String>{'android.test.purchased'};
  final ProductDetailsResponse response =
  await InAppPurchase.instance.queryProductDetails(kIds);
  if (response.notFoundIDs.isNotEmpty) {
    print('Load products error');
  }
  List<ProductDetails> products = response.productDetails;
  products.forEach((product) {
    print('Products for sale: \n'
        '${product.id} \n'
        '${product.price} \n'
        '${product.title}');

  });

  return products[0];
}

void _purchaseProduct(ProductDetails productDetails) {
  final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
  InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);

}

void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      _showPendingUI();
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        _handleError(purchaseDetails.error!);
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          _deliverProduct(purchaseDetails);
        } else {
          _handleInvalidPurchase(purchaseDetails);
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance
            .completePurchase(purchaseDetails);
      }
    }
  });
  
  
}

Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
  print('_verifyPurchase called');
  return true;
}

void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
  print('_handleInvalidPurchase called');
}

void _deliverProduct(PurchaseDetails purchaseDetails) {
  print('_deliverProduct called');
}

void _handleError(IAPError iapError) {
  print('_handleError called -> $iapError');
}

void _showPendingUI() {
  print('_showPendingUI called');
}


