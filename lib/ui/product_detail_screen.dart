import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';
import 'package:flutter_kd/ui/DialogHelper.dart';
import 'package:flutter_kd/ui/product_detail_event.dart';
import 'package:flutter_kd/ui/product_detail_vm.dart';
import 'package:provider/provider.dart';

import '../services/remote/model/product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  static const routeName = "/product/detail";
  static Widget buildScreen(BuildContext context, RouteSettings settings) => ChangeNotifierProvider(
    create: (_) {
      final args = settings.arguments as Product?;
      return ProductDetailVM(context.read(), args);
    },
    child: const ProductDetailScreen(),
  );


  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductDetailVM productDetailVM;
  late DialogHelper dialogHelper;

  NavigatorState? getNavigator() {
    if (mounted) {
      return Navigator.of(context);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    dialogHelper = DialogHelper();
    productDetailVM = context.read();
    productDetailVM.event.listen(onNewEvent);
    productDetailVM.error.listen(onError);
  }

  void onError(dynamic err) {
    var message = "Sth went wrong! ${err.runtimeType}";
    if (err is ApiException) {
      message = err.message ?? message;
    }
    DialogHelper.showMessage(context, message);
  }

  void onNewEvent(ProductDetailEvent event) async {
    if (event is AddProductSuccessEvent) {
      await DialogHelper.showMessage(context, "Add product success");
      getNavigator()?.pop();
    } else if (event is EditProductSuccessEvent) {

    } else {
      DialogHelper.showMessage(context, "Unknown event ${event.runtimeType.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = context.select((ProductDetailVM value) => value.isEditing);
    final isValid = context.select((ProductDetailVM value) => !value.isLoading && value.isValid);
    return Scaffold(
      appBar: AppBar(title: Text("Product details"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: context.select((ProductDetailVM value) => value.product.sku),
                    onChanged: productDetailVM.skuChange,
                    decoration: const InputDecoration(
                      labelText: "Sku",
                      hintText: "abc",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    initialValue: context.select((ProductDetailVM value) => value.product.productName),
                    onChanged: productDetailVM.nameChange,
                    decoration: const InputDecoration(
                      labelText: "Product name",
                      hintText: "abc...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: context.select((ProductDetailVM value) => value.product.quantity).toString(),
                    onChanged: productDetailVM.qtyChange,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Qty",
                      hintText: "1, 2",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    initialValue: context.select((ProductDetailVM value) => value.product.price).toString(),
                    onChanged: productDetailVM.priceChange,
                    decoration: const InputDecoration(
                      labelText: "Price",
                      hintText: "abc...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: context.select((ProductDetailVM value) => value.product.unit),
                    onChanged: productDetailVM.unitChange,
                    decoration: const InputDecoration(
                      labelText: "Unit",
                      hintText: "abc",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    initialValue: context.select((ProductDetailVM value) => value.product.status).toString(),
                    onChanged: productDetailVM.statusChange,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Status",
                      hintText: "abc...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: isValid ? productDetailVM.addProduct : null,
                child: Text(isEdit ? "Edit" : "Add"),
            )
          ],
        ),
      )
    );
  }
}
