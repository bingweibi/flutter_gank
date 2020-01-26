import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zhihu/bean/Result.dart';
import 'package:flutter_zhihu/net/http/gank_request.dart';
import 'package:flutter_zhihu/page/web_view/web_view.dart';

class Gank_android_page extends StatefulWidget {
  @override
  _Gank_android_pageState createState() => _Gank_android_pageState();
}

class _Gank_android_pageState extends State<Gank_android_page> {

  List<Result> dataList;
  int _num;
  ScrollController _scrollController;

  @override
  void initState(){
    super.initState();
    _num = 1;
    _scrollController = ScrollController()
      ..addListener((){
        if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
          _loadMoreData(10,++_num);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    if(dataList == null){
      getData(10, _num);
      return Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0,),
        ),
      );
    }else{
      return RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.separated(
          itemBuilder: (context,index){
            return Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.topLeft,
                      height: 50,
                      child: Text(
                        dataList[index].desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15,)),
                    ),
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(context)=> WebViewRoute(url:dataList[index].url,title: "Gank"))),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                            dataList[index].publishedAt.substring(0,10),
                            style: TextStyle(fontSize: 12),),
                        Text(
                            dataList[index].who,
                            style: TextStyle(fontSize: 12)
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context,index) => Divider(height: 0,indent: 8,endIndent: 8,),
          itemCount: dataList.length,
          controller: _scrollController,
        ),
      );
    }
  }

  void getData(int num, int page) async {
    dataList = await HttpUtil().gankAndroidRequest(num, page);
  }

  Future<void> _refreshData() async {
    await getData(10,_num);

  }

  void _loadMoreData(int num, int page) async{
    List<Result> data  = await HttpUtil().gankAndroidRequest(num, page);
    setState(() {
      dataList.addAll(data);
    });
  }
}

