import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/utils/constants.dart';

class CountryDetails extends StatefulWidget {

  var country;
  Color primaryColor;

  CountryDetails(this.country, this.primaryColor);

  @override
  CountryDetailsState createState() {
    return CountryDetailsState();
  }

}

class CountryDetailsState extends State<CountryDetails> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                color: widget.primaryColor.withOpacity(0.7),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  child: Icon(Icons.arrow_back_ios, color: Colors.white),
                                onTap: (){
                                    Navigator.pop(context);
                                },
                              ),
                              Text("${Constants.REGION} | ${widget.country["region"]}",
                                  style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.left),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                        )
                    ),
                    Flexible(
                      flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 3,
                              child: SvgPicture.network(
                                widget.country["flag"],
                                placeholderBuilder: (BuildContext context) => Container(
                                    child: const CircularProgressIndicator()),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${widget.country["name"]} (${widget.country["alpha3Code"]})",
                                        style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w600, fontSize: 16, color: widget.primaryColor),
                                        textAlign: TextAlign.left),
                                    Text("${widget.country["capital"]}",
                                        style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
                                        textAlign: TextAlign.left),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 4,
                child: Container(
                  color: widget.primaryColor.withOpacity(0.2),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(Constants.DEMONYM, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey)),
                                Text(widget.country["demonym"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(Constants.CALLING_CODE, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey)),
                                Text(widget.country["callingCodes"].toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(Constants.CURRENCY, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey)),
                                Text("${widget.country["currencies"][0]["symbol"]} ${widget.country["currencies"][0]["name"]}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(Constants.POPULATION, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey)),
                                Text(widget.country["population"].toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}