import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netzstore/pages/base_page.dart';

class ProductsList extends BasePage {
  const ProductsList({Key? key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends BasePageState<ProductsList> {
  @override
  void initState() {    
    super.initState();
    pageTitle = "title_products";
  }

  @override
  Widget pageUI() {
    return Center(child: Text("title_products".tr,
    style: GoogleFonts.architectsDaughter(
                      textStyle: Theme.of(context).textTheme.headline4,
                      color: Colors.white,
                      fontSize: 33,
                      fontWeight: FontWeight.w600,
                  )
              )
          );
  }
}
