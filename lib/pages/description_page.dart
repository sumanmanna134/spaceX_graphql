import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spacex/components/mission_detail_card.dart';
import 'package:spacex/constants/Label.dart';
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
  List defaultFlickers = [
    "https://live.staticflickr.com/65535/50630802488_8cc373728e_o.jpg",
    "https://live.staticflickr.com/65535/50631642722_3af8131c6f_o.jpg",
    "https://live.staticflickr.com/65535/50631544171_66bd43eaa9_o.jpg",
    "https://live.staticflickr.com/65535/50631543966_e8035d5cca_o.jpg",
    "https://live.staticflickr.com/65535/50631643257_c214ceee7b_o.jpg",
    "https://live.staticflickr.com/65535/50631643917_cb7db291d0_o.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    print("bbbbbbbbbbbbbbbb : ${widget.model.missionName}");
    return Scaffold(
      // backgroundColor: Color(0xff353935),
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          Label.appBarHeading,
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
                // autoPlayInterval: Duration(seconds: 4),
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeFlicker = index;
                  });
                }
              ),
              itemCount: widget.model.links.flickrImages.isEmpty ? defaultFlickers.length : widget.model.links.flickrImages.length,
              itemBuilder: (context, index, realIndex){
                final flickerUrl = widget.model.links.flickrImages.isEmpty ?  defaultFlickers[index] : widget.model.links.flickrImages[index];
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
      // color: Colors.grey,
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
          count: defaultFlickers.length,
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
