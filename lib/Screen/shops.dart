import 'package:flutter/material.dart';
class Shops extends StatefulWidget {
  final int id;
  const Shops({Key? key, required this.id}) : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  @override
  void initState() {

  print(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(''),
    );
  }
}
