import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netzstore/pages/categories/categories_list.dart';
import 'package:netzstore/pages/customers/customers_list.dart';
import 'package:netzstore/pages/dashboard/dashboard_page.dart';
import 'package:netzstore/pages/orders/orders_list.dart';
import 'package:netzstore/pages/products/products_list.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class NavBarModel {
  String title;
  IconData icon;
  String color;
  NavBarModel(this.title, this.icon, this.color);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<NavBarModel> _titleList = [
    NavBarModel("navigation_dashboard", Icons.home, "#ffffff"),
    NavBarModel("navigation_categories", Icons.category, "#ffffff"),
    NavBarModel("navigation_products", Icons.image, "#ffffff"),
    NavBarModel("navigation_customers", Icons.group, "#ffffff"),
    NavBarModel("navigation_orders", Icons.shopping_basket, "#ffffff"),
  ];

  final List<Widget> _widgetList = [
      const DashboardPage(),
      const CategoriesList(),
      const ProductsList(),
      const CustomerList(),
      const OrdersList()
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (index) {
         setState(() {
             _index = index;
          });
        },
        items: _titleList.map((NavBarModel model) {
            return BottomNavigationBarItem(              
              icon: Icon(model.icon, color: HexColor(model.color)),
              label: model.title.tr  
            );
          }
        ).toList()
      ),
      body: _widgetList[_index]
    );
  }
}
