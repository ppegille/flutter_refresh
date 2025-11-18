import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';

import '../widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(height: 50),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  RefreshIndicator makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final webtoon = snapshot.data![index];
          return Webtoon(title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
        },
        separatorBuilder: (context, index) =>
        const SizedBox(width: 40, height: 20),
      ),
    );
  }
}