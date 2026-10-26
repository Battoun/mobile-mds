import 'package:flutter_application_1/models/sensor.dart';
import 'package:flutter_application_1/repositories/fake_sensor_repository.dart';
import 'package:flutter_application_1/view_models/async_state.dart';
import 'package:flutter_application_1/view_models/dashboard_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DateTime now;
  DateTime clock() => now;

  setUp(() => now = DateTime(2026, 10, 26, 14, 3, 27));

  DashboardViewModel buildViewModel(
    FakeSensorRepository repository, {
    Duration staleAfter = const Duration(seconds: 30),
  }) =>
      DashboardViewModel(
        repository: repository,
        staleAfter: staleAfter,
        clock: clock,
      );

  test('premier chargement en erreur, nouvelle tentative réussie '
      'avec la même instance', () async {
    final repository = FakeSensorRepository(
      latency: Duration.zero,
      failingCalls: {1},
    );
    final viewModel = buildViewModel(repository);

    await viewModel.load();
    expect(viewModel.state, isA<Failure<Sensor>>());
    expect(viewModel.isLoading, isFalse);

    await viewModel.load();
    expect(viewModel.state, isA<Content<Sensor>>());
    expect(viewModel.sensorCount, 3);
    expect(repository.callCount, 2);
  });

  test('publie Loading puis Content à chaque transition', () async {
    final viewModel = buildViewModel(
      FakeSensorRepository(latency: Duration.zero),
    );
    final published = <Type>[];
    viewModel.addListener(() => published.add(viewModel.state.runtimeType));

    await viewModel.load();

    expect(published, [Loading<Sensor>, Content<Sensor>]);
  });

  test('des actualisations rapides ne déclenchent qu\'un seul chargement',
      () async {
    final repository = FakeSensorRepository(
      latency: const Duration(milliseconds: 100),
    );
    final viewModel = buildViewModel(repository);

    final first = viewModel.load();
    expect(viewModel.isLoading, isTrue);
    viewModel.load();
    viewModel.load();
    viewModel.load();
    await first;

    expect(repository.callCount, 1);
    expect(viewModel.isLoading, isFalse);

    // Une fois terminé, une nouvelle actualisation est de nouveau possible.
    await viewModel.load();
    expect(repository.callCount, 2);
  });

  test('l\'heure de la dernière réussite est conservée après une erreur',
      () async {
    final repository = FakeSensorRepository(
      latency: Duration.zero,
      failingCalls: {1, 3},
    );
    final viewModel = buildViewModel(repository);

    await viewModel.load(); // erreur
    expect(viewModel.lastRefreshLabel, 'Aucune actualisation réussie');

    await viewModel.load(); // succès à 14:03:27
    expect(viewModel.lastRefreshLabel, 'Dernière actualisation : 14:03:27');

    now = now.add(const Duration(minutes: 2));
    await viewModel.load(); // erreur
    expect(viewModel.state, isA<Failure<Sensor>>());
    expect(viewModel.lastRefreshLabel, 'Dernière actualisation : 14:03:27');

    await viewModel.load(); // succès à 14:05:27
    expect(viewModel.lastRefreshLabel, 'Dernière actualisation : 14:05:27');
  });

  test('les données deviennent anciennes après le seuil, puis fraîches '
      'après un nouveau succès', () async {
    final viewModel = buildViewModel(
      FakeSensorRepository(latency: Duration.zero),
      staleAfter: const Duration(seconds: 10),
    );
    expect(viewModel.isStale, isFalse);

    await viewModel.load();
    expect(viewModel.isStale, isFalse);

    now = now.add(const Duration(seconds: 11));
    expect(viewModel.isStale, isTrue);

    await viewModel.load();
    expect(viewModel.isStale, isFalse);
    viewModel.dispose();
  });
}
