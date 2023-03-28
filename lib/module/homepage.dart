import 'package:buying/module/signinpage.dart';
import 'package:buying/shared/cubit/cubit.dart';
import 'package:buying/shared/shared-prefrences/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/states.dart';
import '../shared/local/components.dart';
import 'buyingpage.dart';
class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
   final formKey = GlobalKey<FormState>();
   BuyingCubit cubit(context)=>BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyingCubit,BuyingCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultFormField(
                  controller: emailcontroller, label: 'Enter your mail', error: 'email Mustn\'t be empty', prefix: Icons.email,
                ),
                defaultFormField(
                  controller: passwordcontroller, label: 'Enter your password', error: 'password Mustn\'t be empty', prefix: Icons.visibility,
                  issecure: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blue[400]
                    ),
                    height: 70.0,
                    width: double.infinity,
                    child: MaterialButton(onPressed: (){
                      if(formKey.currentState!.validate()){
                        FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value) {
                          cubit(context).getListOfBuying();
                          cubit(context).changeLogIn(true);
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
                ),

                TextButton(onPressed: (){
                  navigateTo(context, SignIN());
                }, child: Text('SignIn'))

              ],
            ),
          ),
        );
      },
    );
  }
}
