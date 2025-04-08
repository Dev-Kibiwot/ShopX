import 'package:api/controllers/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:api/themes/theme.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key,});

  @override
  State<CartPage> createState() => _CartPageState();
}
class _CartPageState extends State<CartPage> {
  final FirebaseOperations firebaseOperations = FirebaseOperations();
  double sum = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomeColors.backgroundColor,
        title: const Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: firebaseOperations.getItem(), 
          builder: (context,snapshot){
            if(snapshot.hasData){
              List itemList = snapshot.data!.docs;
              return  ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = itemList[index];
                  String docID = document.id;
                  Map<String,dynamic> data = document.data() as Map<String,dynamic>; 
                  // final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    var price = data["items"]['price'];
                  // for (var document in documents){
                  //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  // }
                    sum += price;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {});
                  });
                  return  Card(
                    child: Column(
                      children: [
                        Dismissible(
                          key: Key(docID),
                          onDismissed: (direction) {
                            firebaseOperations.deleteitem(data["id"]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                radius: 30,
                                backgroundImage:NetworkImage(data["items"]['image'],
                                )  
                                ),
                                SizedBox(
                                width: MediaQuery.of(context).size.width * .6,
                                child: Text(
                                  data["items"]['title'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Text(
                                "\$${data["items"]['price']}",
                                style: const TextStyle(
                                  fontSize: 16
                                ),
                              ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        
                      ],
                    ),
                  );
                 },
                );
              }
              return const Center(
                child: CircularProgressIndicator()
              );
             }
            ),
          ),       
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Text(
              'Total: $sum',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),   
          GestureDetector(
            onTap: () {
              showDialog(
                context: context, 
                builder: (context)=>AlertDialog(
                  title: const Text(
                    "Choose Payment method"
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Paypal",
                                style: TextStyle(
                                  color: CustomeColors.secondarbackground,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .3,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "M-pesa",
                                style: TextStyle(
                                  color: CustomeColors.secondarbackground,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],                    
                  ),
                  actions: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Card(
                          color: CustomeColors.backgroundColor,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Cancel"
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue,
                        blurRadius: 2,
                        offset: Offset(-1, 0),
                      ),
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Check-Out",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
