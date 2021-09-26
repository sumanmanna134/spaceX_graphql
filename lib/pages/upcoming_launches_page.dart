import 'package:flutter/material.dart';
import 'package:spacex/components/loader.dart';
import 'package:spacex/components/mission_card.dart';
import 'package:spacex/constants/Label.dart';
import 'package:spacex/models/models.dart';
import 'package:spacex/provider/graphql_call.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UpcomingLaunches extends StatefulWidget {
  @override
  _UpcomingLaunchesState createState() => _UpcomingLaunchesState();
}

class _UpcomingLaunchesState extends State<UpcomingLaunches> {

  String headingLabel = Label.upcomingLaunchesHeading;
  List<MissionCard> missionCards=[];
  bool loader = true;
  List<Models> upcomingLaunchesList = [];
  String choosenFilter;

  void initState() {
    // TODO: implement initState
    super.initState();
    getUpcomingLaunchesList();
  }

  Future<void> getUpcomingLaunchesList() async
  {
    await context.read<GraphqlCall>().CallUpcoming();
    setState(() {
      upcomingLaunchesList = context.read<GraphqlCall>().upcomingData;
    });

    try{
      for(var i=0;i<upcomingLaunchesList.length;i++)
      {
        missionCards.add(MissionCard(
          missionName: upcomingLaunchesList[i].missionName,
          rocketName: upcomingLaunchesList[i].rocket.rocketName,
          launchDate: DateFormat('yyyy-MM-dd – kk:mm').format(upcomingLaunchesList[i].launchDateUtc),
          rocketImageUrl: upcomingLaunchesList[i].links.flickrImages.isEmpty ? 'https://static.scientificamerican.com/sciam/cache/file/4FAC51BC-0AAA-49D6-821EDD4BA053B2F0.jpg' :  upcomingLaunchesList[i].links.flickrImages[0],
          model: upcomingLaunchesList[i],
        ));
      }
    }catch(e){
      print("eeeeeeeeeeeeeee : $e");
    }
    missionCards.sort((a,b){
      return (a.missionName.compareTo(b.missionName));
    });
    setState(() {
      loader = false;
    });
  }
  void selectedFilter(String selectedValue){
    if(selectedValue == Label.filterList[0])
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
                      dropdownColor: Colors.black,
                      style: TextStyle(
                          color: Colors.white,
                      ),
                      hint: Text(
                        "Filter" ,
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
                      items: Label.filterList.map((String itemValue) {
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
