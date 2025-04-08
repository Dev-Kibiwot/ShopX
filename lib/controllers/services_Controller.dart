import 'package:api/controllers/categories_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:api/provider/product_provider.dart';

class ProductsController extends GetxController with StateMixin<List<dynamic>> {
  RxString selectedCategory = ''.obs;
  final CategoriesController categoriesController = Get.put(CategoriesController());
  RxBool like = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchProducts(categoriesController.categories[0]); 
  }

  void fetchProducts(String category) {
    selectedCategory.value = category;
    ProductsProvider().fetchProducts(category).then((resp) {
      change(resp, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
  
  void togglelike(){
    like.value = !like.value;
  }
}



