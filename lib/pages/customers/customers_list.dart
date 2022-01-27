import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netzstore/pages/base_page.dart';

class CustomerList extends BasePage {
  const CustomerList({Key? key}) : super(key: key);

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends BasePageState<CustomerList> {
  @override
  void initState() {
    super.initState();
    pageTitle = "title_customers";
  }

  @override
  Widget pageUI() {
    return Center(child: Text("title_customers".tr));
  }
}
