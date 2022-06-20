import 'package:flutter/material.dart';
import 'package:flutter_kd/ui/product_detail_vm.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  static const routeName = "/product/detail";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductDetailVM productDetailVM;


  @override
  void initState() {
    super.initState();
    productDetailVM = context.read();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = context.select((ProductDetailVM value) => value.isEditing);
    return Scaffold(
      appBar: AppBar(title: Text("Product details"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: context.select((ProductDetailVM value) => value.product.sku),
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
                onPressed: null,
                child: Text(isEdit ? "Edit" : "Add"),
            )
          ],
        ),
      )
    );
  }
}
