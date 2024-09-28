import 'dart:async';
import 'package:how_many_texas/cubit/app_cubit.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseService {
  PurchaseService({required this.appCubit});

  late AppCubit appCubit;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  Future<void> initPurchase() async {
    _initPurchaseStream();
    _connectToStoreTest();
    _purchaseProduct(await _loadProducts());
  }

  void _initPurchaseStream() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      print('purchase_service.dart line 18: purchaseStreamError');
    });

    // return purchaseCompleted;
  }

  Future<void> _connectToStoreTest() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      String connectionError = 'Cannot Connect to google play store';
      appCubit.setErrorState(connectionError);

    } else {
      print('Connected to Google Play store');
    }
  }

  void _purchaseProduct(ProductDetails productDetails) {
    final PurchaseParam purchaseParam =
    PurchaseParam(productDetails: productDetails);
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }

  Future<ProductDetails> _loadProducts() async {
    const Set<String> kIds = <String>{'buy_credits', 'test_product'};
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

    return products[1];
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
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    print('_verifyPurchase called');
    return true;
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    appCubit.setErrorState('Purchase error: ${purchaseDetails.error}');
  }

  void _deliverProduct(PurchaseDetails purchaseDetails) async {
    appCubit.buyCredits();

  }

  void _handleError(IAPError iapError) {
    String errorMessage = '_handleError called -> $iapError';
    appCubit.setErrorState(errorMessage);
  }

  void _showPendingUI() {
    appCubit.setLoadingState();
  }
}
