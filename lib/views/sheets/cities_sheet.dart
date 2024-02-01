import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetable_orders_project/models/cities_model.dart';

import '../../features/get_cities/cubit/get_cities_cubit.dart';

class CitiesSheet extends StatefulWidget {
  const CitiesSheet({super.key});

  @override
  State<CitiesSheet> createState() => _CitiesSheetState();
}

class _CitiesSheetState extends State<CitiesSheet> {
  late GetCitiesCubit cubit;

  @override
  initState() {
    super.initState();
    cubit = BlocProvider.of(context)..getCityData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "اختر مدينتك",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          BlocBuilder<GetCitiesCubit, GetCitiesStates>(
            builder: (context, state) {
              if (state is GetCitiesLoadingState) {
                return const Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else if (state is GetCitieSuccessState) {
                return Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      itemBuilder: (context, index) => _Item(
                        city: state.cityData[index],
                      ),
                      itemCount: state.cityData.length,
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.city,
  }) : super(key: key);
  final CityModel city;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () {
          Navigator.pop(context, city);
        },
        child: Container(
          height: 32,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.5),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(city.name),
          ),
        ),
      ),
    );
  }
}
