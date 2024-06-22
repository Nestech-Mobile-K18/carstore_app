import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/src/features/application/bloc/application_bloc.dart';
import 'package:my_app/src/features/application/bloc/application_event.dart';
import 'package:my_app/src/features/application/bloc/application_state.dart';
import 'package:my_app/src/features/data/application/application_model.dart';
import 'package:my_app/src/pages/application/widgets/page_builder.dart';
import 'package:my_app/src/resources/colors.dart';
import 'package:my_app/src/resources/responsive.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBlocs, ApplicationState>(
      builder: (context, state) {
        return Container(
          color: ColorsGlobal.globalWhite,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  PageBuilder(
                    index: state.index,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(44),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorsGlobal.globalWhite),
                            color: ColorsGlobal.textGrey,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorsGlobal.globalWhite.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: BottomNavigationBar(
                            backgroundColor: Colors.white,
                            currentIndex: state.index,
                            onTap: (value) {
                              context
                                  .read<ApplicationBlocs>()
                                  .add(TriggerApplicationEvent(value));
                            },
                            elevation: 0,
                            type: BottomNavigationBarType.fixed,
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            selectedItemColor: ColorsGlobal.globalOrange,
                            unselectedItemColor: ColorsGlobal.globalGrey,
                            items: bottomTabs,
                            iconSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
