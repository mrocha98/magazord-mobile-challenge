import 'package:go_router/go_router.dart';
import 'package:products_catalog/app/features/configs/configs_page.dart';

sealed class ConfigsRouter {
  static const path = '/configs';

  static final route = GoRoute(
    path: path,
    pageBuilder: (context, state) {
      return const NoTransitionPage(
        child: ConfigsPage(),
      );
    },
  );
}
