import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pretty_dialog/pretty_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Alert Dialog'),
              onPressed: () => PrettyDialog.showAlertDialog(
                context,
                alertType: AlertType.success,
                okText: "OK",
                title: "Your account is created successfully",
              ),
            ),
            ElevatedButton(
              child: const Text('Confirmation Dialog'),
              onPressed: () => PrettyDialog.showActionDialog(context,
                  icon: CupertinoIcons.person_crop_circle_badge_xmark,
                  iconColor: Colors.deepOrangeAccent,
                  yesText: "Yes, Delete",
                  yesColor: Colors.deepOrangeAccent,
                  cancelText: "No",
                  title: "Are you sure to delete your Account?",
                  subTitle: "All your data will be permanently deleted, This can't be undone"),
            ),
            ElevatedButton(
              child: const Text('Options Dialog'),
              onPressed: () => PrettyDialog.showOptionsDialog(context,
                  icon: FontAwesomeIcons.dumbbell,
                  //iconColor: Colors.deepOrangeAccent,
                  //optionsColor: Colors.blue,
                  title: "لماذا تمارس التمارين الرياضية؟",
                  options: [
                    "لبناء العضلات",
                    "لإنقاص الوزن",
                    "للحفاظ على الصحة بشكل عام",
                  ]),
            ),
            ElevatedButton(
              child: const Text('Error Toast'),
              onPressed: () => PrettyToast.showErrorToast(context, "Something Went Wrong!"),
            ),
            ElevatedButton(
              child: const Text('Progress Toast'),
              onPressed: () {
                PrettyToast.showProgressToast(context, text: "جاري العمل ...");
                Future.delayed(const Duration(seconds: 3), () => PrettyToast.hideProgressToast());
              },
            )
          ],
        ),
      ),
    );
  }
}
