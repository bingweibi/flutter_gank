import 'package:flutter/material.dart';
import 'package:flutter_zhihu/bean/Result.dart';
import 'package:flutter_zhihu/net/http/gank_request.dart';

class Gank_video_page extends StatefulWidget {
  @override
  _Gank_video_pageState createState() => _Gank_video_pageState();
}

class _Gank_video_pageState extends State<Gank_video_page> {

  List<Result> dataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(10,1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("视频"),
    );
  }


  void getData(int num, int page) async {
    dataList = await HttpUtil().gankVideoRequest(num, page);
    print(dataList);
  }
}

