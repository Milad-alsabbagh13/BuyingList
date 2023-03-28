import 'package:buying/module/buyingpage.dart';
import 'package:buying/module/homepage.dart';
import 'package:buying/shared/cubit/cubit.dart';
import 'package:buying/shared/local/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/states.dart';
class SignIN extends StatelessWidget {
  SignIN({Key? key}) : super(key: key);
  final formkey=GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller=TextEditingController();
  final accountcontroller=TextEditingController();
  final phonecontroller=TextEditingController();
  BuyingCubit cubit(context)=>BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyingCubit,BuyingCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultFormField(label: 'enter your email', error: 'please enter your email', prefix: Icons.email_outlined, controller: emailcontroller,keyboard: TextInputType.emailAddress),
                defaultFormField(label: 'enter your password', error: 'please enter your password', prefix: Icons.visibility_off, controller: passwordcontroller,issecure: true),
                defaultFormField(label: 'enter your name', error: 'please enter your name', prefix: Icons.account_circle, controller: accountcontroller),
                defaultFormField(label: 'enter your phone number', error: 'please enter your phone number', prefix: Icons.phone_android, controller: phonecontroller,keyboard: TextInputType.number),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blue[400]
                    ),
                    height: 70.0,
                    width: double.infinity,
                    child: MaterialButton(onPressed: (){
                      if(formkey.currentState!.validate()){
                        FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value) {
                          cubit(context).changeLogIn(true);
                          print(value.user!.uid.toString());
                          navigateTo(context, Buying());
                        }).catchError((error){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.red),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(error.toString().substring(error.toString().indexOf(']')+1)),
                                    ))),
                          );
                        })
                        ;
                      }
                    },child: const Text('SignIn',style: TextStyle(fontSize: 18.0,color: Colors.white),),),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
