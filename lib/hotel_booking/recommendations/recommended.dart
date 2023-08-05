import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/period.dart';
import 'period_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Constant/blogDetail.dart';
import 'model/blog.dart';
import 'package:url_launcher/url_launcher.dart';

class RecomendedScreen extends StatelessWidget {
  List<Blog> bleeding(String bleedingIntensity, String pain) {
    var i = 0;
    List<Blog> bloglist = [];

    if (bleedingIntensity == 'Normal') {
      i = 0;
      while (i < blogDetail.length) {
        if ((blogDetail[i]['isMenorrhagia'] == 'false') &&
            blogDetail[i]['disease'] == 'null') {
          final newBlog = Blog(
            url: blogDetail[i]['url'] as String,
            imageUrl: blogDetail[i]['ImageUrl'] as String,
            youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
            isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
            disease: blogDetail[i]['disease'] as String,
            isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
            title: blogDetail[i]['title'] as String,
            description: blogDetail[i]['description'] as String,
          );
          bloglist.add(newBlog);
        }
        i = i + 1;
      }
    } else if (bleedingIntensity.contains('low')) {
      i = 0;
      while (i < blogDetail.length) {
        if ((blogDetail[i]['isMenorrhagia'] == 'false') &&
            blogDetail[i]['disease'] == 'hypomenorrhea') {
          final newBlog = Blog(
            url: blogDetail[i]['url'] as String,
            imageUrl: blogDetail[i]['ImageUrl'] as String,
            youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
            isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
            disease: blogDetail[i]['disease'] as String,
            isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
            title: blogDetail[i]['title'] as String,
            description: blogDetail[i]['description'] as String,
          );
          bloglist.add(newBlog);
        }
        i = i + 1;
      }
    } else if (bleedingIntensity.contains('high')) {
      i = 0;
      while (i < blogDetail.length) {
        if ((blogDetail[i]['isMenorrhagia'] == 'true')) {
          final newBlog = Blog(
            url: blogDetail[i]['url'] as String,
            imageUrl: blogDetail[i]['ImageUrl'] as String,
            youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
            isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
            disease: blogDetail[i]['disease'] as String,
            isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
            title: blogDetail[i]['title'] as String,
            description: blogDetail[i]['description'] as String,
          );
          bloglist.add(newBlog);
        }
        i = i + 1;
      }
    }
    if (pain.contains('high') || pain.contains('High')) {
      i = 0;
      while (i < blogDetail.length) {
        if ((blogDetail[i]['disease'] == 'dysmenorrhea') ||
            (blogDetail[i]['disease'] == 'Anemia')) {
          final newBlog = Blog(
            url: blogDetail[i]['url'] as String,
            imageUrl: blogDetail[i]['ImageUrl'] as String,
            youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
            isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
            disease: blogDetail[i]['disease'] as String,
            isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
            title: blogDetail[i]['title'] as String,
            description: blogDetail[i]['description'] as String,
          );
          bloglist.add(newBlog);
        }

        i = i + 1;
      }
    } else {
      print("else case running");
      i = 0;
      while (i < blogDetail.length) {
        final newBlog = Blog(
          url: blogDetail[i]['url'] as String,
          imageUrl: blogDetail[i]['ImageUrl'] as String,
          youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
          isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
          disease: blogDetail[i]['disease'] as String,
          isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
          title: blogDetail[i]['title'] as String,
          description: blogDetail[i]['description'] as String,
        );
        bloglist.add(newBlog);

        i = i + 1;
      }
    }

    return bloglist;
  }

  static const BleedingIntensity = ["Heavy", "Normal", "Low", "abc"];
  static const PainIntensity = ["High", "Moderate", "Low", "abc"];

  @override
  Widget build(BuildContext context) {
    final listOfPeriods = Provider.of<PeriodProvider>(context)
        .periodListProvideFromAlredyFetched();
    List<Blog> bloglist = [];
    if (listOfPeriods != null) {
      int bloodIndex = listOfPeriods[0].bloodIndex as int;
      int painIndex = listOfPeriods[0].painIndex as int;
      bloglist = bleeding(
          BleedingIntensity[bloodIndex],
          PainIntensity[painIndex]);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: ListView.builder(
          itemCount: bloglist.length,
          itemBuilder: (context, index) => Column(
            children: [
              InkWell(
                onTap: () async {
                  String url = bloglist[index].url;
                  try {
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  } catch (error) {
                    print(error);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.amber,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          //padding:EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              bloglist[index].imageUrl ??
                                  'https://i.pinimg.com/736x/56/58/eb/5658ebd81676b99acd753488dcadd054.jpg',
                              height: 0.3.sh,
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      /*Center(
                        child: Image.network(
                          bloglist[index].imageUrl ??
                              'https://i.pinimg.com/736x/56/58/eb/5658ebd81676b99acd753488dcadd054.jpg',
                          height: 100,
                        ),
                      ),*/
                      //SizedBox(height: 7),
                      Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.red[400]!.withOpacity(0.8),
                          // border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bloglist[index].title,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(height: 7),
                            Text(
                              bloglist[index].description,
                              maxLines: 3,
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  color: Colors.red[800],
                                  onPressed: () async {
                                    String url = bloglist[index].youtubeUrl;
                                    try {
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    } catch (error) {
                                      print(error);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.youtube_searched_for,
                                  ),
                                ),
                                SizedBox(width: 12),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class PeriodProvider with ChangeNotifier {
  late List<Period> periodListFetchedAlredy;

  void addPeriod(
      {required BuildContext ctx,
        required String from,
        required String to,
        required int pain,
        required int blood}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("Period")
          .add({
        "from": from,
        "to": to,
        "blood": blood,
        "pain": pain,
      });

      print("Period added successfully");
    } catch (err) {
      print("Error in period provider");
      print(err);
    }
  }

  // ignore: missing_return
  Future<List<Period>> getPeriodList() async {
    List<Period> periodList = [];
    try {
      final user = FirebaseAuth.instance.currentUser;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("Period")
          .orderBy('from')
          .get();
      querySnapshot.docs.forEach((element) {
        final eachPeriod = Period(
          bloodIndex: element.data()['blood'],
          from: DateTime.parse(element.data()['from']),
          painIndex: element.data()['pain'],
          to: DateTime.parse(element.data()['to']),
        );
        periodList.add(eachPeriod);
      });
      periodListFetchedAlredy = periodList;
      return periodList;
    } catch (err) {
      print(err);
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  List<Period> periodListProvideFromAlredyFetched() {
    return periodListFetchedAlredy;
  }
}

