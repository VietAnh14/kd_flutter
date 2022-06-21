import 'package:flutter/material.dart';
import 'package:flutter_kd/ui/products/products_vm.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends AppBar {
  final VoidCallback? onAddClick;
  SearchAppBar({this.onAddClick});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isExpand = false;
  late FocusNode focusNode;
  late TextEditingController textEditingController;


  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
  }


  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    textEditingController.dispose();
  }

  void toggleExpand() {
    setState(() {
      isExpand = !isExpand;
      textEditingController.clear();
      if (isExpand) {
        focusNode.requestFocus();
      } else {
        reload();
      }
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
        IconButton(onPressed: reload, icon: Icon(Icons.refresh)),
        IconButton(onPressed: widget.onAddClick, icon: Icon(Icons.add)),
      ];
    }
  }

  Widget _getSearchView(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Colors.white,
      ),
      onChanged: context.read<ProductVM>().onQueryChange,
      cursorColor: Colors.redAccent,
      controller: textEditingController,
      focusNode: focusNode,
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
        title: isExpand ? _getSearchView(context) : Text("Products"),
        actions: getActions()
    );
  }
}