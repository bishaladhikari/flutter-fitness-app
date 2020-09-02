import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: new Text(
            'Add New Address',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          actions: <Widget>[
            new Center(
              child: Text(
                'Cancel',
                textAlign: TextAlign.right,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                    hintText: "Full Name",
                     hintStyle: TextStyle(color:Colors.grey),
                    )
                  ),
                  TextField(
                     decoration: InputDecoration(
                    hintText: "Phone Number",
                     hintStyle: TextStyle(color:Colors.grey),
                    )

                  ),
                  TextField(
                     decoration: InputDecoration(
                    hintText: "Region",
                     hintStyle: TextStyle(color:Colors.grey),
                    )
                  ),
                  TextField(
                     decoration: InputDecoration(
                    hintText: "City",
                     hintStyle: TextStyle(color:Colors.grey),
                    )
                  ),
                  TextField(
                     decoration: InputDecoration(
                    hintText: "Area",
                     hintStyle: TextStyle(color:Colors.grey),
                    )
                  ),
                  TextField(
                     decoration: InputDecoration(
                    hintText: "Address",
                     hintStyle: TextStyle(color:Colors.grey),
                    )
                  ),

                    
                  Container(
                    padding:const EdgeInsets.fromLTRB(0,20,0,20),
                    
                    child: Text("Select a label for effective delivery",style: TextStyle(color: Colors.black,fontSize:17),),
                  ),
                            
                          
              Row(
  children: <Widget>[
    FlutterLogo(),
    Expanded(child: SizedBox()),
    FlutterLogo(),
  ],
),
            
                
                    
                    
 
                  
                   Container(
                    padding:const EdgeInsets.fromLTRB(0,20,0,20),
                    
                    child: Text("Make a default shipping address",style: TextStyle(color: Colors.black,fontSize:17),),
                  ),
                  Container(
                    padding:const EdgeInsets.fromLTRB(0,20,0,20),
                    
                    child: Text("Make a default biling address",style: TextStyle(color: Colors.black,fontSize:17),),
                  ),


                   Container(
            height:35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange[900]
            ),
              
              child: Center(
                
                child: Text('Save',style:TextStyle(color: Colors.white, fontSize:18),)
              ))

                ]
                )
                
                
            )
       );
    
  }
}
