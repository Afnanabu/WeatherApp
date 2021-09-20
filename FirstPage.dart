import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_registration_screen/HomeScreen.dart';
import 'package:login_registration_screen/user_model.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedInUser=UserModel();
  @override
  void initState() {
     super.initState();
     FirebaseFirestore.instance
     .collection('users')
     .doc(user!.uid)
     .get()
     .then((value){
       this.loggedInUser=UserModel.fromMap(value.data());
       setState(() {

       });

     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        centerTitle: true,
      ),
      body:Center(child: Padding(padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150,child: Image.asset('Image/logo.png',fit: BoxFit.contain,),
            ),
            Text('Welcome Back',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text('${loggedInUser.firstName} ${loggedInUser.secondName}'),
            Text('${loggedInUser.email}'),
            SizedBox(height: 15,),
            ActionChip(label: Text('Login'), onPressed:()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage())

            ))],
        ),
      ),),
    );
  }
  Future<void>logout(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
  }
}
