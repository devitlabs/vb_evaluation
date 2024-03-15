import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:vb_performance/widgets/custom_text.dart';
import '../pages/accueil_page/accueil_page.dart';
import '../pages/admin_page/admin_page.dart';
import '../pages/admin_page/admin_redirection_page.dart';
import '../pages/evaluations_page/evaluation_details_page/evaluation_details_page.dart';
import '../pages/evaluations_page/evaluation_details_page/evaluation_finale/evaluation_finale.dart';
import '../pages/evaluations_page/evaluation_details_page/evaluation_mi_parcours/evaluation_mi_parcours.dart';
import '../pages/evaluations_page/evaluation_details_page/objectifs_evalue_page/objectifs_evalue_page.dart';
import '../pages/evaluations_page/evaluation_details_page/performances_evalue/performances_evalue.dart';
import '../pages/evaluations_page/evaluations_page.dart';
import '../pages/evaluations_page/exercices_page/exercices_page.dart';
import '../pages/inscription_page/inscription_page.dart';
import '../pages/inscription_page/redirection_inscription_page.dart';
import '../pages/login_page/login_page.dart';
import '../pages/main_page/main_page.dart';
import '../pages/mateam_page/exercice_team_page/exercice_team_page.dart';
import '../pages/mateam_page/mateam_page.dart';
import '../pages/mateam_page/section_team_exercice.dart';
import '../pages/mateam_page/team_collaborateur_page/team_collaborateur_page.dart';
import '../pages/profil_page/profil_page.dart';
import '../pages/route_page/route_page.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
final _nestedMenuEvaluationNavigatorKey = GlobalKey<NavigatorState>();

final _nestedEvaluationNavigatorKey = GlobalKey<NavigatorState>();
final _nestedEvalueEspaceNavigatorKey = GlobalKey<NavigatorState>();

final _nestedMenuMaTeamNavigatorKey = GlobalKey<NavigatorState>();
final _nestedMaTeamNavigatorKey = GlobalKey<NavigatorState>();

class RouteClass {
  static final router = GoRouter(
      navigatorKey: _navigatorKey,
      initialLocation: '/espace/accueil',
      errorBuilder: (BuildContext context, GoRouterState state){
        return const RoutePage();
      },
      routes: [
        GoRoute(
          path: '/connexion',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/inscription',
          builder: (BuildContext context, GoRouterState state) {
            final token = state.uri.queryParameters["token"];
            return InscriptionPage(token: token);
          },
        ),
        /*GoRoute(
          path: '/',
          builder: (context, state) => const LoginPage(),
        ),*/
        ShellRoute(
            navigatorKey: _nestedMenuEvaluationNavigatorKey,
            builder: (context, state, child) => MainPage(child: child),
            routes: [
              GoRoute(
                path: '/espace/accueil',//id: state.pathParameters['userId']
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const AccueilPage(),
                ),
              ),
              ShellRoute(
                  navigatorKey: _nestedEvaluationNavigatorKey,
                  builder: (context, state, child) => EvaluationsPage(child: child),
                  routes: [
                    GoRoute(
                        path: '/espace/mes-evaluations',
                        pageBuilder: (context, state) => NoTransitionPage<void>(
                          key: state.pageKey,
                          child: const ExercicesPage(),
                        ),
                        routes: [
                          ShellRoute(
                              navigatorKey: _nestedEvalueEspaceNavigatorKey,
                              builder: (context, state, child) => EvaluationDetailsPage(child: child),
                              routes: [
                                GoRoute(
                                  path: 'objectifs',//id: state.pathParameters['userId']
                                  pageBuilder: (context, state) => NoTransitionPage<void>(
                                    key: state.pageKey,
                                    child: const ObjectifsEvaluePage(),
                                  ),
                                ),
                                GoRoute(
                                  path: 'evaluation-mi-parcours',//id: state.pathParameters['userId']
                                  builder: (context, state) => const Text("evaluation-mi-parcours"),
                                  pageBuilder: (context, state) => NoTransitionPage<void>(
                                    key: state.pageKey,
                                    child: EvaluationMiParcours(),
                                  ),
                                ),
                                GoRoute(
                                  path: 'evaluation-finale',//id: state.pathParameters['userId']
                                  pageBuilder: (context, state) => NoTransitionPage<void>(
                                    key: state.pageKey,
                                    child: EvaluationFinale(),
                                  ),
                                ),
                                GoRoute(
                                  path: 'performances',//id: state.pathParameters['userId']
                                  pageBuilder: (context, state) => NoTransitionPage<void>(
                                    key: state.pageKey,
                                    child: const PerformancesEvalue(),
                                  ),
                                ),
                              ]
                          ),
                        ]
                    ),
                  ]
              ),
              ShellRoute(
                  navigatorKey: _nestedMenuMaTeamNavigatorKey,
                  builder: (context, state, child) => MaTeamPage(child: child),
                  routes: [
                    GoRoute(
                        path: '/espace/ma-team',
                        pageBuilder: (context, state) => NoTransitionPage<void>(
                          key: state.pageKey,
                          child:  const SectionTeamExercice(),
                        ),
                       routes: [
                         GoRoute(
                           path: 'exercices/:idExercice',//id: state.pathParameters['userId']
                           pageBuilder: (context, state) => NoTransitionPage<void>(
                             key: state.pageKey,
                             child: const ExerciceTeamPage(),
                           ),
                           routes: [
                             GoRoute(
                               path: 'collaborateurs-n-1/:idCollaborateur',//id: state.pathParameters['userId']
                               pageBuilder: (context, state) => NoTransitionPage<void>(
                                 key: state.pageKey,
                                 child: TeamCollaborateurPage(),
                               ),
                             ),
                           ]
                         ),
                        ]
                    ),
                  ]
              ),
              GoRoute(
                path: '/espace/mon-profil',//id: state.pathParameters['userId']
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const ProfilPage(),
                ),
              ),
              GoRoute(
                path: '/espace/administration',//id: state.pathParameters['userId']
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const AdminPage(),
                ),
                routes: [
                 /* GoRoute(
                    path: 'exercice-d-evaluation',//id: state.pathParameters['userId']
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const AdminPage(index: 0,),
                    ),
                  ),
                  GoRoute(
                    path: 'collaborateurs',//id: state.pathParameters['userId']
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const AdminPage(index: 1,),
                    ),
                  ),
                  GoRoute(
                    path: 'postes',//id: state.pathParameters['userId']
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const AdminPage(index: 2,),
                    ),
                  ),
                  GoRoute(
                    path: 'application',//id: state.pathParameters['userId']
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const AdminPage(index: 3,),
                    ),
                  ),*/
                ]
              ),
            ]
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) async {
        
        final String? fullPath = state.fullPath;

        if (fullPath != null && fullPath.contains("/inscription")) {
          return null;
        }
        const storage = FlutterSecureStorage();
        String? token = await storage.read(key: "token");

        if ( token !=null &&  JwtDecoder.isExpired(token) == false ) {
          return null;
        }
        return "/connexion";
      }
  );
}