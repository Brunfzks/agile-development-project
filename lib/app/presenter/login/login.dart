import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/config/const_text.dart';
import 'package:agile_development_project/app/config/responsive.dart';
import 'package:agile_development_project/app/presenter/login/cubit/login_cubit.dart';
import 'package:agile_development_project/app/presenter/login/cubit/login_state.dart';
import 'package:agile_development_project/app/presenter/main/cubit/main_cubit.dart';
import 'package:agile_development_project/app/presenter/main/main_screen.dart';
import 'package:agile_development_project/app/presenter/widgets/button_widget.dart';
import 'package:agile_development_project/app/presenter/widgets/field_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeyRegistration = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.completed) {
          context.read<MainCubit>().getUser(state.user);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
        if (state.status == LoginStatus.loading) {
          return Scaffold(
            body: Center(
              child: LottieBuilder.asset('assets/lottie/loading.json'),
            ),
          );
        }
        if (state.screen == LoginScreen.registration) {
          return registrationScreen(context, width, height);
        }
        return loginScreen(context, width, height);
      }),
    );
  }

  Scaffold registrationScreen(
      BuildContext context, double width, double height) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: Responsive.isMobile(context) ? width : (width / 2),
              child: Column(
                children: [
                  Responsive.isMobile(context)
                      ? Container(
                          height: height / 4,
                          decoration: BoxDecoration(
                              color: ConstColors.secondaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(width / 2),
                                  bottomRight: Radius.circular(width / 2))),
                          child: alreadySection(context),
                        )
                      : Container(),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      'REGISTRAR',
                      textAlign: TextAlign.center,
                      style: ConstText.welcomeTextNegative,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKeyRegistration,
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          FormFieldWidget(
                            hintText: 'User',
                            icon: const Icon(
                              Icons.person,
                              color: ConstColors.secondaryColor,
                            ),
                            controller: userController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Por Favor, entre com o Usuario!';
                              }
                              return '';
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          FormFieldWidget(
                            hintText: 'Email',
                            icon: const Icon(
                              Icons.email,
                              color: ConstColors.secondaryColor,
                            ),
                            controller: emailController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Por Favor, entre com o Email!';
                              }
                              if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(text)) {
                                return 'Por Favor! Entre com um email Válido ';
                              }
                              return '';
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          FormFieldWidget(
                            isPassword: true,
                            hintText: 'Password',
                            icon: const Icon(
                              Icons.password,
                              color: ConstColors.secondaryColor,
                            ),
                            controller: passwordController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Por Favor, entre com a Senha!';
                              }
                              return '';
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ButtonForm(
                            onPressed: () {
                              if (!_formKeyRegistration.currentState!
                                  .validate()) {
                                context.read<LoginCubit>().registration(
                                      emailController.text,
                                      passwordController.text,
                                      userController.text,
                                    );
                              }
                            },
                            heigth: 50,
                            width: 200,
                            text: Text(
                              'Registrar',
                              style: ConstText.h1,
                            ),
                            color: ConstColors.secondaryColor,
                            borderColor: ConstColors.complementaryColor,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Error(),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Responsive.isMobile(context)
                ? Container()
                : Container(
                    decoration: BoxDecoration(
                        color: ConstColors.secondaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(width / 3))),
                    padding: const EdgeInsets.all(ConstParameters.constPadding),
                    width: width / 2,
                    child: Column(
                      children: [
                        alreadySection(context),
                        SizedBox(
                          height: 300,
                          child: LottieBuilder.asset(
                              'assets/lottie/registration_animation.json'),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Scaffold loginScreen(BuildContext context, double width, double height) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            Responsive.isMobile(context)
                ? Container()
                : Container(
                    decoration: BoxDecoration(
                        color: ConstColors.secondaryColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(width / 3))),
                    padding: const EdgeInsets.all(ConstParameters.constPadding),
                    width: width / 2,
                    child: Column(
                      children: [
                        newHereSection(context),
                        SizedBox(
                          height: 300,
                          child: LottieBuilder.asset(
                              'assets/lottie/registration_animation.json'),
                        )
                      ],
                    ),
                  ),
            SizedBox(
              width: Responsive.isMobile(context) ? width : (width / 2),
              child: Column(
                children: [
                  Responsive.isMobile(context)
                      ? Container(
                          height: height / 4,
                          decoration: BoxDecoration(
                              color: ConstColors.secondaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(width / 2),
                                  bottomRight: Radius.circular(width / 2))),
                          child: newHereSection(context),
                        )
                      : Container(),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      'INICIAR SEÇÃO',
                      textAlign: TextAlign.center,
                      style: ConstText.welcomeTextNegative,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKeyLogin,
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          FormFieldWidget(
                            hintText: 'Email',
                            icon: const Icon(
                              Icons.person,
                              color: ConstColors.secondaryColor,
                            ),
                            controller: emailController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Por Favor, entre com o Email!';
                              }
                              return '';
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          FormFieldWidget(
                            isPassword: true,
                            hintText: 'Password',
                            icon: const Icon(
                              Icons.password,
                              color: ConstColors.secondaryColor,
                            ),
                            controller: passwordController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Por Favor, entre com a Senha!';
                              }
                              return '';
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ButtonForm(
                            onPressed: () {
                              if (!_formKeyLogin.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                      emailController.text,
                                      passwordController.text,
                                    );
                              }
                            },
                            heigth: 50,
                            width: 200,
                            text: Text(
                              'Login',
                              style: ConstText.h1,
                            ),
                            color: ConstColors.secondaryColor,
                            borderColor: ConstColors.complementaryColor,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Error(),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget newHereSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Novo por aqui?',
          style: ConstText.welcomeText,
        ),
        const SizedBox(
          height: ConstParameters.constPadding,
        ),
        !Responsive.isMobile(context)
            ? Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus eu.',
                overflow: TextOverflow.fade,
                style: ConstText.h1,
              )
            : Container(),
        const SizedBox(
          height: ConstParameters.constPadding,
        ),
        ButtonForm(
          onPressed: () {
            context
                .read<LoginCubit>()
                .changeRegistrationScreen(LoginScreen.registration);
          },
          heigth: 50,
          width: 180,
          text: Text(
            'REGISTRATE',
            style: ConstText.h1,
          ),
          color: ConstColors.secondaryColor,
          borderColor: ConstColors.complementaryColor,
        ),
      ],
    );
  }

  Widget alreadySection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Já possui uma conta?',
          style: ConstText.welcomeText,
        ),
        const SizedBox(
          height: ConstParameters.constPadding,
        ),
        !Responsive.isMobile(context)
            ? Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus eu.',
                overflow: TextOverflow.fade,
                style: ConstText.h1,
              )
            : Container(),
        const SizedBox(
          height: ConstParameters.constPadding,
        ),
        ButtonForm(
          onPressed: () {
            context
                .read<LoginCubit>()
                .changeRegistrationScreen(LoginScreen.login);
          },
          heigth: 50,
          width: 180,
          text: Text(
            'LOGIN',
            style: ConstText.h1,
          ),
          color: ConstColors.secondaryColor,
          borderColor: ConstColors.complementaryColor,
        ),
      ],
    );
  }
}

class Error extends StatelessWidget {
  const Error({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state.status == LoginStatus.error) {
        switch (state.error) {
          case 'USUARIO INVALIDO':
            return Text(
              'Email ou senha incorreto!',
              style: GoogleFonts.roboto(
                color: Colors.red.shade300,
                wordSpacing: 0.5,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          case 'EMPTY LOGIN' || 'EMPTY PASSWORD' || 'EMPTY USER':
            return Text(
              'Por favor, informe todos os campos!',
              style: GoogleFonts.roboto(
                color: Colors.red.shade300,
                wordSpacing: 0.5,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          case 'USUARIO JA CADASTRADO':
            return Text(
              'Este email já está cadastrado, faça login!',
              style: GoogleFonts.roboto(
                color: Colors.red.shade300,
                wordSpacing: 0.5,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          default:
            return Text(
              'Infelizmente não foi possivel identificar a causa do erro',
              style: GoogleFonts.roboto(
                color: Colors.red.shade300,
                wordSpacing: 0.5,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
        }
      }
      return Container();
    });
  }
}
