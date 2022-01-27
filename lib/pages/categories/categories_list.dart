import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netzstore/enum/page_type.dart';
import 'package:netzstore/models/category_model.dart';
import 'package:netzstore/models/sort_model.dart';
import 'package:netzstore/pages/base_page.dart';
import 'package:netzstore/pages/categories/category_add_edit.dart';
import 'package:netzstore/providers/categories_provider.dart';
import 'package:netzstore/providers/searchbar_provider.dart';
import 'package:netzstore/utils/datatable_util.dart';
import 'package:netzstore/utils/searchbar_utils.dart';
import 'package:provider/provider.dart';

import '../../providers/loader_provider.dart';

class CategoriesList extends BasePage {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends BasePageState<CategoriesList> {
  @override
  void initState() {
    super.initState();
    pageTitle = "title_categories";
    var categoryProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    categoryProvider.fetchCategories();
  }

  @override
  Widget pageUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SearchBarUtils.searchBar(
                context, "strCategory", "text_search".tr, "text_add".tr, (val) {
              debugPrint(val);
              SortModel sortModel =
                  Provider.of<SearchBarProvider>(context, listen: false)
                      .sortModel;
              var categoryProvider =
                  Provider.of<CategoriesProvider>(context, listen: false);
              categoryProvider.resetStreams();
              categoryProvider.fetchCategories(
                  sortBy: sortModel.sortColumnName,
                  sortOrder: sortModel.sortAscending! ? "asc" : "desc",
                  strSearch: val);
            }, () {
              Get.to(() => const CategoryAddEditPage(pageType: PageType.add));
            }),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
          categoriesListUI(),
        ],
      ),
    );
  }

  Widget categoriesListUI() {
    return Consumer<CategoriesProvider>(builder: (context, model, child) {
      if (model.categoriesList != null && model.categoriesList.length > 0) {
        return ListUtils.buildDataTable<CategoryModel>(
            context,
            ["datatable_colunm_name".tr, "datatable_colunm_description".tr, ""],
            ["name", "description", ""],
            Provider.of<SearchBarProvider>(context, listen: true)
                .sortModel
                .sortAscending,
            Provider.of<SearchBarProvider>(context, listen: true)
                .sortModel
                .sortColumnIndex,
            model.categoriesList, 
            (CategoryModel? onEditVal) {             
              Get.to(() => CategoryAddEditPage(
                pageType: PageType.edit,
                model: onEditVal,
              ));
            }, (CategoryModel onDeleteVal) {
              debugPrint(onDeleteVal.id.toString());
              debugPrint(onDeleteVal.name.toString());

              Provider.of<LoaderProvider>(context, listen: false).setLoadingStatus(true);

              Provider.of<CategoriesProvider>(context, listen: false).deleteCategory(onDeleteVal, (val) {  

              Provider.of<LoaderProvider>(context, listen: false).setLoadingStatus(false);              

                if (val) {
                  Get.snackbar("app_title".tr, "Category Deleted",
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 3));
                }

              });

            }, onSort: (columnIndex, columnName, ascending) {
          Provider.of<SearchBarProvider>(context, listen: false)
              .setSort(columnIndex, columnName, ascending);
          var categoryProvider =
              Provider.of<CategoriesProvider>(context, listen: false);
          categoryProvider.resetStreams();
          categoryProvider.fetchCategories(
              sortBy: columnName, sortOrder: ascending ? "asc" : "desc");
        },
            headingRowColor: Theme.of(context).primaryColor,
            headingRowHeight: 51,
            headingRowTextColor: Colors.white,
            headingRowIconColor: Colors.white);
      }

      return const Center(child: CircularProgressIndicator());
    });
  }
}
