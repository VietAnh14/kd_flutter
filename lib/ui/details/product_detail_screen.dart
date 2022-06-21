import 'package:flutter/material.dart';
import 'package:flutter_kd/ui/base/base_stateful.dart';
import 'package:flutter_kd/ui/details/product_detail_vm.dart';
import 'package:flutter_kd/ui/event.dart';
import 'package:flutter_kd/utils/DialogHelper.dart';
import 'package:flutter_kd/ui/details/product_detail_event.dart';
import 'package:provider/provider.dart';

import '../../services/remote/model/product.dart';

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

class _ProductDetailScreenState extends BaseStateful<ProductDetailScreen> {
  late ProductDetailVM productDetailVM;
  late DialogHelper dialogHelper;

  @override
  void initState() {
    super.initState();
    dialogHelper = DialogHelper();
    productDetailVM = context.read();
    productDetailVM.event.listen(onNewEvent);
    productDetailVM.error.listen(handleError);
  }

  @override
  void onNewEvent(Event event) async {
    if (event is AddProductSuccessEvent) {
      await DialogHelper.showMessage(context, "Add product success");
      getNav()?.pop(true);
    } else if (event is UpdateProductSuccessEvent) {
      await DialogHelper.showMessage(context, "Update product success");
      getNav()?.pop(true);
    } else {
      super.onNewEvent(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdding = context.select((ProductDetailVM value) => value.isAdding);
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
                    enabled: isAdding,
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
                onPressed: isValid ? productDetailVM.onActionClick : null,
                child: Text(isAdding ? "Add" : "Edit"),
            )
          ],
        ),
      )
    );
  }
}
