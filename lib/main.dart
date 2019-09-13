import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/Pokemon.dart';
import 'dart:convert';

import 'package:pokemon/pokeDetail.dart';


void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Pokemon App",
    theme: ThemeData(primarySwatch: Colors.cyan),
    home: HomePage(),
  ));

}

class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url ="https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";


  PokeHub pokehub;
  @override
  void initState() {
    
    super.initState();

    fetchData();
   
  }


  fetchData() async{
    var res=await http.get(url);
  var decodedValue = jsonDecode(res.body);
  
    pokehub= PokeHub.fromJson(decodedValue);
    setState(() {
      
    });
   
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Pokemon App'),
      ),
      body: pokehub == null ?
    Center(child: CircularProgressIndicator(),): GridView.count(crossAxisCount: 2,
      children: pokehub.pokemon.map((Pokemon poke)=> Padding(padding: const  EdgeInsets.all(2.0),
      child: InkWell(
        onTap: ()=>{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDetail(
            pokemon: poke,
          )))
        },
          child: Card(
          elevation: 5.0,
          child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
           Hero(
                  tag: poke.img,
                 child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(poke.img))),       
              ),
            ),
            Text(poke.name, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),)
          ],),
        ),
      ),)
     ).toList()),
      drawer: new Drawer(),
      floatingActionButton: new FloatingActionButton(onPressed: ()=>{},
      child: Icon(Icons.refresh),),
    );
  }
}