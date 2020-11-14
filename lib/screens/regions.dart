import 'package:flutter/material.dart';
import 'package:places/models/Region.dart';
import 'package:places/screens/countries.dart';
import 'package:places/utils/constants.dart';

class Regions extends StatefulWidget {

  @override
  RegionsState createState() {
    return RegionsState();
  }

}

class RegionsState extends State<Regions> {

  var regionList = [Region("Asia", Colors.blue), Region("Europe", Colors.purple)];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Constants.APP_NAME, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        bottom: true,
        top: true,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Text(Constants.SELECT_REGION,
                    style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w600, fontSize: 20, color: Colors.grey),
                    textAlign: TextAlign.center),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return Countries(regionList[index].regionName, regionList[index].primaryColor);
                                }));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: regionList[index].primaryColor,
                            ),
                            child: Text(regionList[index].regionName,
                              style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.left),
                          ),
                        ),
                      );
                    },
                    itemCount: regionList.length,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}