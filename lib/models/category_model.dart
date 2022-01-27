import 'dart:convert';

CategoryModel categoryFromJson(String str) =>
    CategoryModel.fromJson(
      json.decode(str),
    );

List<CategoryModel> categoriesFromJson(dynamic str) => List<CategoryModel>.from(
      (str).map(
        (x) => CategoryModel.fromJson(x),
      ),
    );

class CategoryModel {
  
  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  Image? image;
  int? menuOrder;
  int? count;

  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.menuOrder,
    this.count,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString().replaceAll("&amp", "&");
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'].toString().replaceAll("&amp", "&");
    display = json['display'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    menuOrder = json['menu_order'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['parent'] = this.parent;
    data['description'] = this.description;
    data['display'] = this.display;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['menu_order'] = this.menuOrder;
    data['count'] = this.count;

    return data;
  }
}

class Image {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  Image(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

// class CategoryModel {

//   CategoryModel({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.parent,
//     required this.description,
//     required this.display,
//     required this.image,
//     required this.menuOrder,
//     required this.count,
//   });

//   late final int id;
//   late final String name;
//   late final String slug;
//   late final int parent;
//   late final String description;
//   late final String display;
//   late final Image image;
//   late final int menuOrder;
//   late final int count;

//   CategoryModel.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     parent = json['parent'];
//     description = json['description'];
//     display = json['display'];
//     image = Image.fromJson(json['image']);
//     menuOrder = json['menu_order'];
//     count = json['count'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['slug'] = slug;
//     _data['parent'] = parent;
//     _data['description'] = description;
//     _data['display'] = display;
//     _data['image'] = image.toJson();
//     _data['menu_order'] = menuOrder;
//     _data['count'] = count;

//     return _data;
//   }
// }

// class Image {
//   Image({
//     required this.id,
//     required this.dateCreated,
//     required this.dateCreatedGmt,
//     required this.dateModified,
//     required this.dateModifiedGmt,
//     required this.src,
//     required this.name,
//     required this.alt,
//   });
//   late final int id;
//   late final String dateCreated;
//   late final String dateCreatedGmt;
//   late final String dateModified;
//   late final String dateModifiedGmt;
//   late final String src;
//   late final String name;
//   late final String alt;
  
//   Image.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     dateCreated = json['date_created'];
//     dateCreatedGmt = json['date_created_gmt'];
//     dateModified = json['date_modified'];
//     dateModifiedGmt = json['date_modified_gmt'];
//     src = json['src'];
//     name = json['name'];
//     alt = json['alt'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['date_created'] = dateCreated;
//     _data['date_created_gmt'] = dateCreatedGmt;
//     _data['date_modified'] = dateModified;
//     _data['date_modified_gmt'] = dateModifiedGmt;
//     _data['src'] = src;
//     _data['name'] = name;
//     _data['alt'] = alt;
//     return _data;
//   }
// }


// class CategoryModel {
//   int? id;
//   String? name;
//   String? description;
//   String? image;

//   CategoryModel({this.id, this.name, this.description, this.image});

//   CategoryModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     image = json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     data['name'] = name;
//     data['description'] = description;
//     data['image'] = image;
//     return data;
//   }
// }
