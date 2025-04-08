import 'package:api/controllers/services_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProductsPage extends GetView<ProductsController>{
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (data){
          print("Data : $data");
          return ListView();
        }
      );
  }  
}