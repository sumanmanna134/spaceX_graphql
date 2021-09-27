import 'package:flutter/material.dart';
import 'package:spacex/components/loader.dart';
import 'package:spacex/components/mission_card.dart';
import 'package:spacex/constants/constant.dart';
import 'package:spacex/models/models.dart';
import 'package:spacex/provider/graphql_call.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:spacex/constants/constant.dart';
class PastLaunches extends StatefulWidget {
  @override
  _PastLaunchesState createState() => _PastLaunchesState();
}

class _PastLaunchesState extends State<PastLaunches> {

  final String headingLabel = Constant.pastLaunchesHeading;
  List<MissionCard> missionCards = [];
  bool loader = true;
  List<Models> pastLaunchesList = [];
  String choosenFilter;
  

  @override
  void initState() {
    super.initState();
    getPastLaunchesList();
  }

  void getPastLaunchesList() async
  {
    await context.read<GraphqlCall>().callPast();
    setState(() {
      pastLaunchesList = context.read<GraphqlCall>().pastData;
    });

    try{
      for(var i=0;i<pastLaunchesList.length;i++)
      {
        missionCards.add(MissionCard(
          missionName: pastLaunchesList[i].missionName,
          rocketName: pastLaunchesList[i].rocket.rocketName,
          launchDate: DateFormat('yyyy-MM-dd – kk:mm').format(pastLaunchesList[i].launchDateUtc),
          rocketImageUrl: pastLaunchesList[i].links.flickrImages.isEmpty ? Constant.defaultRocketImageUrl :  pastLaunchesList[i].links.flickrImages[0],
          model: pastLaunchesList[i],
        ));
      }
    }catch(e){
      print(e);
    }
    setState(() {
      loader = false;
    });
  }

  void selectedFilter(String selectedValue){
    if(selectedValue == Constant.filterList[0])
      missionCards.sort((a,b){
        return (a.missionName.compareTo(b.missionName));
      });
    else{
      missionCards.sort((a,b){
        return (a.launchDate.compareTo(b.launchDate));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loader ? Loader() : Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 15, bottom: 10),
                    child: Text(
                      headingLabel ,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 15, bottom: 10),
                    child: DropdownButton<String>(
                      iconEnabledColor: Colors.white,
                      dropdownColor: Color(0xff353935),
                      style: TextStyle(
                        color: Colors.white
                      ),
                      hint: Text(
                          Constant.filter ,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      value: choosenFilter,
                      onChanged: (newValue) {
                        setState(() {
                          choosenFilter = newValue;
                          selectedFilter(choosenFilter);
                        });
                      },
                      items: Constant.filterList.map((String itemValue) {
                        return DropdownMenuItem<String>(
                          value: itemValue,
                          child: Text(
                              itemValue ,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for(var i=0;i<missionCards.length;i++)
                    missionCards[i]
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
