

import 'package:buying/shared/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared-prefrences/cache_helper.dart';

class BuyingCubit extends Cubit<BuyingCubitStates> {
  BuyingCubit() :super(BuyingCubitInitialState());

  static BuyingCubit get(context) => BlocProvider.of(context);
  List<String> thingstobuy = [];

  Future getListOfBuying() async {
    thingstobuy = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        "buying2").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      thingstobuy.add(a.id);
      // print(a.id);
    }
    emit(GetBuyingListState());
  }

  Future addThingsToBuy(String thing) async {
    await FirebaseFirestore.instance.collection("buying2").doc(thing).set({});
    emit(AddThingsToBuyState());
    getListOfBuying();
  }

  Future deleteThing(String thingname) async {
    await FirebaseFirestore.instance.collection("buying2")
        .doc(thingname)
        .delete();
    emit(DeleteThingFromListState());
    getListOfBuying();
  }

  void changeLogIn(bool login) {
    CacheHelper.putData(key: 'isLogIn', value: login).then((value) {
      emit(LogINState());
    });
  }
}