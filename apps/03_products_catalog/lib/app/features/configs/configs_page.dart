import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_catalog/app/core/ui/theme/bloc/theme_mode_bloc.dart';

class ConfigsPage extends StatelessWidget {
  const ConfigsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ThemeModeBloc, ThemeMode>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, themeMode) {
            return ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text('Theme:'),
              trailing: DropdownButton<ThemeMode>(
                value: themeMode,
                isDense: true,
                onChanged: (value) {
                  if (value != null) {
                    context
                        .read<ThemeModeBloc>()
                        .add(ThemeModeChanged(themeMode: value));
                  }
                },
                items: ThemeMode.values
                    .map(
                      (tm) => DropdownMenuItem(
                        value: tm,
                        child: Text(tm.name),
                      ),
                    )
                    .toList(growable: false),
              ),
            );
          },
        ),
      ],
    );
  }
}
