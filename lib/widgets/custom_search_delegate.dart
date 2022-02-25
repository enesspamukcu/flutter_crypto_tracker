import 'package:crypto_tracker_flutter/constants.dart';
import 'package:crypto_tracker_flutter/model/coin_model.dart';
import 'package:crypto_tracker_flutter/screens/coin_detail.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate{
   List<CoinModell> allTasks;
  CustomSearchDelegate(this.allTasks);

    @override
  ThemeData appBarTheme(BuildContext context) {
  return Theme.of(context);
}
  @override
  String? get searchFieldLabel => 'Search Cryptocurrency';


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query.isEmpty ? null : query='';
      }, icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: const Icon(Icons.arrow_back_ios,size: 24,));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<CoinModell> filteredList =  allTasks.where((task) => task.name.toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList.isNotEmpty ? ListView.builder(itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: ListTile(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
              return CoinDetail(coin: filteredList, index: index);
            })),
            leading: Image.network(filteredList[index].icon,width: 40,height: 40,),
            title: Text(filteredList[index].name),
          ),
        );
    },itemCount:filteredList.length ,) : Center(child: Text('Sorry, Coin Not Found',style: Constants.coinDetailTitle,),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}