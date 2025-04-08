import 'package:api/controllers/firebase.dart';
import 'package:api/themes/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class DetailsPage extends StatelessWidget {
  final Map data;
   DetailsPage({
    super.key, 
    required this.data     
    }
  );
  final FirebaseOperations firebaseOperations = FirebaseOperations();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: data["image"],
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.height * 0.45,
                  )
                ).animate(
                  effects: [                    
                    const SlideEffect(
                      begin: Offset(-1, 0),
                    ),
                    const MoveEffect(
                      duration: Duration(seconds: 3)
                    ),
                  ]
                ),
                Padding(
                  padding:  const EdgeInsets.only(
                    left: 12,
                    right: 12
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "${data["title"]}",
                          style:const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                       Text(
                        "\$${data["price"]}",
                        style:const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6,),
                Padding(
                  padding:  const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                        size: 20,
                      ),
                      const Text(
                        "4.5"
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Padding(
                  padding:  const EdgeInsets.only(left: 12),
                  child:  Row(
                    children: [
                     const Text(
                        "Color:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(width: 6,),
                      ColorWidget(
                        bgcolor: Colors.blue, 
                        onTap: (){},
                      ),
                      ColorWidget(
                        bgcolor: Colors.red, 
                        onTap: (){},
                      ),
                      ColorWidget(
                        bgcolor: Colors.green, 
                        onTap: (){},
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:  Text(
                    "Discription:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12
                  ),
                  child: SizedBox(
                    child:  Text(
                      "${data["description"]}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      firebaseOperations.addItem(data);
                    },
                    child: Container(
                      height: 50,
                      decoration:const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: const Center(
                        child: Text(
                          "Add to cart",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Positioned(
                child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Card(
                    elevation: 5,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  Color bgcolor;
    void Function()? onTap;
   ColorWidget({
    super.key,
    required this.bgcolor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(      
        elevation: 3,
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: bgcolor,
            borderRadius: BorderRadius.circular(5),                      
          ),
        ),
      ),
    );
  }
}