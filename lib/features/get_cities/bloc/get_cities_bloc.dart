import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';

import '../../../models/cities_model.dart';

part 'get_cities_events.dart';
part 'get_cities_state.dart';

class GetCitiesBloc extends Bloc<GetCitiesEvents, GetCitiesStates> {
  GetCitiesBloc() : super(GetCitiesStates()) {
    on<GetCitiesEvent> (_getCityData);
  }

  Future<void> _getCityData(GetCitiesEvent event, Emitter<GetCitiesStates> emit) async {
    emit(GetCitiesLoadingState());
    var response = await DioHelper().getData(endPoint: "cities/1");
    if (response.isSuccess) {
      final model = CitiesDataModel.fromJson(response.response!.data);
      emit(GetCitieSuccessState(cityData: model.cityData));
    } else {
      emit(GetCitiesFailedState());
    }
  }
}
