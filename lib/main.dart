import 'package:flutter/material.dart';
import 'package:flutter_zhihu/page/gank_ios/gank_ios_page.dart';
import 'package:flutter_zhihu/page/gank_picture/gank_picture_page.dart';
import 'package:flutter_zhihu/page/gank_video/gank_video_page.dart';

import 'page/gank_android/gank_android_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ZhiHu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gank'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
  List tabs = ["Android", "IOS", "视频", "图片"];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Gank_android_page(),
                    Gank_ios_page(),
                    Gank_video_page(),
                    Gank_picture_page(),
                  ],
            )),
          TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blue,
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
