import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationPage(),
    ));

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
         leading: Text(
            'Cancel',
            textAlign: TextAlign.right,
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        title: new Text(
          ' My Address',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
     body: ListView(
          children: <Widget>[
             Container(


        width: 310.0,
        height:125.0,
  decoration: BoxDecoration(
    color: const Color(0XFFB3E5FC),

    border: Border.all(
    
      color: Colors.blue,
      
      width: 2,

    ),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text(" + Add address",style:TextStyle(color: Colors.lightBlue, fontSize:20),),
  alignment: Alignment(0.0, 0.0,),
),
         Container( 
             padding:
                const EdgeInsets.symmetric( horizontal: 5.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.add_location),
                              color: Colors.orange,
                              onPressed: () {},
                            ),
                    Text(
                     
                      'Bishal Adhikari',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
              ]
              )
              ),
             
               Container(
                    padding: const EdgeInsets.fromLTRB(50,0, 0, 0),
                    child: Text(
                      '9812345678',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                 Row(
                   
                    children: <Widget>[
                      
                      Container(
                        margin: new EdgeInsets.symmetric(horizontal: 50.0),
                       
                          height: 30,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.orange[900]),
                              
                          child: Center(
                            
                              child: Row(children: <Widget>[
                   
                            Text(
                              'Home',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ]))),
                      Expanded(child: 
                      
                      Center(
                              child: Row(children: <Widget>[
                                

                            Text(
                              'somewhere',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                   
                                ]  ),
                     
                      
                    ))],
                  ),


                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    
                      Padding(
                      
                      padding:
                      const EdgeInsets.symmetric( horizontal: 15.0),

                           child: Row(children: <Widget>[
                            Text(
                              'Bagmati,Kathmandu Metro-10 New Baneshwor',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )
                                ]  ),
                    )],
                  ),
                       Row(
                          
                    children: <Widget>[
                   
                      Padding(
                      
                      padding:
                       const EdgeInsets.symmetric( horizontal: 50.0),

                           child: Row(children: <Widget>[
                            Text(
                              'Area, Buddhanagar',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )
                                ]  ),
                    )],
                  ),
                  SizedBox(height: 20,),
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 50.0),
                      height: 35,
                      
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue,
                         width: 1.0,),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        
                          child: Text(
                        'Default shipping & biling address',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      )))


              ])
                  );
                
                
                
            
    
  }
}
