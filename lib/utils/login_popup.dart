import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netzstore/models/settings_model.dart';
import 'package:netzstore/utils/formhelper_util.dart';

class LoginPopupDialog {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  openDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context, SettingsModel()),
        );
      },
    );
  }

  Widget dialogContent(BuildContext context, SettingsModel model) {
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0),
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 24,
                ),
                Form(
                    key: globalFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FormHelper.inputFieldWidgetWithLabel(
                          context,
                          const Icon(Icons.verified),
                          "username",
                          "label_input_username".tr,
                          "",
                          (onValidateVal) {
                            if (onValidateVal.isEmpty) {
                              return "text_username_not_empty".tr;
                            }
                            return null;
                          },
                          (onSavedVal) {
                            model.username = onSavedVal;
                          },
                          initialValue: model.username,
                          borderFocusColor: Theme.of(context).primaryColor,
                          prefixIconColor: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          showPrefixIcon: false,
                          borderRadius: 10,
                          paddingLeft: 0,
                          paddingRight: 0,
                        ),
                        FormHelper.inputFieldWidgetWithLabel(
                          context,
                          const Icon(Icons.lock),
                          "password",
                          "label_input_password".tr,
                          "",
                          (onValidateVal) {
                            if (onValidateVal.isEmpty) {
                              return "text_password_not_empty".tr;
                            }
                            return null;
                          },
                          (onSavedVal) {
                            model.password = onSavedVal;
                          },
                          initialValue: model.password,
                          borderFocusColor: Theme.of(context).primaryColor,
                          prefixIconColor: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          showPrefixIcon: false,
                          borderRadius: 10,
                          paddingLeft: 0,
                          paddingRight: 0,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FormHelper.submitButton("text_login".tr, (onTap) {}),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop;
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
        ]));
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;

    if (form != null && form.validate()) {
      form.save();

      return true;
    }

    return false;
  }
  
}
