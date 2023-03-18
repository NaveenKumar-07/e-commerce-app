import 'package:flutter/material.dart';
import 'package:flutter_application_1/exports.dart';
import 'package:flutter_application_1/Screens/Favorites_Page.dart';


class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}):super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 170.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage("https://www.computerhope.com/jargon/g/guest-user.png"),
                          backgroundColor: Colors.yellow,
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('User Sample',style: TextStyle(fontSize:20.0 ,fontWeight: FontWeight.normal)), 
                            Text('Abc@gmail.com',style: TextStyle(fontSize:20.0 ,fontWeight: FontWeight.normal)),
                          ]),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  height: 400,
                  child: ListView(
                    children: [
                      const Divider(
                        height: 2,
                        color: Colors.black,
                        indent: 0.5,
                        thickness: 0.8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
                        },
                        child: const ListTile(
                          leading: Icon(Icons.favorite_rounded, color: Colors.black),
                          title: Text('My Favorites',style: TextStyle(fontSize:20.0 ,fontWeight: FontWeight.normal,color: Colors.black)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => cs1()));
                        },
                        child: const ListTile(
                          leading: Icon(
                            Icons.shopping_bag,
                            color: Colors.black,
                          ),
                          title: Text("Cart",style: TextStyle(fontSize:20.0 ,fontWeight: FontWeight.normal,color: Colors.black))
                        ),
                      ),
                      InkWell(
                        onTap: () => {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                            title: const Text("Contact"),
                            content: const Text("ajsbb"),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                            },
                              child: const Text("Ok"),
                            ),
                          ],
                        ),
                      )
                        },
                        child: const ListTile(
                          leading: Icon(Icons.email, color: Colors.black),
                          title: Text('Contact',style: TextStyle(fontSize:20.0 ,fontWeight: FontWeight.normal,color: Colors.black))
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationIcon: const Icon(Icons.info_rounded),
                            applicationVersion: '1.0.0',
                            applicationLegalese: 'Xyz..',
                          );
                        },
                        child: const ListTile(
                          leading: Icon(Icons.info, color: Colors.black),
                          title: Text('About Us',style: TextStyle(fontSize:20.0 ,fontWeight: FontWeight.normal,color: Colors.black))
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 80.0,
            child: Column(
              children: const [
                Text('E-Commerce App built in Flutter',style: TextStyle(fontSize:25.0 ,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}