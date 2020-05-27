import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_utils/screen_utils.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController SearchText= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context)=>MyModel(),
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30),
                child: Consumer<MyModel>(
                  builder: (context, myModel, child){
                    return Container(
                      height: 50,
                      child: TextFormField(
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
                          myModel.Autofill();}
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
                    itemCount: 3,
                    itemBuilder: (context, index){
                      var gener;
                      (){};
                      return Padding(
                          padding: EdgeInsets.all(30),
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
                                Flexible(child: Text("Gayathri", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold
                                ),
                                ),
                                ),
                                Divider(),
                                Flexible(
                                  child: Text("genere: agdejhfbf", style: TextStyle(
                                    color: Colors.blue, fontWeight: FontWeight.bold
                                  ),
                                  )
                                )
                              ],
                            ),

                          )
                        ],
                      )
                      );
                    })
              )
            ],
          ),
        ),
      ),
    );
  }
}
class MyModel with ChangeNotifier{

void Autofill(){

}
}