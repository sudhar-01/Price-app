import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:priceapp/model/httprequest.dart';
import 'package:priceapp/ui/animation.dart';

String current;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _connectionStatus = 'Unknown';
  Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<List> data;
  List<String> _currencies = ['INR', 'USD', 'EUR', 'JPY', 'RUB', 'SGD', 'BTC'];
  Map<String, dynamic> gold = {};
  Map<String, dynamic> silver = {};
  Map<String, dynamic> platinum = {};
  Map<String, dynamic> palladium = {};

  @override
  void initState() {
    super.initState();
    current = _currencies[1];
    _checkConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Rates",
            style: TextStyle(color: Colors.black),
            textScaleFactor: 1.5,
          ),
          centerTitle: true,
          bottomOpacity: 0.0,
          backgroundColor: Colors.cyanAccent[400],
          actions: <Widget>[
            IconButton(
                icon: Icon(Theme.of(context).brightness == Brightness.light
                    ? Icons.lightbulb_outline
                    : Icons.highlight),
                onPressed: () {
                  DynamicTheme.of(context).setThemeData(new ThemeData(
                      primaryColor:
                          Theme.of(context).primaryColor == Colors.black
                              ? Colors.white
                              : Colors.black));
                  DynamicTheme.of(context).setBrightness(
                      Theme.of(context).brightness == Brightness.light
                          ? Brightness.dark
                          : Brightness.light);
                }),
            _showCurrencies(),
          ],
        ),
        body: (_connectionStatus.contains("yes"))
            ? FutureBuilder(
                future: data,
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  else {
                    gold = jsonDecode(snapshot.data[0]);
                    silver = jsonDecode(snapshot.data[1]);
                    platinum = jsonDecode(snapshot.data[2]);
                    palladium = jsonDecode(snapshot.data[3]);
                    return ListView(children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                color: Colors.cyanAccent[100],
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.limeAccent[100],
                                      Colors.orangeAccent
                                    ]),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 5.0,
                                      blurRadius: 20.0)
                                ]),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("GOLD",
                                            textScaleFactor: 3.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${gold["currency"]} : " +
                                                "${_calculateRate(gold["price"])}/gram",
                                            textScaleFactor: 1.3,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          70.0,
                                      height: 60.0,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.amber[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 10.0,
                                                shadowColor: Colors.deepOrange,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("Previous price",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Text(
                                                              "${_calculateRate(gold["prev_close_price"])}/gram"),
                                                        ])),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.amber[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 10.0,
                                                shadowColor: Colors.deepOrange,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("Open price",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Text(
                                                              "${_calculateRate(gold["open_price"])}/gram"),
                                                        ])),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.amber[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 10.0,
                                                shadowColor: Colors.deepOrange,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("Low price",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Text(
                                                              "${_calculateRate(gold["low_price"])}/gram"),
                                                        ])),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.amber[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 10.0,
                                                shadowColor: Colors.deepOrange,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("High price",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Text(
                                                              "${_calculateRate(gold["high_price"])}/gram"),
                                                        ])),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.amber[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 10.0,
                                                shadowColor: Colors.deepOrange,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Spacer(flex: 4),
                                                          Text("Timestamp",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Spacer(flex: 3),
                                                          Text(
                                                            "${(DateTime.fromMillisecondsSinceEpoch(int.parse(gold["timestamp"].toString()) * 1000)).toString().substring(0, 10)}",
                                                            textScaleFactor:
                                                                0.7,
                                                          ),
                                                          Spacer(flex: 2),
                                                          Text(
                                                            "${(DateTime.fromMillisecondsSinceEpoch(int.parse(gold["timestamp"].toString()) * 1000)).toString().substring(11, 16)}",
                                                            textScaleFactor:
                                                                0.6,
                                                          ),
                                                          Spacer(flex: 1)
                                                        ])),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.amber[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 10.0,
                                                shadowColor: Colors.deepOrange,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("ch",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Text("${gold["ch"]}"),
                                                        ])),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.amber[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 10.0,
                                                shadowColor: Colors.deepOrange,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("chp",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Text(
                                                              "${gold["chp"]}"),
                                                        ])),
                                              ),
                                            ),
                                          ])),
                                ]),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                color: Colors.cyanAccent[100],
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.grey,
                                      Colors.blueGrey,
                                    ]),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 5.0,
                                      blurRadius: 20.0)
                                ]),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("SILVER",
                                            textScaleFactor: 3.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${silver["currency"]} : " +
                                                "${_calculateRate(silver["price"])}/gram",
                                            textScaleFactor: 1.3,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          70.0,
                                      height: 60.0,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.white70,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 5.0,
                                                shadowColor: Colors.blueGrey,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("Previous price",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Text(
                                                              "${_calculateRate(silver["price"])}/gram"),
                                                        ])),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.white70,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 5.0,
                                                shadowColor: Colors.blueGrey,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Spacer(flex: 4),
                                                          Text("Timestamp",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Spacer(flex: 3),
                                                          Text(
                                                            "${(DateTime.fromMillisecondsSinceEpoch(int.parse(silver["timestamp"].toString()) * 1000)).toString().substring(0, 10)}",
                                                            textScaleFactor:
                                                                0.7,
                                                          ),
                                                          Spacer(flex: 2),
                                                          Text(
                                                            "${(DateTime.fromMillisecondsSinceEpoch(int.parse(silver["timestamp"].toString()) * 1000)).toString().substring(11, 16)}",
                                                            textScaleFactor:
                                                                0.6,
                                                          ),
                                                          Spacer(flex: 1)
                                                        ])),
                                              ),
                                            ),
                                          ])),
                                ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.blue[200],
                                      Colors.indigoAccent[100],
                                    ]),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 5.0,
                                      blurRadius: 20.0)
                                ]),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("PLATINUM",
                                            textScaleFactor: 3.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${silver["currency"]} : " +
                                                "${_calculateRate(platinum["price"])}/gram",
                                            textScaleFactor: 0.8,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          70.0,
                                      height: 60.0,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.blueAccent[100],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 5.0,
                                                shadowColor: Colors.red,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("Previous price",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Text(
                                                              "${_calculateRate(platinum["prev_close_price"])}/gram"),
                                                        ])),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.blueAccent[100],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 5.0,
                                                shadowColor: Colors.red,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Spacer(flex: 4),
                                                          Text("Timestamp",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Spacer(flex: 3),
                                                          Text(
                                                            "${(DateTime.fromMillisecondsSinceEpoch(int.parse(platinum["timestamp"].toString()) * 1000)).toString().substring(0, 10)}",
                                                            textScaleFactor:
                                                                0.7,
                                                          ),
                                                          Spacer(flex: 2),
                                                          Text(
                                                            "${(DateTime.fromMillisecondsSinceEpoch(int.parse(platinum["timestamp"].toString()) * 1000)).toString().substring(11, 16)}",
                                                            textScaleFactor:
                                                                0.6,
                                                          ),
                                                          Spacer(flex: 1)
                                                        ])),
                                              ),
                                            ),
                                          ])),
                                ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.red[400],
                                      Colors.pinkAccent[100],
                                    ]),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 5.0,
                                      blurRadius: 20.0)
                                ]),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("PALLADIUM",
                                            textScaleFactor: 2.5,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${palladium["currency"]} : " +
                                                "${_calculateRate(palladium["price"])}/gram",
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          70.0,
                                      height: 60.0,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.red[200],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 5.0,
                                                shadowColor: Colors.blueAccent,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("Previous price",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Text(
                                                              "${_calculateRate(palladium["prev_close_price"])}/gram"),
                                                        ])),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                              child: Material(
                                                color: Colors.red[200],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                elevation: 5.0,
                                                shadowColor: Colors.blueAccent,
                                                child: Container(
                                                    height: 10.0,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Spacer(flex: 4),
                                                          Text("Timestamp",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                          Spacer(flex: 3),
                                                          Text(
                                                            "${(DateTime.fromMillisecondsSinceEpoch(int.parse(palladium["timestamp"].toString()) * 1000)).toString().substring(0, 10)}",
                                                            textScaleFactor:
                                                                0.7,
                                                          ),
                                                          Spacer(flex: 2),
                                                          Text(
                                                            "${(DateTime.fromMillisecondsSinceEpoch(int.parse(palladium["timestamp"].toString()) * 1000)).toString().substring(11, 16)}",
                                                            textScaleFactor:
                                                                0.6,
                                                          ),
                                                          Spacer(flex: 1)
                                                        ])),
                                              ),
                                            ),
                                          ])),
                                ])),
                      ),
                    ]);
                  }
                })
            : Center(
                child: Text(
                "!!! Please connect to the internet !!!",
                textScaleFactor: 1.5,
                style: TextStyle(color: Colors.red),
              )));
  }

  Widget _showCurrencies() {
    return DropdownButton<String>(
      items: _currencies.map((String element) {
        return DropdownMenuItem<String>(
          value: element,
          child: Text(element),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          current = value;
          data = null;
          data = Network2().fetData(current);
        });
        print(value);
      },
      value: current,
    );
  }

  double _calculateRate(var rate) {
    return double.parse((rate * 0.0352).toStringAsFixed(2));
  }

  Future<void> _checkConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (error) {
      print(error);
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = "yes");
        data = Network2().fetData(current);
        break;
      case ConnectivityResult.none:
        setState(() => _connectionStatus = "no");
        break;
      default:
        setState(() => _connectionStatus = "Failed to get connection");
    }
  }
}
