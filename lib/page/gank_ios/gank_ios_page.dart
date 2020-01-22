import 'package:flutter/material.dart';
import 'package:flutter_zhihu/bean/Result.dart';
import 'package:flutter_zhihu/net/http/gank_request.dart';

class Gank_ios_page extends StatefulWidget {
  @override
  _Gank_ios_pageState createState() => _Gank_ios_pageState();
}

class _Gank_ios_pageState extends State<Gank_ios_page> {

  List<Result> dataList;

  @override
  void initState() {
    super.initState();
    getData(10,1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ios"),
    );
  }

  void getData(int num, int page) async {
    dataList = await HttpUtil().gankIOSRequest(num, page);
    print(dataList);
  }

}

