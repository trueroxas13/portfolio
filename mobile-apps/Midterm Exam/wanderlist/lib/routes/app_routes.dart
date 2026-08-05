import 'package:go_router/go_router.dart';
import 'package:wanderlist/screens/destination_details_screen.dart';
import 'package:wanderlist/screens/destinations_list_screen.dart';
import 'package:wanderlist/screens/edit_destination_screen.dart';
import 'package:wanderlist/screens/shell_screen.dart';

class AppRouter {
  static const destinations = (name: 'destinations',path: '/');
  static const editDestination = (name: 'edit',path: '/edit:id');
  static const destinationDetails = (name: 'details',path: '/details:id');

  static final router = GoRouter(
    initialLocation: destinations.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) => ShellScreen(child: child,),
        routes: [
          GoRoute(
            name: destinations.name,
            path: destinations.path,
            builder:(context, state) => const DestinationsListScreen(),
            routes: [
              GoRoute(
                name: destinationDetails.name,
                path: destinationDetails.path,
                builder: (context, state) {
                  String? id = state.pathParameters['id'];
                  return DestinationDetailsScreen(thisId: id!);
                },
              ),
              GoRoute(
                name: editDestination.name,
                path: editDestination.path,
                builder: (context, state) {
                  String? id = state.pathParameters['id'];
                  return EditDestinationScreen(destinationId: id!);
                },
              ),
            ]
          )
        ] 
      )
    ]
    
    );
}
