import 'package:flutter/material.dart';
import 'package:flutter_application_1/exports.dart';


class CardView extends StatelessWidget {
  const CardView({Key? key, required this.products}):super(key: key);
  final Products products;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              insetPadding: const EdgeInsets.all(15),
              title: 
                  Center(child: Text("${products.title}",style:const TextStyle(color: Colors.black,fontSize: 15,) ,)),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text("${products.description}",style:const TextStyle(color: Colors.grey,fontSize: 16,fontStyle: FontStyle.italic) ,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child:  ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15, 
                                fontStyle: FontStyle.normal),
                            ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                            child: const Text('Close'),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child:  ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15, 
                                fontStyle: FontStyle.normal),
                            ),
                          onPressed: () {
                            //cs1.CartItems()._updateCart(products);
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>  cs1()));
                          },
                            child: const Text('Add to Cart'),
                            ),
                    ),
                      ],
                    ),
                    

                  ],
                ),
              ),
          );
      });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Container(
              decoration:  BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                        blurRadius: 40,
                        color: Colors.grey.withOpacity(.2),
                        spreadRadius: 0,
                        offset: const Offset(10,10) 
                      )
                      ]
            ),
            height: 310,
            width: 220,
            child: Card(
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${products.title?.substring(0,6)}",style:const TextStyle(color: Colors.grey,fontSize: 16) ,),
                            const SizedBox(height: 
                            15,),
                            Image.network(products.image ?? "" ,height:80 , width: 100,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                  
                                 Text(' \$ ${products.price ?? 0.0 }'),
                                const Icon(Icons.favorite_outline)
                              ],
                            )
                  ],
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