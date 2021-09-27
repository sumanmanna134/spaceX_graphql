import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spacex/components/mission_detail_card.dart';
import 'package:spacex/constants/constant.dart';
import 'package:spacex/models/models.dart';
import 'package:intl/intl.dart';

class Description extends StatefulWidget {
  final Models model;
  Description({this.model});
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  int activeFlicker = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          Constant.appBarHeading,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeFlicker = index;
                  });
                }
              ),
              itemCount: widget.model.links.flickrImages.isEmpty ? Constant.defaultFlickers.length : widget.model.links.flickrImages.length,
              itemBuilder: (context, index, realIndex){
                final flickerUrl = widget.model.links.flickrImages.isEmpty ?  Constant.defaultFlickers[index] : widget.model.links.flickrImages[index];
                return buildImage(flickerUrl , index);
              },
            ),
            buildIndicator(),
            SizedBox(height: 12,),
            MissionDetailCard(
              missionName: widget.model.missionName,
              rocketName: widget.model.rocket.rocketName,
              launchDate: DateFormat('yyyy-MM-dd – kk:mm').format(widget.model.launchDateUtc),
              siteName:  widget.model.launchSite.siteName,
              isLaunch: widget.model.launchSuccess,
              description: widget.model.details ?? "No Details Found",
            )
          ],
        ),
      ),
    );
  }

  Widget buildImage(String flickerUrl, int index) {
    return Container(
      width: double.infinity,
      child: Image.network(flickerUrl , fit: BoxFit.cover,),
    );
  }

  Widget buildIndicator() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey,
      child: Center(
        child: AnimatedSmoothIndicator(
          activeIndex: activeFlicker,
          count: Constant.defaultFlickers.length,
          effect: ScrollingDotsEffect(
            activeDotColor: Colors.yellow,
            dotColor: Colors.white,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ),
    );
  }
}
