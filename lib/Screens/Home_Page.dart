import 'package:dio/dio.dart';
import 'package:flutter_application_1/exports.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = "HomePage";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.orangeAccent,
          title:const Center(child: Text("Shopzee",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,),)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>  cs1()));
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black87,
                ))
          ],
        ),
        drawer: const DrawerMenu(),
          body: FutureBuilder<List<Products>>(
            future: AllProductsService().getAllProducts(),
            builder: ((context, snapshot) {
              if(snapshot.hasData)
              {
                List<Products> data=snapshot.data! ; 
                
                return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    return  CardView(products: data[index],);
                  }));
              }
              else
              {
                return const Center(child:  CircularProgressIndicator(),);
              }
            }),
          )),
    );
  }
}


class AllProductsService
{
  final Dio _dio = new Dio() ; 

  Future <List<Products>> getAllProducts() async
  {

      Response? response =  await _dio.get("https://fakestoreapi.com/products");
         List<dynamic> data = response.data;
         //print(response);
      List<Products> productsList=[];
      for (int i=0 ; i<data.length ; i++ )
      {
        productsList.add(
          Products.fromJson(data[i]),

        );

      }
    return productsList ; 
    
  }

}