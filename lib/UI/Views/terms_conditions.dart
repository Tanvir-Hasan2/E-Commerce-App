import 'package:e_commerce/UI/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';


class TermCondition extends StatelessWidget {
 const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Terms & Conditions",
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
        //pdf show koraite hobe...
      // body: SfPdfViewer.network(
      //   'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      // ),
      body: Center(
        child: Text(
          "Hi this is terms and conditions page"
        ),
      ),
    );
  }
}
