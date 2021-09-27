import 'package:flutter/material.dart';
import 'package:spacex/constants/styling.dart';

class MissionDetailCard extends StatelessWidget {
  final String missionName;
  final String rocketName;
  final String launchDate;
  final String description;
  final String siteName;
  final bool isLaunch;

  MissionDetailCard({
    this.missionName,
    this.rocketName,
    this.siteName,
    this.launchDate,
    this.description,
    this.isLaunch
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,),
      child: Card(
        elevation: 5,
        color: Color(0xff353935),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              missionName ,
                              style: Styling.missionCardDetail,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            isLaunch != null && isLaunch ?"Successfully Launched" : "Not Launched",
                            style: TextStyle(
                                color: isLaunch != null && isLaunch ? Colors.blue : Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        rocketName ,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      child: Text(
                        "Launch Date - " + launchDate ,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      child: Text(
                        "Site Name - " + siteName,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      child: Text(
                        "Description" ,
                        style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: Text(
                        description,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
