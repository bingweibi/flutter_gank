

class Result {
    String _id;
    String createdAt;
    String desc;
    List<String> images;
    String publishedAt;
    String source;
    String type;
    String url;
    bool used;
    String who;

    Result({id, this.createdAt, this.desc, this.images, this.publishedAt, this.source, this.type, this.url, this.used, this.who}):_id = id;

    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            id: json['_id'],
            createdAt: json['createdAt'], 
            desc: json['desc'], 
            images: json['images'] != null ? new List<String>.from(json['images']) : null, 
            publishedAt: json['publishedAt'], 
            source: json['source'], 
            type: json['type'], 
            url: json['url'], 
            used: json['used'], 
            who: json['who'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this._id;
        data['createdAt'] = this.createdAt;
        data['desc'] = this.desc;
        data['publishedAt'] = this.publishedAt;
        data['source'] = this.source;
        data['type'] = this.type;
        data['url'] = this.url;
        data['used'] = this.used;
        data['who'] = this.who;
        if (this.images != null) {
            data['images'] = this.images;
        }
        return data;
    }
}