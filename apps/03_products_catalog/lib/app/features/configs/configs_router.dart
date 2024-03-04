import 'package:go_router/go_router.dart';
import 'package:products_catalog/app/core/ui/transitions/slide_x_transition_page.dart';
import 'package:products_catalog/app/features/configs/configs_page.dart';

sealed class ConfigsRouter {
  static const path = '/configs';

  static final route = GoRoute(
    path: path,
    pageBuilder: (context, state) {
      return SlideXTransitionPage(
        key: state.pageKey,
        child: const ConfigsPage(),
      );
    },
  );
}
