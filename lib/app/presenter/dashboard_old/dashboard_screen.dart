import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/config/responsive.dart';
import 'package:flutter/material.dart';

import 'widgets/recent_files.dart';
import 'widgets/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(ConstParameters.constPadding),
        child: Column(
          children: [
            //Header(),
            SizedBox(height: ConstParameters.constPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      //MyFiles(),
                      SizedBox(height: ConstParameters.constPadding),
                      RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: ConstParameters.constPadding),
                      if (Responsive.isMobile(context)) StorageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: ConstParameters.constPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
