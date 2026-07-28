import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('RemixSpinner exposes opt-in semantics inputs', () {
    const spinner = RemixSpinner(
      semanticsLabel: 'Loading workspaces',
      semanticsValue: 'Connecting',
    );

    expect(spinner.semanticsLabel, 'Loading workspaces');
    expect(spinner.semanticsValue, 'Connecting');
  });

  test('RemixProgress exposes opt-in semantics inputs', () {
    const progress = RemixProgress(
      value: 0.42,
      semanticsLabel: 'Uploading workspace',
      semanticsValue: '42',
    );

    expect(progress.semanticsLabel, 'Uploading workspace');
    expect(progress.semanticsValue, '42');
  });
}
