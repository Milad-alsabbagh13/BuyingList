import 'package:buying/module/signinpage.dart';
import 'package:buying/shared/cubit/cubit.dart';
import 'package:buying/shared/cubit/states.dart';
import 'package:buying/shared/shared-prefrences/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'module/buyingpage.dart';
import 'module/homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  var islogin =CacheHelper.getData(key:'isLogIn');
  if(islogin==null){
    islogin=false;
  }
  runApp(MyApp(islogin: islogin,));
}

class MyApp extends StatelessWidget {
  bool islogin;
  MyApp ({required this.islogin});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {return BlocProvider(
    create: (BuildContext context){
      return BuyingCubit()..getListOfBuying();
    },
    child: BlocConsumer<BuyingCubit,BuyingCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        return MaterialApp(
          home:islogin?Buying():Home()
        );
      },
    ),
  );
  }
}
