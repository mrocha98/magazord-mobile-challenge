import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magazord_logger/logger.dart';

class DefaultBlocObserver extends BlocObserver {
  const DefaultBlocObserver(
    this._logger, {
    this.logEvents = true,
    this.logTransitions = true,
    this.logChanges = false,
    this.logCreations = false,
    this.logClosings = false,
  });

  DefaultBlocObserver.verbose(
    this._logger, {
    this.logEvents = true,
    this.logTransitions = true,
    this.logChanges = true,
    this.logCreations = true,
    this.logClosings = true,
  });

  DefaultBlocObserver.silent(
    this._logger, {
    this.logEvents = false,
    this.logTransitions = false,
    this.logChanges = false,
    this.logCreations = false,
    this.logClosings = false,
  });

  final Logger _logger;

  final bool logEvents;

  final bool logTransitions;

  final bool logChanges;

  final bool logCreations;

  final bool logClosings;

  @override
  void onCreate(BlocBase bloc) {
    if (logCreations) {
      _logger.debug('${bloc.runtimeType} created');
    }
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (logEvents) {
      _logger
        ..append('${bloc.runtimeType} received event:')
        ..append('$event')
        ..releaseAppended();
    }
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    if (logChanges) {
      _logger
        ..append('${bloc.runtimeType} changed')
        ..append('CURRENT state: ${change.currentState}')
        ..append('NEXT state: ${change.nextState}')
        ..releaseAppended();
    }
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (logTransitions) {
      _logger
        ..append(
          // ignore: avoid_dynamic_calls
          '''${bloc.runtimeType} transition with event ${transition.event.runtimeType}''',
        )
        ..append('CURRENT: ${transition.currentState}')
        ..append('NEXT: ${transition.nextState}')
        ..releaseAppended();
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.error('${bloc.runtimeType}', error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (logClosings) {
      _logger.debug('${bloc.runtimeType} closed');
    }
  }
}
