import 'package:connection_with_google_sheet/gsheet.dart';
import 'package:connection_with_google_sheet/sheetcol.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController nameController=new TextEditingController();
  TextEditingController countryController=new TextEditingController();
  TextEditingController feedbackController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                ),
                TextFormField(
                    controller: countryController,
                ),
                TextFormField(
                    controller: feedbackController,
                ),
                GestureDetector(
                  onTap: () async {
                    final feedback= {
                      SheetColumn.name: nameController.text.trim(),
                      SheetColumn.country: countryController.text.trim(),
                      SheetColumn.feedback: feedbackController.text.trim()
                    };
                    await SheetsFlutter.insert(feedback);
                  },
                  child: Container(
                    height: 70,
                    width: 400,
                    color: Colors.red,
                    child: Center(child: Text("submit"),),
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
