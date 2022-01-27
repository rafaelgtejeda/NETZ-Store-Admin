import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:netzstore/pages/settings_pages.dart';
import 'package:netzstore/providers/loader_provider.dart';
import 'package:netzstore/widgets/ProgressHUD.dart';
import 'package:provider/provider.dart';

import '../services/shared_service.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  
  String pageTitle = "";

  @override
  Widget build(BuildContext context) {
    
    return  Consumer<LoaderProvider>(    
      builder: (context, loaderModel, child) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: ProgressHUD(            
            child: pageUI(),
            inAsyncCall: loaderModel.isApiCallProcess,
            opacity: 0.3,
          )
        );
      }
    );
  }

    PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(pageTitle.tr, 
                  style: GoogleFonts.architectsDaughter(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                )
            ),
      elevation: 0,
      automaticallyImplyLeading: true,
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        
        IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () async {
                  Get.to(() => const SettingsPage());
                },
                tooltip: "text_settings".tr,
        ),

        IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await SharedService.logout();
                },
                tooltip: "logout".tr,
        ),
        const SizedBox( width: 10,)
      ],
    );
  }

  Widget pageUI() {
    return const SizedBox.shrink();
  }

  @override
  void dispose() {    
    super.dispose();
  }
}
