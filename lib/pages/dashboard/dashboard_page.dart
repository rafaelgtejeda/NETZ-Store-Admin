import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netzstore/pages/base_page.dart';

class DashboardPage extends BasePage {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends BasePageState<DashboardPage> {
  @override
  void initState() {
    super.initState();
    pageTitle = "title_dashboard";
  }

  @override
  Widget pageUI() {
    return Center(child: Text("title_dashboard".tr));
  }
}
