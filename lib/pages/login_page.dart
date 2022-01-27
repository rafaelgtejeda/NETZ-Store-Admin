import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netzstore/models/login_model.dart';
import 'package:netzstore/pages/home_page.dart';
import 'package:netzstore/services/api_services.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:netzstore/widgets/ProgressHUD.dart' as loading;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> globalFormkey = GlobalKey<FormState>();
  final GlobalKey globalKey = GlobalKey();
  bool isApiCallProcess = false;
  late LoginModel loginModel;

  @override
  void initState() {
    super.initState();
    loginModel = LoginModel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: loading.ProgressHUD(          
          inAsyncCall: isApiCallProcess,
          key: globalKey,
          child: Form(
            key: globalFormkey,
            child: _loginUI(context)),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
                    ]),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(81),
                  bottomRight: Radius.circular(81),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'title_app'.tr,
                    style: GoogleFonts.architectsDaughter(
                      textStyle: Theme.of(context).textTheme.headline4,
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Text(
                  "title_login".tr,
                  style: GoogleFonts.mavenPro(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.grey[700],
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.web),
                "Host",
                "Host URL",               
                (onValidateVal) {

                  if (onValidateVal.isEmpty) {
                    return "text_consumer_hosturl_not_empty".tr;
                  }

                  return null;

                },
                (onSavedVal) {

                  loginModel.host = onSavedVal;

                },
                borderFocusColor: Theme.of(context).primaryColor,
                prefixIconColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                initialValue: "vitautil.com.br",                
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.lock),
                "Key",
                "Consumer Key",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "text_consumer_key_not_empty".tr;
                  }
                  return null;
                },
                (onSavedVal) {
                  loginModel.key = onSavedVal;
                },
                borderFocusColor: Theme.of(context).primaryColor,
                prefixIconColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                initialValue: "ck_5e4d32b0aa3a030dc6411db9449adff199aa16b6", 
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.web),
                "secret",
                "Consumer Secret",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "text_consumer_secret_not_empty".tr;
                  }
                  return null;
                },
                (onSavedval) {
                  loginModel.secret = onSavedval;
                },
                borderFocusColor: Theme.of(context).primaryColor,
                prefixIconColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                initialValue: "cs_afb89bc4ce870c3c51f06e04fcc5e087d0ee645c", 
              )),
          Center(
            child: Text(
              'login_or'.tr,
              style: GoogleFonts.architectsDaughter(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.grey[700],
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Center(
              child: GestureDetector(
            child: const Icon(
              Icons.qr_code, 
              size: 100,              
            ),
            onTap: () async {
             await scanQR();
            },
          )),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "btn_login_title".tr,
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });
                }

                APIService.checkLogin(loginModel).then((response) {
                  if (validateAndSave()) {
                    setState(() {
                      isApiCallProcess = false;
                    });
                  }

                  if (response) {
                    Get.offAll(() => const HomePage());
                  } else {
                    FormHelper.showSimpleAlertDialog(
                        context, "title_app".tr, "text_invalid_details".tr, "text_close".tr, () {
                      setState(() {
                        loginModel.key = "";
                        loginModel.secret = "";
                      });

                      Navigator.of(context).pop();
                    });
                  }
                });
              },
              btnColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> scanQR() async {

    String barcodeScanRes = 'Unknown';

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "text_cancel".tr, true, ScanMode.QR);
    } on PlatformException {

      barcodeScanRes = 'text_failed_to_get_platform_version'.tr;

      FormHelper.showSimpleAlertDialog(
          context, "title_app".tr, "text_failed_to_get_platform_version".tr, "text_close".tr, () {
        setState(() {
          loginModel.key = "";
          loginModel.secret = "";
        });

        Navigator.of(context).pop();
      });
      
    }

    if (!mounted) return;

    setState(() {

      if (barcodeScanRes.isNotEmpty || barcodeScanRes != "-1") {

        loginModel.key = barcodeScanRes.split("|")[0];

        loginModel.secret = barcodeScanRes.split("|")[1];

      } else {

        FormHelper.showSimpleAlertDialog(
          context, "title_app".tr, "text_error_capturing_qrcode".tr, "text_close".tr, () {
        setState(() {
          loginModel.key = "";
          loginModel.secret = "";
        });

        Navigator.of(context).pop();
      });

      }

    });
  }

  bool validateAndSave() {

    final form = globalFormkey.currentState;

    if (form != null && form.validate()) {

      form.save();

      return true;
    }

    return false;
  }

}
