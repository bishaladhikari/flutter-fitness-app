import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReviewPage(),
    ));

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(

          backgroundColor: Colors.white,
          centerTitle: true,
          title: new Text(
            ' Write A Review',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      
         body: Stack(
        children:<Widget> [ Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
            child: Row(children: <Widget>[
                 IconButton(
                              icon: Icon(Icons.star),
                              color: Colors.yellow,
                              iconSize: 40,
                              onPressed: () {},
                            ),
                 IconButton(
                              icon: Icon(Icons.star),
                              color: Colors.yellow,
                              iconSize: 40,
                              onPressed: () {},
                            ),
                   IconButton(
                              icon: Icon(Icons.star),
                              color: Colors.yellow,
                              iconSize: 40,
                              onPressed: () {},
                            ),
                             IconButton(
                              icon: Icon(Icons.star),
                              color: Colors.yellow,
                              iconSize: 40,
                              onPressed: () {},
                            ),
                             IconButton(
                              icon: Icon(Icons.star),
                              color: Colors.yellow,
                              iconSize: 40,
                              onPressed: () {},
                            ),






             
             









            ])),

            Container(
            padding: const  EdgeInsets.fromLTRB(10.0, 80.0, 10.0, 20.0),
            child: Column(
              children:<Widget> [
               
              Container(
                  padding:
                const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                height: 95,
                decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.grey),
            ),
             child: Row(
                children: <Widget>[
        
                  Text('Add a Description', style:TextStyle(color: Colors.black38, fontSize:18),) ,
                   

                ],
            ),
          
              ),
              ]
          )
       
         
          ),

            Container(
            padding: const  EdgeInsets.fromLTRB(10.0, 190.0, 10.0, 20.0),
            child: Column(
              children:<Widget> [
               
              Container(
                  padding:
                const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                height: 55,
                decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.grey),
            ),
             child: Row(
                children: <Widget>[
                   IconButton(
                              icon: Icon(Icons.add_a_photo),
                              color: Colors.black,
                              onPressed: () {},
                            ),
                  Text('Upload a image', style:TextStyle(color: Colors.black38, fontSize:18),) ,
                   

                ],
            ),
          
              ),
              ]
          )
       
         
          ),


           Container(
            padding: const  EdgeInsets.fromLTRB(10.0, 350.0, 10.0, 10.0),
            child: Column(
              children:<Widget> [
               
              Container(
                  height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange),
                      child: Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))),
         
                  
                ],
            ),
          

           )
            ]));
  }
}
