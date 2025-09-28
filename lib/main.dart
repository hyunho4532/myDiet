import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/temp_user_c.dart';
import 'package:mydiet/presentation/widget/view/persistent_tabview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) 환경변수 로드
  await dotenv.load(fileName: ".env");

  await findSystemLocale();

  // 2) Supabase 초기화
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );

  // 3) 앱 실행
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Const().buildColors()[0]),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _printDeviceInfo();
  }

  Future<void> _printDeviceInfo() async {
    final info = await userController.deviceInfo();

    userController.insertTempUser(info.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabview()
    );
  }
}
