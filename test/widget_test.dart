import 'package:flutter_test/flutter_test.dart';
import 'package:streamboosters/main.dart';

void main() {
  testWidgets('StreamBoosters dashboard renders', (WidgetTester tester) async {
    await tester.pumpWidget(const StreamBoostersApp());

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Katalog artis'), findsNothing);
    expect(find.text('MUSIC GROWS ORGANICALLY'), findsOneWidget);
  });
}
