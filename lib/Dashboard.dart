import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
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
                        itemCount: list["results"].length,
                        itemBuilder: (context, index){
                          return Padding(
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
                                      width: 120
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(child: Text(list["results"][index]["title"].toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                                        ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          //maxLines: 1,
                                        ),
                                        ),
                                        Divider(),
                                        Flexible(
                                          child: Text("Year: " + list["results"][index]["description"].toString(), style: TextStyle(
                                            color: Colors.blue, fontWeight: FontWeight.bold
                                          ),
                                          )
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
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
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
                                            child: Image.network(list["results"][index]["image"].toString(), width: 100,height: 150,)
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
  var url="https://imdb-api.com/en/API/SearchMovie/k_3CSij27E/"+ search.toString();
  return http.get(url);
}
}
class Movie {
  String searchType;
  String expression;
  List<Results> results;
  String errorMessage;

  Movie({this.searchType, this.expression, this.results, this.errorMessage});

  Movie.fromJson(Map<String, dynamic> json) {
    searchType = json['searchType'];
    expression = json['expression'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchType'] = this.searchType;
    data['expression'] = this.expression;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class Results {
  String id;
  String resultType;
  String image;
  String title;
  String description;

  Results({this.id, this.resultType, this.image, this.title, this.description});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resultType = json['resultType'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resultType'] = this.resultType;
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
