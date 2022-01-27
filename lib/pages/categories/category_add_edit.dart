import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:netzstore/enum/page_type.dart';
import 'package:netzstore/pages/base_page.dart';
import 'package:netzstore/models/category_model.dart';
import 'package:netzstore/providers/categories_provider.dart';
import 'package:netzstore/providers/loader_provider.dart';
import 'package:netzstore/utils/formhelper_util.dart';
import 'package:provider/provider.dart';

class CategoryAddEditPage extends BasePage {
  final PageType pageType;
  final CategoryModel? model;

  const CategoryAddEditPage({Key? key, required this.pageType, this.model})
      : super(key: key);

  @override
  _CategoryAddEditPageState createState() => _CategoryAddEditPageState();
}

class _CategoryAddEditPageState extends BasePageState<CategoryAddEditPage> {
  GlobalKey<FormState> globalFormkey = GlobalKey<FormState>();

  late CategoryModel categoryModel;

  @override
  void initState() {
    super.initState();
    pageTitle = widget.pageType == PageType.add
        ? "title_add_category"
        : "title_edit_category";

    if (widget.pageType == PageType.edit) {
      categoryModel = widget.model!;
    } else {
      categoryModel = CategoryModel();
    }
  }

  @override
  Widget pageUI() {
    return Form(
      key: globalFormkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormHelper.inputFieldWidgetWithLabel(
                context,
                const Icon(Icons.ac_unit),
                "name",
                "label_input_name".tr,
                "",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "Category Name cantt be empty ";
                  }
                  return null;
                },
                (onSavedVal) {
                  categoryModel.name = onSavedVal;
                },
                initialValue: categoryModel.name,
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
                const Icon(Icons.ac_unit),
                "description",
                "label_input_description".tr,
                "",
                (onValidateVal) {
                  return null;
                },
                (onSavedVal) {
                  categoryModel.description = onSavedVal;
                },
                initialValue: categoryModel.description,
                borderFocusColor: Theme.of(context).primaryColor,
                prefixIconColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                showPrefixIcon: false,
                borderRadius: 10,
                paddingLeft: 0,
                paddingRight: 0,
                isMultiline: true,
                containerHeight: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: FormHelper.submitButton("btn_save".tr, () {

                  if (validateAndSave()) {
                    
                    Provider.of<LoaderProvider>(context, listen: false).setLoadingStatus(true);

                    if (widget.pageType == PageType.add) {

                      Provider.of<CategoriesProvider>(context, listen: false).createCategory(categoryModel, (val) {

                        Provider.of<LoaderProvider>(context, listen: false).setLoadingStatus(false);

                        if (val) {

                          Get.snackbar("title_app".tr, "Caregory Created",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 3)
                          );

                        }

                      });

                    } else {

                      Provider.of<LoaderProvider>(context, listen: false).setLoadingStatus(true);

                      if (widget.pageType == PageType.edit) {

                        Provider.of<CategoriesProvider>(context, listen: false).updateCategory(categoryModel, (val) {

                          Provider.of<LoaderProvider>(context, listen: false).setLoadingStatus(false);

                          if (val) {
                            Get.snackbar("title_app".tr, "Caregory Modified",
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 3));
                          }

                        });
                      }
                    }
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
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
