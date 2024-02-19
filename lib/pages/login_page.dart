import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/functions.dart';
import 'home_page.dart';

class loginpg extends StatefulWidget {
  const loginpg({super.key});

  @override
  State<loginpg> createState() => _loginpgState();
}

class _loginpgState extends State<loginpg> {

  TextEditingController emailctrl = TextEditingController();
  TextEditingController pswdctrl = TextEditingController();


  //sigin ...................................


  void formSignin() async{
    try{
      final UserCredential  credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  lastpg()),
      );

    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  String email = "";
  String password = "";

  final _formkey = GlobalKey<FormState>();
  final SnackBar _bar = SnackBar(content: Text("Logged in"),
    duration: Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("Assets/images/login image.jpg")
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 170, 0),
                  child: Text("Username/email:",style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    onChanged: (value){
                      email=value;
                    },
                    controller: emailctrl ,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Required";
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                        hintText: "Enter Your Username or Email",
                        suffixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height:10 ,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 210, 0),
                  child: Text("Password:",style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    onChanged: (value){
                      password=value;
                    },
                    controller: pswdctrl,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        suffixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                TextButton(onPressed: (){},
                    child: Text("Forgot Password?")
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      color: Colors.black,
                      height: 2,
                      width: 150,
                    ),
                    Spacer(),
                    Text("Or",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Container(
                      color: Colors.black,
                      height: 2,
                      width: 150,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: IconButton(onPressed: ()async {
                    await firebaseServices().sigInWithGoogle();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => lastpg()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(_bar);
                  },
                      icon: Image.asset("Assets/images/google icon.png")),
                ),
                SizedBox(
                    height: 20
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(onPressed: (){

                    formSignin();

                    if(_formkey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(_bar);
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => lastpg()
                      )
                      );
                      style:
                      ElevatedButton.styleFrom(
                        elevation: 15,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                      child: Text("Login")
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
