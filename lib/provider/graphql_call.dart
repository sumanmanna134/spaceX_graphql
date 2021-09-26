
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:spacex/models/models.dart';

class GraphqlCall extends ChangeNotifier {
  
  List<Models> pastData = [];
  List<Models> upcomingData = [];
  String _queryPast = """
            query launchHistory {
                launchesPast(limit: 10) {
                  mission_name 
                  launch_date_utc
                  rocket {
                    rocket_name
                    rocket_type
                  }
                  launch_site{
                    site_name
                  }
              links{
                flickr_images
                   }
              details
              launch_success
                }
              }
              """;


  String _queryUpcoming = """
          query launchUpcoming {
              launchesUpcoming(limit: 10) {
                mission_name 
                launch_date_utc
                rocket {
                  rocket_name
                  rocket_type
                }
                 launch_site{
                    site_name
                   }
                links {
                  flickr_images
                }
                details
                launch_success
                
              }
            }
        """;

    Future<void> CallPast() async{

    final link = HttpLink("https://api.spacex.land/graphql/");
    final GraphQLClient client = GraphQLClient(link: link, cache: GraphQLCache());
     try{
     final QueryResult _queryResult = await client.query(
         QueryOptions(
           document: gql(_queryPast),
         )
     );

     final result = _queryResult.data['launchesPast'];
     pastData =
         result.map<Models>((x) => Models.fromJson(x)).toList();

     } catch(e){
       print("errorrrrrrrrrrrrrrrrrrrrrrrrr $e");
     }

    notifyListeners();
  }
  
    Future<void> CallUpcoming() async{

      final link = HttpLink("https://api.spacex.land/graphql/");
      final GraphQLClient client = GraphQLClient(link: link, cache: GraphQLCache());
      try{
        final QueryResult _queryResult = await client.query(
            QueryOptions(
              document: gql(_queryUpcoming),
            )
        );

        final result = _queryResult.data['launchesUpcoming'];
        upcomingData =
            result.map<Models>((x) => Models.fromJson(x)).toList();

      } catch(e){
        print("errorrrrrrrrrrrrrrrrrrrrrrrrr $e");
      }

      notifyListeners();
      
    }

}