import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/screens/country_details.dart';
import 'package:places/utils/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Countries extends StatefulWidget {

  String region;
  Color primaryColor;

  Countries(this.region, this.primaryColor);

  @override
  CountriesState createState() {
    return CountriesState();
  }

}

class CountriesState extends State<Countries> {

  Future<List<dynamic>> _future;

  @override
  void initState() {
    super.initState();

    setState(() {
      _future = getCountriesByRegion(widget.region);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.region, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: widget.primaryColor,
        leading: InkWell(
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        bottom: true,
        top: true,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Text(Constants.SELECT_COUNTRY,
                    style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w600, fontSize: 20, color: Colors.grey),
                    textAlign: TextAlign.center),
                Container(
                  height: 5,
                ),
                FutureBuilder(
                  future: _future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(snapshot.data);

                    if(snapshot.hasData){

                      List<dynamic> countriesList = snapshot.data;

                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var country = countriesList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return CountryDetails(country, widget.primaryColor);
                                      }));

/*
                                  showBottomSheet(context: context, builder: (context){
                                    return Container(
                                      color: widget.primaryColor,
                                      height: 150,
                                    );
                                  });
*/
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: widget.primaryColor.withOpacity(0.5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: Text(country["name"],
                                            style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w500, fontSize: 16, color: widget.primaryColor),
                                            textAlign: TextAlign.left),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: SvgPicture.network(
                                          country["flag"],
                                          placeholderBuilder: (BuildContext context) => Container(
                                              child: const CircularProgressIndicator()),
                                          height: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: countriesList.length,
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                        ),
                      );
                    }else {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> getCountriesByRegion(region) async{

    print("${Constants.APP_URL}$region");
    final response = await http.get("${Constants.APP_URL}$region");
    List<dynamic> arrayList = [];

    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      print(jsonResponse.length);

      //if(!jsonResponse.containsKey("status"))
        arrayList = jsonResponse;

      print("arrayList $arrayList");
      return arrayList;

    }else {
      print(response.statusCode);
      throw Exception('Failed to load data');
    }

  }

}