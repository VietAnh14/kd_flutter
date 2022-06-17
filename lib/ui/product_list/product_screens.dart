import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);
  static const routeName = "/products";

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getSearchView(),
        actions: [Icon(Icons.search)],
      ),
      body: ListView.builder(
        itemBuilder: _buildRow,
        itemCount: 50,
      ),
    );
  }

  Widget _getSearchView() {
    return Container(
      height: double.infinity,
      color: Colors.green,
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.redAccent,
        autofocus: false,
        decoration: InputDecoration(
          prefix: Container(
            color: Colors.redAccent,
              child: Icon(Icons.search_outlined, color: Colors.white,),
          ),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    if (index == 0) {
      return _buildHeader(context);
    } else {
      return _buildItemRow(context, index);
    }
  }

  Widget _buildItemRow(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
