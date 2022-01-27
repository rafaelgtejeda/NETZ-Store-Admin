import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class SearchBarUtils {
  static Widget searchBar(
      BuildContext context,
      String keyName,
      String placeHolder,
      String addButtonLabel,
      Function onSearchTab,
      Function onAddButonTab) {
    String val = "";
    return SizedBox(

      height: 50,

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          
          Expanded(
            flex: 7,
            child: FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.web),
              keyName,
              placeHolder,
              () {},
              () {},
              onChange: (onChangeVal) => {val = onChangeVal},
              showPrefixIcon: false,
              suffixIcon: GestureDetector(
                child: const Icon(Icons.search),
                onTap: () {
                   return onSearchTab(val);
                },
              ),
              borderFocusColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              paddingLeft: 0,
            ),
          ),

          Expanded(
            flex: 3,
            child: FormHelper.submitButton(addButtonLabel.tr, () {
                return onAddButonTab();
              },
              borderRadius: 10,
              width: 100,
              fontSize: 12
            ),
          )
        ],
      ),
    );
  }
}
