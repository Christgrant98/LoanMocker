import 'package:loanMocker/presentation/layout.dart';
import 'package:flutter/material.dart';
import 'package:loanMocker/presentation/widgets/utils/credit_history_content.dart';

import '../widgets/utils/bottom_navigator_menu.dart';

class CreditHistoryPage extends StatelessWidget {
  const CreditHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Layout(
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: SizedBox(
                width: constraints.maxWidth * .9,
                child: const CreditHistoryContent(),
              ),
            ),
          ),
          bottomNavigationBar: const BottomNavigator(),
        );
      },
    );
  }
}
