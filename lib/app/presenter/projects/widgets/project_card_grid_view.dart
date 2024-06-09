import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/presenter/projects/widgets/card_projects.dart';
import 'package:flutter/material.dart';

class ProjectCardGridView extends StatelessWidget {
  const ProjectCardGridView({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.projects,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final List<ProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: ConstParameters.constPadding,
        mainAxisSpacing: ConstParameters.constPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => CardProjects(project: projects[index]),
    );
  }
}
