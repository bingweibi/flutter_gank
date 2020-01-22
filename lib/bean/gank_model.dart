import 'Result.dart';

class Gank_android_model {
    bool error;
    List<Result> results;

    Gank_android_model({this.error, this.results});

    factory Gank_android_model.fromJson(Map<String, dynamic> json) {
        return Gank_android_model(
            error: json['error'], 
            results: json['results'] != null ? (json['results'] as List).map((i) => Result.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['error'] = this.error;
        if (this.results != null) {
            data['results'] = this.results.map((v) => v.toJson()).toList();
        }
        return data;
    }
}