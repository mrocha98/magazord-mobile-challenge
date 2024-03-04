import 'package:magazord_common_packages/common_packages.dart';
import 'package:magazord_common_packages_for_tests/common_packages_for_tests.dart';

abstract class FakeFactory<T> {
  @protected
  final Faker faker = Faker.instance;

  T make();

  List<T> makeList({int length = 2}) {
    return List.generate(length, (_) => make());
  }
}
