import 'package:flutter/material.dart';
import 'package:news/models/latest_news.dart';
import 'package:news/providers/latest_news.dart';
import 'package:provider/provider.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final height = MediaQuery.of(context).size.height;
    final latestNewsProvider = Provider.of<LatestNewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(arg['title'].toString().toUpperCase()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: latestNewsProvider.fetchData(arg['title'].toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<LatestNewsModel> latestNews = snapshot.data;
                return Column(
                  children: latestNews
                      .map((news) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  'details',
                                  arguments: {
                                    'title': news.title.toString(),
                                    'desc': news.desc.toString(),
                                    'image': news.multimedia.toString(),
                                    'date': news.published_date.toString(),
                                  },
                                );
                              },
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 1.0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                news.multimedia,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (news.title.toString().length > 30)
                                                ? news.title
                                                    .toString()
                                                    .substring(0, 25)
                                                : news.title.toString(),
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            (news.desc.toString().length > 40)
                                                ? news.desc
                                                    .toString()
                                                    .substring(0, 30)
                                                : news.desc.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                );
              } else {
                return Container(
                  color: Colors.white,
                  height: height / 1.5,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
