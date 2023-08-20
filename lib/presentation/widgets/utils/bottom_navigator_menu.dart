import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubits/navigation_cubit.dart';
import '../../router/app_router.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

// todo: check how can I separate items in Bottom menu
class _BottomNavigatorState extends State<BottomNavigator> {
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: const Color.fromARGB(255, 84, 40, 241),
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontFamily: 'ProductSans',
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontFamily: 'ProductSans',
      ),
      selectedFontSize: 10,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house_fill),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.horizontal_split_rounded),
          label: 'Historial créditos',
        ),
      ],
      currentIndex: context.watch<NavigationCubit>().state.selectedIndex,
      onTap: (index) {
        if (!_isDisposed) {
          setState(
            () {
              context.read<NavigationCubit>().setSelectedIndex(index);
              switch (index) {
                case 0:
                  Navigator.pushReplacementNamed(
                      context, Routes.creditSimulatorPage);
                  break;

                case 1:
                  Navigator.pushReplacementNamed(context, Routes.testPage);
                  break;
              }
            },
          );
        }
      },
    );
  }
}
