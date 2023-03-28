import 'package:buying/module/test_screen.dart';
import 'package:buying/shared/cubit/cubit.dart';
import 'package:buying/shared/cubit/states.dart';
import 'package:buying/shared/local/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../shared/local/constances.dart';
import 'homepage.dart';

class Buying extends StatelessWidget {
  Buying({Key? key}) : super(key: key);
  var thingcontroller=TextEditingController();
  final formKey = GlobalKey<FormState>();
BuyingCubit cubit(context) =>BlocProvider.of(context);
@override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyingCubit,BuyingCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.blueGrey,
          body:Column(
            children: [
              Expanded(
                child: ConditionalBuilder(
                  condition:cubit(context).thingstobuy.length>=1,
                  builder:(context)=> Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top:100.0),
                      child: ListView.separated(
                          itemBuilder: (context,index)=>Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 70.0,
                                    width: 70.0,
                                    decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),color: listviewcolor),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(Icons.local_grocery_store_outlined,size: 50.0,color: listviewseparatorcolr,),
                                        IconButton(
                                            onPressed: (){
                                              cubit(context).deleteThing(cubit(context).thingstobuy[index]);
                                            }, icon: Icon(Icons.cancel_outlined,color: canceliconcolor,size: 35,)),
                                      ],
                                    )),
                                Container(width: 4,color: listviewseparatorcolr,child: const SizedBox(height: 70,),),
                                Expanded(
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(borderRadius: const BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),color: listviewcolor),
                                    child: TextButton(child:Text(cubit(context).thingstobuy[index],style: const TextStyle(fontSize: 30.0,color: Colors.white)),
                                      onPressed: () {
                                      navigateTo(context, Test(text: cubit(context).thingstobuy[index]));
                                      },),
                                  ),
                                ),
                              ],
                            ),),
                          separatorBuilder: (context,index)=>Container(),
                          itemCount: cubit(context).thingstobuy.length),
                    ),
                  ),
                  fallback: (context)=>Center(child: Text('there is nothing in the list',style:TextStyle(fontSize: 24.0,color: Colors.white))),
                ),
              ),
              TextButton(onPressed: (){
                cubit(context).changeLogIn(false);
                navigateTo(context, Home());
              }, child: Text('Sign out',style: TextStyle(color: Colors.redAccent,fontSize: 18.0,),))
            ],
          ) ,
          floatingActionButton: FloatingActionButton(
            backgroundColor: listviewseparatorcolr,
            onPressed: (){
              showModalBottomSheet(context: context,isScrollControlled: true,builder: (context)=>StatefulBuilder(
                  builder:(BuildContext context, StateSetter setState) {
                    return Padding(
                      padding:  EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 250,
                        color: Colors.blueGrey,
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                                child: defaultFormField(label: 'add to buying list',
                                    error: 'Enter something to buy',
                                    prefix: Icons.local_grocery_store_outlined,
                                    controller: thingcontroller),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                    width: double.infinity,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue,
                                    ),
                                    child: MaterialButton(onPressed: () {
                                      if (formKey.currentState!.validate()){
                                        cubit(context).addThingsToBuy(thingcontroller.text);
                                        thingcontroller.clear();
                                        Navigator.pop(context);
                                      }
                                    },

                                      child: const Text('Confirm', style: TextStyle(
                                          fontSize: 18.0, color: Colors.white),),)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.local_grocery_store_outlined,color: backgroundcolor,size: 40,),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.add,size: 30,color: Colors.white,),
                )
              ],
            ),),
        );
      },
    );
  }
}
