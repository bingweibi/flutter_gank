import 'package:dio/dio.dart';
import 'package:flutter_zhihu/bean/gank_model.dart';
import 'package:flutter_zhihu/bean/Result.dart';

class HttpUtil {
  static const  String baseUrl = "http://gank.io/api/data/";
  Dio dio = Dio();

  Response response;

//  android页请求数据
  gankAndroidRequest(int num,int page) async {
     response = await dio.get(baseUrl+"Android/"+num.toString()+"/"+page.toString());
     print(response.data);
     List<Result> resultList = Gank_android_model.fromJson(response.data).results;
     return resultList;
   }

//   ios页请求数据
  gankIOSRequest(int num,int page) async{
     response = await dio.get(baseUrl+"iOS/"+num.toString()+"/"+page.toString());
     List<Result> resultList = Gank_android_model.fromJson(response.data).results;
     return resultList;
  }

  //   视频页请求数据
  gankVideoRequest(int num,int page) async{
    response = await dio.get(baseUrl+"休息视频/"+num.toString()+"/"+page.toString());
    List<Result> resultList = Gank_android_model.fromJson(response.data).results;
    return resultList;
  }

  //   图片页请求数据
  gankPictureRequest(int num,int page) async{
    response = await dio.get(baseUrl+"福利/"+num.toString()+"/"+page.toString());
    List<Result> resultList = Gank_android_model.fromJson(response.data).results;
    return resultList;
  }

}