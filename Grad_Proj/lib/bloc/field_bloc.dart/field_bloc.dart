// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:grd_proj/cache/cache_helper.dart';
// import 'package:grd_proj/core/api/api_consumer.dart';
// import 'package:grd_proj/core/api/end_points.dart';
// import 'package:grd_proj/core/errors/exception.dart';
// import 'package:grd_proj/models/farm_model.dart';

// part 'field_event.dart';
// part 'field_state.dart';

// //each time you call the bolc it request event and state
// class FieldBloc extends Bloc<FieldEvent, FieldState> {
//   final ApiConsumer api;
//   GlobalKey<FormState> createFarmFormKey = GlobalKey();
//   TextEditingController name = TextEditingController();
//   TextEditingController area = TextEditingController();
//   TextEditingController location = TextEditingController();
//   TextEditingController soilType = TextEditingController();
//   FieldModel? farm;
//   //default value
//   FieldBloc(this.api) : super(FieldInitial(const [])) {
//     //define a bloc event
//     on<CreateFarmEvent>((event, emit) async {
//       // bloc takes stream of event and give stream of states
//       try {

//         final response = await api.post(EndPoints.fieldInfo, data: {
//           ApiKey.name: name.text,
//           ApiKey.area: area.text,
//           ApiKey.location: location.text,
//           ApiKey.soilType: int.tryParse(soilType.text),
//         });
//         //create a var to store the response
//         farm = FarmModel.fromJson(response);
//         // save part we will need every time we use the app to cache
//         CacheHelper().saveData(key: ApiKey.farmId, value: farm!.farmId);
//         print(response);
//         emit(FieldInfoSuccess());
//       } on ServerException catch (e) {
//         emit(FieldInfoFailure(
//             errMessage: e.errorModel.message, errors: e.errorModel.error));
//       }
//     });
//   }
// }
