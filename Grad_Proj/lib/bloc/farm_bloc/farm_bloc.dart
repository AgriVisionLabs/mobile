import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/core/api/api_consumer.dart';
import 'package:grd_proj/core/api/end_points.dart';
import 'package:grd_proj/core/errors/exception.dart';
import 'package:grd_proj/models/farm_model.dart';

part 'farm_event.dart';
part 'farm_state.dart';

//each time you call the bolc it request event and state
class FarmBloc extends Bloc<FarmEvent, FarmState> {
  final ApiConsumer api;
  GlobalKey<FormState> createFarmFormKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController soilType = TextEditingController();
  TextEditingController roleName = TextEditingController();
  FarmModel? farm;
  String? farmId;
  final cacheHelper = CacheHelper();
// final token = cacheHelper.getData(key: 'token');
  
  //default value
  FarmBloc(this.api) : super(FarmInitial(const [])) {
    //define a bloc event
    on<CreateFarmEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {

        final response = await api.post(EndPoints.farmsInfo, data: {
          ApiKey.name: name.text,
          ApiKey.area: area.text,
          ApiKey.location: location.text,
          ApiKey.soilType: int.tryParse(soilType.text),
        });
        //create a var to store the response
        farm = FarmModel.fromJson(response);
        // save part we will need every time we use the app to cache
        farmId=  farm!.farmId;
        print(response);
        emit(FarmInfoSuccess());
      } on ServerException catch (e) {
        emit(FarmFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
    on<AddMember>((event, emit) async {
      try {
        String userId = CacheHelper().getData(key: 'id');
        final response = await api.post(EndPoints.team, data: {
          ApiKey.roleName: roleName.text,},
          queryParameters: {
            ApiKey.farmId:farmId,
            ApiKey.id:userId
          }
          );
          print(response);
          emit(FarmInfoSuccess());
      } catch (e) {
        
      }
    });
  }
}
