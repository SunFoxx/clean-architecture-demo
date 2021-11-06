import 'package:flutter/material.dart';
import 'package:jimmy_test/core/localization/string_provider.dart';
import 'package:jimmy_test/core/locator.dart';
import 'package:jimmy_test/core/theme/theme.dart';
import 'package:jimmy_test/features/manufacturers/presentation/page/manufacturers_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppTheme>(create: (_) => AppTheme()),
        ChangeNotifierProvider<StringProvider>(create: (_) => locator.get<StringProvider>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ManufacturersPage(),
      ),
    );
  }
}
