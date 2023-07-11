import 'package:flutter/material.dart';

double height(context) {
  return MediaQuery.of(context).size.height;
}

double width(context) {
  return MediaQuery.of(context).size.width;
}

List<String> types = [
  'All',
  "men's clothing",
  "women's clothing",
  'jewelery',
  'Shoes',
  'electronics'
];

List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];

List colors = [
  Colors.white,
  Colors.amber,
  Colors.black,
  Colors.blue,
  Colors.brown,
  Colors.deepPurple,
  Colors.orange
];

class CustomButton extends StatelessWidget {
  String data;
  Function function;
  CustomButton(this.data, this.function, {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.black,
      onPressed: () {
        function;
      },
      child: Text(
        data,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
