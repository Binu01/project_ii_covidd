import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/functions.dart';
import 'home_page.dart';
import 'login_page.dart';
class scndpg extends StatefulWidget {

  const scndpg({super.key});

  @override
  State<scndpg> createState() => _scndpgState();
}

class _scndpgState extends State<scndpg> {

  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController pswdctrl = TextEditingController();
  TextEditingController pnhctrl = TextEditingController();


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // add data to firebase.............................

  void _addFirestore()async{
    try{
      await _firestore.collection('user').add({
        'name':namectrl.text,
        'email':emailctrl.text,
        'password': pswdctrl.text,
        'phone': pnhctrl.text,

      }
      );
    }catch(e){
      print("error adding to firestore: $e");
    }
  }

  //submit function

  void Submitform()async{
    _addFirestore();
    VerifyForm();

  }

  // verification email and password

  void VerifyForm() async{

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => loginpg()),
      );



    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }

  String email = "";
  String password = "";


  final SnackBar _bar = SnackBar(content: Text("Logged in"),
    duration: Duration(seconds: 3),
  );
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("Assets/images/second pg img.jpg")
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 190, 0),
                  child: Text("Your Name:",style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: namectrl,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '*Required';
                      }
                      return null;
                    },
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        suffixIcon: Icon(Icons.person)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 190, 0),
                  child: Text("Your Mobile:",style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: pnhctrl,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return '*Required';
                      }
                      return null;
                    },
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        suffixIcon: Icon(Icons.phone)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 195, 0),
                  child: Text("Your Email:",style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: emailctrl,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return '*Required';
                      }
                      return null;
                    },
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      suffixIcon: Icon(Icons.mail),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 200, 0),
                  child: Text("Password:",style: TextStyle(fontSize: 20),),
                ),
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(

                    controller: pswdctrl,
                    validator: (value){
                      if(value== null || value.isEmpty){
                        return '*Required';
                      }
                      return null;
                    },
                    obscureText: true,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        suffixIcon: Icon(Icons.lock)
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      color: Colors.black,
                      height: 2,
                      width: 150,
                    ),
                    Spacer(),
                    Text("Or",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold) ,),
                    Spacer(),
                    Container(
                      color: Colors.black,
                      height: 2,
                      width: 150,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: IconButton(onPressed: () async {
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
                  height: 15,
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(onPressed: () {

                    if (_formkey.currentState!.validate()) {
                      Submitform();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => loginpg()
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
                      child: Text("Create an account")
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
