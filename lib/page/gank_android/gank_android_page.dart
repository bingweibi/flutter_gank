import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zhihu/bean/Result.dart';
import 'package:flutter_zhihu/net/http/gank_request.dart';
import 'package:flutter_zhihu/page/web_view/web_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Gank_android_page extends StatefulWidget {
  @override
  _Gank_android_pageState createState() => _Gank_android_pageState();
}

class _Gank_android_pageState extends State<Gank_android_page> {

  List<Result> dataList;
  int _page;
  final int _num = 20;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState(){
    super.initState();
    _page = 1;
  }

  @override
  Widget build(BuildContext context) {
    if(dataList == null){
      getData(_num, _page);
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
      return Scaffold(
        body: SmartRefresher(
          enablePullUp: true,
          enablePullDown: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context,LoadStatus mode){
            Widget body;
            if(mode == LoadStatus.idle){
              body = Text("上拉加载");
            }else if(mode == LoadStatus.loading){
              body = CupertinoActivityIndicator();
            }else if(mode == LoadStatus.canLoading){
              body = Text("松手，加载更多");
            }else{
              body = Text("没有更多数据了");
            }
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: Center(child: body),
              ),
            );
          },),
          controller: _refreshController,
          onRefresh: _refreshData,
          onLoading: ()=>_loadMoreData(_num,++_page),
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
          ),
        ),
      );
    }
  }

  void getData(int num, int page) async {
    dataList = await HttpUtil().gankAndroidRequest(num, page);
    setState(() {
    });
    print(dataList);
  }

  Future<void> _refreshData() async {
    dataList.clear();
    _page= 1 ;
    getData(_num,_page);
    _refreshController.refreshCompleted();
    setState(() {
    });
  }

  void _loadMoreData(int num, int page) async{
    List<Result> data  = await HttpUtil().gankAndroidRequest(num, page);
    if(mounted)
    setState(() {
      dataList.addAll(data);
    });
    _refreshController.loadComplete();
  }
}

