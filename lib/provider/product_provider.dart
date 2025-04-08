import 'package:get/get.dart';

class ProductsProvider extends GetConnect {
  Future<List<dynamic>> fetchProducts(String category) async {
    final response = await get(
      "https://fakestoreapi.com/products/category/$category"
    );
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    }
    return [];
  }
}

