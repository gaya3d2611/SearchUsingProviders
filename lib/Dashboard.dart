import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController SearchText= new TextEditingController();
  List<dynamic> data;
  Map<String, dynamic> list;
  var movies = new List<Movie>();
  _autocomplete(search) async{
    MyModel().Autofill(search).then((response) async{
      var dataa= response;
      dataa= dataa.body;
      list= await json.decode(dataa);
      setState(() {
        list= json.decode(dataa);
        data= list["results"];

      });
    }).catchError((onError)=> print("nooooooooooooooooooooooooooo"));
  }
  initState(){
    _autocomplete("avengers");
    super.initState();
  }
  var search;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return ChangeNotifierProvider<MyModel>(
      create: (context)=>MyModel(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Consumer<MyModel>(
                        builder: (context, myModel, child){
                          return Container(
                            height: 50,
                            child: TextFormField(onFieldSubmitted: (value) => {
                              (value.isEmpty)
                                  ? print("empty")
                                  : _autocomplete(SearchText.text),


                            },
                                textInputAction: TextInputAction.go,
                                controller: SearchText,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                    ),
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14.0
                                    )
                                ),
                                onChanged: (value){
                                  print(value);
                                  search=value;
                                  myModel.Autofill(search);
                                }
                            ),
                          );
                        }
                    ),
                  ),
                  Divider(
                    thickness: 0,
                    color: Colors.white,
                  ),

                  Expanded(
                      child: ListView.builder(
                          itemCount: (data==null)?0:data.length,
                          itemBuilder: (context, index){
                            return (list.isEmpty) ? CupertinoActivityIndicator():Padding(
                                padding: EdgeInsets.all(8),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    Container(
                                      height:140,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.withOpacity(.1),
                                                offset: Offset(0,0),
                                                blurRadius: 10,
                                                spreadRadius: 3
                                            )
                                          ]
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                              width: MediaQuery.of(context).devicePixelRatio<3.3?115:90,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(child:
                                              Container(
                                                width: 280,
                                                //height:50,
                                                child:
                                              Text(data[index]["original_title"].toString(),
                                                style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold,
                                              ),
                                                textAlign: TextAlign.center,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                //maxLines: 1,
                                              ),
                            ),
                                              ),
                                              Divider(),
                                              Flexible(
                                                  child: Text("Genere: Action", style: TextStyle(
                                                      color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10
                                                  ),
                                                  )
                                              ),
                                              Divider(),
                                              Flexible(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        (data[index][
                                                        "vote_average"] ==
                                                            0)
                                                            ? "N/A"
                                                            : data[index][
                                                        "vote_average"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.blue[600],
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 22
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 19,
                                                      ),
                                                      SmoothStarRating(
                                                          allowHalfRating: false,
                                                          onRated: (v) {},
                                                          starCount: 5,
                                                          rating: data[index][
                                                          "vote_average"] /
                                                              2,
                                                          size: 22.0,
                                                          isReadOnly: true,
                                                          color:
                                                          Color(0xffFFD700),
                                                          borderColor:
                                                          Colors.grey,
                                                          spacing: 0.0)
                                                    ],
                                                  ),
                                              )

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Center(
                                                  child: CupertinoActivityIndicator(),
                                                ),
                                                (data[index]["poster_path"]==null)? Container(height:150, width:100, color: Colors.grey, child: Text("Poster not available", style: TextStyle(color: Colors.white), textAlign: TextAlign.center)):
                                                Container(
                                                  height: 150,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey.withOpacity(0.5),
                                                          offset: Offset(0, 0),
                                                          blurRadius: 10,
                                                          spreadRadius: 3,
                                                        )
                                                      ]
                                                  ),
                                                ),
                                                ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Image.network("https://image.tmdb.org/t/p/w500/"+data[index]["poster_path"].toString(), width: 100,height: 150,)
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )
                            );
                          }
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class MyModel with ChangeNotifier{
  var res;
  Future Autofill(search){
    var url="https://api.themoviedb.org/3/search/movie?api_key=194971b1815aeeec8ca14b129a739697&language=en-US&query="+ search.toString() + "&page=1&include_adult=true";
    return http.get(url);
  }
}
class Movie {
  int page;
  int totalResults;
  int totalPages;
  List<Results> results;

  Movie({this.page, this.totalResults, this.totalPages, this.results});

  Movie.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  double popularity;
  int id;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;

  Results(
      {this.popularity,
        this.id,
        this.video,
        this.voteCount,
        this.voteAverage,
        this.title,
        this.releaseDate,
        this.originalLanguage,
        this.originalTitle,
        this.genreIds,
        this.backdropPath,
        this.adult,
        this.overview,
        this.posterPath});

  Results.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'];
    id = json['id'];
    video = json['video'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'];
    title = json['title'];
    releaseDate = json['release_date'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    posterPath = json['poster_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['id'] = this.id;
    data['video'] = this.video;
    data['vote_count'] = this.voteCount;
    data['vote_average'] = this.voteAverage;
    data['title'] = this.title;
    data['release_date'] = this.releaseDate;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['backdrop_path'] = this.backdropPath;
    data['adult'] = this.adult;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    return data;
  }
}