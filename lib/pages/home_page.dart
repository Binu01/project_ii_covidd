import 'package:flutter/material.dart';
import '../services/functions.dart';
import 'login_page.dart';

class lastpg extends StatefulWidget {
  const lastpg({super.key});

  @override
  State<lastpg> createState() => _lastpgState();
}

class _lastpgState extends State<lastpg> {



  final SnackBar _bar = SnackBar(content: Text("signed out"),
    duration: Duration(seconds: 3),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: ()async {
            await firebaseServices().signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => loginpg()),
            );
            ScaffoldMessenger.of(context).showSnackBar(_bar);
          },
              child: Text("Sign out")
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit:BoxFit.fill,
                        image: AssetImage("Assets/images/person.jpg"))
                ),
                child: Stack(
                  children: [
                    Positioned(

                      child: Text("AVOID THE SCARE OF CORONA VIRUS", style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20,
                      ),
                      ),
                      bottom: 1,
                      left: 20,
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("Assets/images/cardimg2.jpg")
                        )
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("Assets/images/cardimg3.jpg")
                        )
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Container(
                height: 280,
                width: 340,
                child: Card(
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Avoid the scare of  Corona Virus",
                        style: TextStyle(fontSize: 25),),
                      Container(
                        child: Image.asset("Assets/images/virus.png"),
                        height: 100,
                        width: 200,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white
                          ),
                          onPressed: (){},
                          child: Text("Call"))
                    ],
                  ) ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
