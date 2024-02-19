import 'package:flutter/material.dart';
import 'package:project_ii/pages/signup_page.dart';
class firstpg extends StatefulWidget {
  const firstpg({super.key});

  @override
  State<firstpg> createState() => _firstpgState();
}

class _firstpgState extends State<firstpg> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Image.asset("Assets/images/front pg img.jpg"),
              Text("Ready to Feast?",style: TextStyle(fontSize: 30,color: Colors.red,fontWeight:FontWeight.bold),),
              Text("Let's Begin!",style: TextStyle(fontSize: 30,color: Colors.red,fontWeight:FontWeight.bold),),
              SizedBox(
                height: 170,
              ),
              Container(
                height: 40,
                width: 300,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.red,
                        foregroundColor: Colors.white
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>scndpg()
                      )
                      );
                    },
                    child: Text("Get Started",style: TextStyle(fontSize: 20,),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
