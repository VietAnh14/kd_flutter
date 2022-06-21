import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/model/product.dart';
import 'package:flutter_kd/ui/base/base_stateful.dart';
import 'package:flutter_kd/ui/details/product_detail_screen.dart';
import 'package:flutter_kd/ui/products/products_vm.dart';
import 'package:flutter_kd/ui/products/search_appbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);
  static const routeName = "/products";
  static Widget buildScreen(BuildContext context) => ChangeNotifierProvider(
    create: (_) => ProductVM(context.read()),
    child: const ProductListScreen(),
  );

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends BaseStateful<ProductListScreen> {
  var isSearching = false;
  late ProductVM productVM;

  @override
  void initState() {
    productVM = context.read();
    productVM.error.listen(handleError);
    productVM.event.listen(onNewEvent);
  }

  void toAddOrEditProduct(Product? product) async {
    final result = await Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product) as bool?;
    if (result == true) {
      productVM.getProductList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        onAddClick: () => toAddOrEditProduct(null),
      ),
      body: _buildBody(context),
    );
  }

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching;
    });
  }

  Widget _buildBody(BuildContext context) {
    final isLoading = context.select((ProductVM vm) => vm.isLoading);
    if (isLoading) {
      return const Center(child: SpinKitFoldingCube(color: Colors.blueAccent,),);
    } else {
      return ListView.builder(
        itemCount: productVM.products.length + 1,
        itemBuilder: _buildRow,
      );
    }
  }

  Widget _buildRow(BuildContext context, int index) {
    if (index == 0) {
      return _buildHeader(context);
    } else {
      final realIndex = index - 1;
      return _buildItemRow(context, realIndex);
    }
  }

  Widget _buildItemRow(BuildContext context, int index) {
    final product = productVM.products[index];
    return GestureDetector(
      onLongPress: () => productVM.deleteProduct(product.sku),
      onTap: () => toAddOrEditProduct(product),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black54))
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(product.sku),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                decoration: const BoxDecoration(
                    border: Border.symmetric(vertical: BorderSide(color: Colors.black54))
                ),
                child: Text(product.productName),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(product.quantity.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
        border: Border(bottom: BorderSide(color: Colors.black54))
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text("Sku"),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              decoration: const BoxDecoration(
                  border: Border.symmetric(vertical: BorderSide(color: Colors.black54))
              ),
              child: Text("Product name"),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text("Quantity"),
            ),
          ),
        ],
      ),
    );
  }
}
