import 'package:YogaAsana/Class/screens/new_classroom/step_1.dart';
import 'package:YogaAsana/Class/screens/new_classroom/step_2.dart';
import 'package:YogaAsana/Class/stores/new_classroom_store.dart';
import 'package:flutter/material.dart';

class NewClassroomScreen extends StatelessWidget {
  static const STEP_1_ROUTE_NAME = 'new_classroom/step_1';
  static const STEP_2_ROUTE_NAME = 'new_classroom/step_2';

  final NewClassroomStore newClassroomStore;

  const NewClassroomScreen({
    Key key,
    @required this.newClassroomStore,
  })  : assert(newClassroomStore != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: STEP_1_ROUTE_NAME,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case STEP_1_ROUTE_NAME:
            builder = (_) => NewClassroomStep1Screen(
                  newClassroomStore: newClassroomStore,
                  onCancel: () => Navigator.pop(context),
                );
            break;

          case STEP_2_ROUTE_NAME:
            builder = (_) => NewClassroomStep2Screen(
                  newClassroomStore: newClassroomStore,
                  onCreationComplete: () => Navigator.pop(context),
                );
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
