
//Screen to view the list of all the contributors of the project selected in home page


import 'package:flutter/material.dart';

import '../Widgets/contributor_card.dart';
import '../models/contributors_card_model.dart';

class Contributors extends StatefulWidget {
  static final String routename = '/Contributors';

  @override
  _ContributorsState createState() => _ContributorsState();
}

class _ContributorsState extends State<Contributors> {
  bool swap=false;
  List <ContributorCard> cardList = [ ContributorCard(userName:'Contributor 1',desc:'xyz',displayImgUrl:'https://www.cnam.ca/wp-content/uploads/2018/06/default-profile.gif',website: 'www.abc.com'),
    ContributorCard(userName:'Contributor 2',desc:'new',displayImgUrl:'https://user-images.githubusercontent.com/32811341/94847373-229c0380-0440-11eb-9d6f-0cc95ca1495c.jpg',website: 'www.pqr.com'),
    ContributorCard(userName:'Contributor 3',desc:'xyz',displayImgUrl:'https://www.cnam.ca/wp-content/uploads/2018/06/default-profile.gif',website: 'www.abc.com'),
    ContributorCard(userName:'Contributor 4',desc:'new',displayImgUrl:'https://user-images.githubusercontent.com/32811341/94847373-229c0380-0440-11eb-9d6f-0cc95ca1495c.jpg',website: 'www.pqr.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Contributors List'),
        ),  actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {  setState((){
                swap = !swap;
              });},
              child: Icon(
                Icons.track_changes,
                size: 26.0,
              ),
            )
        ),

      ],
        backgroundColor: Colors.grey,
      ),
      body:ListView.builder(
        // Get the List of contributors to the project from the GitHub Api
        // Append the details of the card to the cardList
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: cardList.length,
          itemBuilder:(ctx , index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:swap==true?ContCard(userName: cardList[index].userName,dispImg: cardList[index].displayImgUrl,desc: cardList[index].desc,webSite: cardList[index].website,):
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius:  BorderRadius.all(Radius.circular(10.0),),),

                  child: ListTile(title:Text(cardList[index].userName),subtitle: Text(cardList[index].desc),trailing: Text(cardList[index].website,),leading:
                  CircleAvatar(
                    radius: 60,
                    child: ClipOval(
                        child: Image.network(cardList[index].displayImgUrl, height: 500)
                    ),
                  ),),
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: addToContributors,
      ),
    );
  }
}

getContributors(){
  //TODO: Called when the page opens first
  //Append the contributor details to the cardList
}

addToContributors(){
  // TODO: Trigger an alert box or something similar
  // Ask the user to enter the details
  // Adds the user to contributors list
}


