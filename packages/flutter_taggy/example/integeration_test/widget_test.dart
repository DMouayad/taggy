import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Initial state test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    /* Widgets that should be found */
    expect(find.byType(FileSelectionSection), findsOneWidget);
    // the selected file path should be 'None'
    expect(find.text('"None"'), findsOneWidget);
    expect(find.bySubtype<TextButton>(), findsOneWidget);

    /* Widgets that should NOT be found */
    expect(find.byType(ReadTagsSection), findsNothing);
    expect(find.byType(WritingTagsSection), findsNothing);
    expect(find.byType(RemoveTagsSection), findsNothing);
  });
}
