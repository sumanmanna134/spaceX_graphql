import 'package:flutter/material.dart';
import 'package:spacex/constants/constant.dart';
import 'package:spacex/constants/styling.dart';
import 'package:spacex/models/models.dart';

class MissionCard extends StatelessWidget {
  final String missionName;
  final String rocketName;
  final String rocketImageUrl;
  final String launchDate;
  final Models model;
  MissionCard({this.missionName,this.rocketName,this.rocketImageUrl,this.launchDate, this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      width: double.infinity,
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/description' , arguments: model);
        },
        child: Card(
          elevation: 5,
          color: Color(0xff353935),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            missionName,
                            style: Styling.missionCard
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: Text(
                            Constant.rocketLabel,
                            style: Styling.cardLabel,
                          ),
                        ),
                        Container(
                          child :Text(
                            rocketName,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: Text(
                            Constant.launchingDateLabel,
                            style: Styling.cardLabel,
                          ),
                        ),
                        Container(
                          child :Text(
                            launchDate,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    alignment: Alignment.topRight,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(rocketImageUrl)),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}