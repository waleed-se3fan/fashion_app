import 'package:cc/constants.dart';
import 'package:flutter/material.dart';

class MostPopularProducts extends StatelessWidget {
  const MostPopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ListTile(
              leading: const Text(
                'Most Popular',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(color: Colors.orange[400]),
                  ))),
          SizedBox(
            height: height(context) / 2.2,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'https://media.gettyimages.com/id/1209951015/photo/young-woman-wearing-raincoat.jpg?s=612x612&w=gi&k=20&c=7ATS35VZRnCpqoV7rCiiT7KlHUNM0r8ZIXKNuMcESNQ=',
                                  ),
                                  fit: BoxFit.contain)),
                        ),
                        Text('data'),
                        Text('data')
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
