import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netzstore/pages/base_page.dart';

class OrdersList extends BasePage {
  const OrdersList({Key? key}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends BasePageState<OrdersList> {
  @override
  void initState() {
    super.initState();
    pageTitle = "title_orders";
  }

  @override
  Widget pageUI() {
    return Center(child: Text("title_orders".tr));
  }
}
