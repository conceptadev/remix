import 'package:carbon/carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonFileUploader delegates browse and item removal', (
    tester,
  ) async {
    var browsed = false;
    var removed = false;
    await tester.pumpCarbonApp(
      CarbonFileUploader(
        labelTitle: 'Upload documents',
        labelDescription: 'PDF files up to 5 MB',
        buttonLabel: 'Add files',
        onBrowse: () => browsed = true,
        items: [
          CarbonFileUploadItem(
            name: 'report.pdf',
            sizeDescription: '2 MB',
            status: CarbonFileUploadStatus.complete,
            onDelete: () => removed = true,
          ),
        ],
      ),
    );

    await tester.tap(find.bySemanticsLabel('Add files'));
    await tester.tap(find.bySemanticsLabel('Remove report.pdf'));

    expect(browsed, isTrue);
    expect(removed, isTrue);
    expect(
      find.bySemanticsLabel('report.pdf, upload complete'),
      findsOneWidget,
    );
  });

  testWidgets('CarbonFileUploadItem announces errors as a live region', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonFileUploadItem(
        name: 'too-large.pdf',
        status: CarbonFileUploadStatus.error,
        errorMessage: 'File exceeds 5 MB',
      ),
    );

    expect(
      tester.getSemantics(
        find.bySemanticsLabel('too-large.pdf, File exceeds 5 MB'),
      ),
      isSemantics(isLiveRegion: true),
    );
    semantics.dispose();
  });
}
