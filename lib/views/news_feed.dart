import 'package:flutter/material.dart';
import 'package:news_api/api_services/api_manager.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/views/news_details.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  late Future<NewsModel?> _newsModel;

  @override
  void initState() {
    // TODO: implement initState
    _newsModel = ApiManager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: RefreshIndicator(
            onRefresh: (){
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (a, b, c) => const NewsFeed(),
                    transitionDuration: const Duration(seconds: 0),
                  ));
              return Future.value();
            },
            child: FutureBuilder<NewsModel?>(
                future: _newsModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          var article = snapshot.data!.articles![index];
                          return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: GestureDetector(
                                child: Card(
                                  child: ListTile(
                                    title: Text(article.title.toString()),
                                    subtitle: Text(article.author.toString()),
                                    leading: Image.network(
                                        article.urlToImage.toString()),
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetails(
                                              title: article.title,
                                              author: article.author,
                                              description: article.description,
                                              image: article.urlToImage,
                                              content: article.content,
                                            ))),
                              ));
                        });
                  }
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text("No data found"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )),
    );
  }
}
