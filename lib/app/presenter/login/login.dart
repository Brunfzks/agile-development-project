import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/config/const_text.dart';
import 'package:agile_development_project/app/config/responsive.dart';
import 'package:agile_development_project/app/presenter/widgets/button_widget.dart';
import 'package:agile_development_project/app/presenter/widgets/field_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                        NewHereSection(),
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
                          child: NewHereSection(),
                        )
                      : Container(),
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
                    key: _formKey,
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
                            heigth: 50,
                            width: 200,
                            text: Text(
                              'Login',
                              style: ConstText.h1,
                            ),
                            color: ConstColors.secondaryColor,
                            borderColor: ConstColors.complementaryColor,
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

  Widget NewHereSection() {
    return Column(
      children: [
        Text(
          'Novo por aqui?',
          style: ConstText.welcomeText,
        ),
        const SizedBox(
          height: ConstParameters.constPadding,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus eu.',
          overflow: TextOverflow.clip,
          style: ConstText.h1,
        ),
        const SizedBox(
          height: ConstParameters.constPadding,
        ),
        ButtonForm(
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
}
