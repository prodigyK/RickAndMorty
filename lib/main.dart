import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/common/colors.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_cubit/persons_cubit.dart';
import 'package:rick_and_morty/future/presentation/pages/home_screen.dart';
import 'package:rick_and_morty/locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonCubit>(create: (_) => di.serviceLocator<PersonCubit>()..loadPersons()),
        BlocProvider<PersonSearchBlock>(create: (_) => di.serviceLocator<PersonSearchBlock>()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
