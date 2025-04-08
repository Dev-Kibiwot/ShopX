import 'package:api/controllers/categories_controller.dart';
import 'package:api/controllers/services_Controller.dart';
import 'package:api/themes/theme.dart';
import 'package:api/view/cart.dart';
import 'package:api/view/details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final ProductsController productsController = Get.put(ProductsController());
  final CategoriesController categoriesController = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomeColors.backgroundColor,
        title: const Text("ShopX"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(CupertinoIcons.search),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () {
                
              },
              child: const Icon(
                Icons.favorite_border
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () {
                Get.to(()=> const CartPage());
              },
              child: const Icon(CupertinoIcons.cart),
            ),
          ),      
        ],
      ),      
      body: ListView(
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesController.categories.length,
              itemBuilder: (context, index) {
                final category = categoriesController.categories[index];
                final bool isSelected = productsController.selectedCategory.value == category;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputChip(
                    selected: isSelected,
                    onPressed: () {
                      productsController.fetchProducts(category);
                    },
                    label: Text(
                      category,
                      style: TextStyle(
                        color:CustomeColors.tetiaryColor,
                      ),
                    ),
                  ),
                );
               },
              )           
            ), 
          Expanded(
            child: Center(
              child: productsController.obx(
                (products) => GridView.builder(
                  itemCount: products?.length ?? 0,
                  shrinkWrap: true,
                  physics:const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = products![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context)=> DetailsPage(
                                data: product
                              )
                            )
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomeColors.secondarbackground,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${product["price"]}",
                                      style: TextStyle(
                                        color: CustomeColors.tetiaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        productsController.togglelike();
                                        print(productsController.like.value);
                                      },
                                      child: productsController.like.value? Icon(
                                        Icons.favorite_border,
                                        color: CustomeColors.adColor.withOpacity(0.4),
                                      ):
                                      Icon(
                                        Icons.favorite,
                                        color: CustomeColors.adColor.withOpacity(0.4),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              CachedNetworkImage(
                                imageUrl: product["image"],
                                height: MediaQuery.of(context).size.height * 0.16,
                                width: MediaQuery.of(context).size.height * 0.16,
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.only(left: 3, right: 4),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    product["title"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[600],
                                  ),
                                  Text("${product["rating"]["rate"]}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                onLoading: const CircularProgressIndicator(),
                onError: (error) => Center(child: Text(error!)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
