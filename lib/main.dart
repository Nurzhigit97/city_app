import 'package:city_app/di.dart';
import 'package:city_app/features/city/presentation/pages/city_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di();
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CityPage(),
      ),
    ),
  );
}
