import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/screens/result_screen.dart';
import 'package:flutter_plactical_icoderz/utils/constant.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: category.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Divider(
                thickness: 1,
                height: 10,
                color: Colors.amberAccent,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultPage(
                      type: "category",
                      query: category[index],
                    );
                  }));
                },
                title: Text(category[index]),
                subtitle: Text("Read News from ${category[index]}"),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.amber,
                  child: Text(
                    category[index][0],
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                height: 10,
                color: Colors.amberAccent,
              ),
            ],
          );
        });
  }
}
