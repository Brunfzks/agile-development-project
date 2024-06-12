import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/config/responsive.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.titleScreen,
    required this.user,
  });

  final String titleScreen;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        if (!Responsive.isMobile(context))
          Text(
            titleScreen,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        // if (!Responsive.isMobile(context))
        //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        // const Expanded(child: SearchField()),
        ProfileCard(
          user: user,
        )
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: ConstParameters.constPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: ConstParameters.constPadding,
        vertical: ConstParameters.constPadding / 2,
      ),
      decoration: BoxDecoration(
        color: ConstColors.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstParameters.constPadding / 2),
              child: Text(user.user.toUpperCase()),
            ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: ConstColors.secondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(ConstParameters.constPadding * 0.75),
            margin: const EdgeInsets.symmetric(
                horizontal: ConstParameters.constPadding / 2),
            decoration: const BoxDecoration(
              color: ConstColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
