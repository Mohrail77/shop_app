class CategoriesModel {
  bool status;
  CategoriesDateModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDateModel.fromJson(json['data']);
  }
}

class CategoriesDateModel {
  int currentpage;
  List<DataModel> data = [];

  CategoriesDateModel.fromJson(Map<String, dynamic> json) {
    currentpage = json['current_page'];
    json['data'].forEach((elemet) {
      data.add(DataModel.fromJson(elemet));
    });
  }
}

class DataModel {
  int id;
  String name;
  String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
