import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/models/latest_news.dart';
import 'package:news/providers/latest_news.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const _sections = [
    'arts',
    'automobiles',
    'books',
    'business',
    'fashion',
    'food',
    'health',
    'home',
    'insider',
    'magazine',
    'movies',
    'nyregion',
    'obituaries',
    'opinion',
    'politics',
    'realestate',
    'science',
    'sports',
    'sundayreview',
    'technology',
    'theater',
    't - magazine',
    'travel',
    'upshot',
    'us',
    'world'
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('NEWS PORTAL'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Latest',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            latestNews(context),
            categories(context),
          ],
        ),
      ),
    );
  }

  Widget latestNews(context) {
    final height = MediaQuery.of(context).size.height;
    final latestNewsProvider = Provider.of<LatestNewsProvider>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: latestNewsProvider.fetchData('home'),
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot);
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
                                          news.title
                                              .substring(0, 20)
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          news.desc.substring(0, 30).toString(),
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
    );
  }

  Widget categories(context) {
    return SafeArea(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(25),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        children: _sections
            .map(
              (e) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'news', arguments: {'title': e});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        'https://t4.ftcdn.net/jpg/01/88/00/47/360_F_188004715_xlqtmO5KGbNIhypzx3QWqZ9JG31sliOZ.jpg',
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      e.toString().toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
