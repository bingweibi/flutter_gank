import 'package:flutter/material.dart';
import 'package:flutter_zhihu/bean/Result.dart';
import 'package:flutter_zhihu/net/http/gank_request.dart';

class Gank_android_page extends StatefulWidget {
  @override
  _Gank_android_pageState createState() => _Gank_android_pageState();
}

class _Gank_android_pageState extends State<Gank_android_page> {

  List<Result> dataList;

  @override
  void initState(){
    super.initState();
    getData(10,1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text("android"),
    );
  }

  void getData(int num, int page) async {
    dataList = await HttpUtil().gankAndroidRequest(num, page);
    print(dataList);
  }


}

