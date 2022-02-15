import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  String? title;
  String? author;
  String? image;
  String? description;
  String? content;
  NewsDetails({Key? key, this.title, this.author, this.description, this.image, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(image!),
            const SizedBox(height: 10,),
            Text(title!),
            const SizedBox(height: 10,),
            Text(author!,textAlign: TextAlign.left ,),
            const SizedBox(height: 10,),
            Text(content!),
            const SizedBox(height: 10,),
          ],
        ),
      )
    );
  }
}
