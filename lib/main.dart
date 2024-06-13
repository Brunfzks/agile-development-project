import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/domain/repository/status_repository.dart';
import 'package:agile_development_project/app/external/api_go/project_api_go.dart';
import 'package:agile_development_project/app/external/api_go/projectuser_api_go.dart';
import 'package:agile_development_project/app/external/api_go/status_api_go.dart';
import 'package:agile_development_project/app/external/api_go/user_api_go.dart';
import 'package:agile_development_project/app/infra/repositories/project_repository_impl.dart';
import 'package:agile_development_project/app/infra/repositories/projectuser_repository_impl.dart';
import 'package:agile_development_project/app/infra/repositories/status_repository_impl.dart';
import 'package:agile_development_project/app/infra/repositories/user_repository_impl.dart';
import 'package:agile_development_project/app/presenter/dashboard/cubit/dashboard_cubit.dart';
import 'package:agile_development_project/app/presenter/login/cubit/login_cubit.dart';
import 'package:agile_development_project/app/presenter/login/login.dart';
import 'package:agile_development_project/app/presenter/main/cubit/main_cubit.dart';
import 'package:agile_development_project/app/presenter/projects/cubit/project_cubit.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/cubit/alert_message_cubit.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cookie_jar/cookie_jar.dart';

void main() {
  runApp(const MyApp());

  GetIt.instance.registerSingleton<CookieJar>(CookieJar());
  GetIt.instance.registerSingleton<Dio>(Dio());
  GetIt.I<Dio>().interceptors.add(CookieManager(GetIt.I<CookieJar>()));

  GetIt.instance.registerSingleton<UserRepositoryImpl>(
      UserRepositoryImpl(datasource: UserApiGo(dio: GetIt.I<Dio>())));
  GetIt.instance.registerSingleton<ProjectRepositoryImpl>(
      ProjectRepositoryImpl(datasource: ProjectApiGo(dio: GetIt.I<Dio>())));
  GetIt.instance.registerSingleton<StatusRepositoryImpl>(
      StatusRepositoryImpl(datasource: StatusApiGo(dio: GetIt.I<Dio>())));
  GetIt.instance.registerSingleton<ProjectUserRepositoryImpl>(
      ProjectUserRepositoryImpl(
          datasource: ProjectuserApiGo(dio: GetIt.I<Dio>())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<MainCubit>(
          create: (context) => MainCubit(),
        ),
        BlocProvider<ProjectCubit>(
          create: (context) => ProjectCubit(),
        ),
        BlocProvider<AlertMessageCubit>(
          create: (context) => AlertMessageCubit(),
        ),
        BlocProvider<DashboardCubit>(
          create: (context) => DashboardCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Admin Panel',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: ConstColors.bgColor,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white),
            canvasColor: ConstColors.secondaryColor,
          ),
          home: Login()),
    );
  }
}
