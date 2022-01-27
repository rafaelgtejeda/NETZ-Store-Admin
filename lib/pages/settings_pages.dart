import 'package:flutter/material.dart';
import 'package:netzstore/models/settings_model.dart';
import 'package:netzstore/pages/base_page.dart';
import 'package:netzstore/services/localization_services.dart';
import 'package:netzstore/utils/formhelper_util.dart';
import 'package:netzstore/utils/login_popup.dart';

class SettingsPage extends BasePage {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends BasePageState<SettingsPage> {

  String lng = "";

  @override
  void initState() {
  
    super.initState();
    pageTitle = "title_settings";
    lng = LocalizationService().getCurrentLang();

  }

  @override
  Widget pageUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButton<String>(
                items: LocalizationService.langs.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: lng,
                underline: Container(color: Colors.transparent),
                isExpanded: false,
                borderRadius: BorderRadius.circular(10),
                onChanged: (newVal) {
                  setState(() {
                    lng = newVal!;
                    LocalizationService().changeLocale(newVal);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FormHelper.inputFieldWidgetWithLabel(
                context,
                const Icon(Icons.lock),
                "token",
                "JWT Token",
                "",
                (onValidateVal) {
                  return null;
                },
                (onSavedVal) {},
                onChange: (val) {},
                suffixIcon: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      LoginPopupDialog().openDialog(context);
                    }),
                borderFocusColor: Theme.of(context).primaryColor,
                prefixIconColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                paddingLeft: 0,
                paddingRight: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
