import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/presenter/dashboard/widgets/file_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardProjects extends StatelessWidget {
  const CardProjects({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ConstParameters.constPadding),
      decoration: const BoxDecoration(
        color: ConstColors.secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.all(ConstParameters.constPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFA4CDFF).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  'assets/icons/one_drive.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xFFA4CDFF), BlendMode.srcIn),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                  color: Colors.white54,
                ),
              )
            ],
          ),
          Text(
            project.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const ProgressLine(
            color: Color(0xFFA4CDFF),
            percentage: 10,
          ),
        ],
      ),
    );
  }
}
