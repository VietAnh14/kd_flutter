import 'package:flutter/material.dart';
import 'package:flutter_kd/ui/product_list/products_vm.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends AppBar {

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isExpand = false;
  final textEditingController = TextEditingController();

  void toggleExpand() {
    setState(() {
      isExpand = !isExpand;
    });
  }

  void reload() {
    context.read<ProductVM>().getProductList();
  }

  List<Widget> getActions() {
    if (isExpand) {
      return [IconButton(onPressed: toggleExpand, icon: Icon(Icons.close))];
    } else {
      return [
        IconButton(onPressed: toggleExpand, icon: Icon(Icons.search)),
        IconButton(onPressed: reload, icon: Icon(Icons.refresh))
      ];
    }
  }

  Widget _getSearchView() {
    return TextField(
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.redAccent,
      controller: textEditingController,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search, color: Colors.white,),
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isExpand ? _getSearchView() : Text("Products"),
      actions: getActions()
    );
  }
}


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);
  static const routeName = "/products";

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  var isSearching = false;
  late ProductVM productVM;

  @override
  void initState() {
    productVM = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(),
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
    return Container(
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
