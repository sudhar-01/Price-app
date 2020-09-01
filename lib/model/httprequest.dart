import 'package:http/http.dart';

class Network2 {
  Map<String, String> headers = {
    'x-access-token': 'goldapi-qpbyhykd2pyyoq-io',
    'Content-Type': 'application/json'
  };
  Future<List> fetData(String _curr) async {
    List<Response> responceList = new List<Response>();
    List<dynamic> metalslist = new List<dynamic>();
    if (_curr.contains('USD')) {
      String url1 = "https://www.goldapi.io/api/XAU/USD";
      String url2 = "https://www.goldapi.io/api/XAG/USD";
      String url3 = "https://www.goldapi.io/api/XPT/USD";
      String url4 = "https://www.goldapi.io/api/XPD/USD";
      await get(url1, headers: headers).then((value) {
        responceList.add(value);
        return get(url2, headers: headers).then((value) {
          responceList.add(value);
          return get(url3, headers: headers).then((value) {
            responceList.add(value);
            return get(url4, headers: headers).then((value) {
              responceList.add(value);
            }).catchError((error) => print(error));
          }).catchError((error) => print(error));
        }).catchError((error) => print(error));
      }).catchError((error) => print(error));
      print("first = $responceList");
      responceList.forEach((element) {
        metalslist.add(element.body);
      });
      return metalslist;
    }
    else if(_curr.contains('INR')){
      String url1 = "https://www.goldapi.io/api/XAU/INR";
      String url2 = "https://www.goldapi.io/api/XAG/INR";
      String url3 = "https://www.goldapi.io/api/XPT/INR";
      String url4 = "https://www.goldapi.io/api/XPD/INR";
       await get(url1, headers: headers).then((value) {
        responceList.add(value);
        return get(url2, headers: headers).then((value) {
          responceList.add(value);
          return get(url3, headers: headers).then((value) {
            responceList.add(value);
            return get(url4, headers: headers).then((value) {
              responceList.add(value);
            }).catchError((error) => print(error));
          }).catchError((error) => print(error));
        }).catchError((error) => print(error));
      }).catchError((error) => print(error));
      print("first = $responceList");
      responceList.forEach((element) {
        metalslist.add(element.body);
      });

      return metalslist;
    }
    else if(_curr.contains('EUR')){
      String url1 = "https://www.goldapi.io/api/XAU/EUR";
      String url2 = "https://www.goldapi.io/api/XAG/EUR";
      String url3 = "https://www.goldapi.io/api/XPT/EUR";
      String url4 = "https://www.goldapi.io/api/XPD/EUR";

      await get(url1, headers: headers).then((value) {
        responceList.add(value);
        return get(url2, headers: headers).then((value) {
          responceList.add(value);
          return get(url3, headers: headers).then((value) {
            responceList.add(value);
            return get(url4, headers: headers).then((value) {
              responceList.add(value);
            }).catchError((error) => print(error));
          }).catchError((error) => print(error));
        }).catchError((error) => print(error));
      }).catchError((error) => print(error));
      print("first = $responceList");
      responceList.forEach((element) {
        metalslist.add(element.body);
      });

      return metalslist;
    }
    else if(_curr.contains('JPY')){
      String url1 = "https://www.goldapi.io/api/XAU/JPY";
      String url2 = "https://www.goldapi.io/api/XAG/JPY";
      String url3 = "https://www.goldapi.io/api/XPT/JPY";
      String url4 = "https://www.goldapi.io/api/XPD/JPY";
      List<Response> responceList = new List<Response>();
      await get(url1, headers: headers).then((value) {
        responceList.add(value);
        return get(url2, headers: headers).then((value) {
          responceList.add(value);
          return get(url3, headers: headers).then((value) {
            responceList.add(value);
            return get(url4, headers: headers).then((value) {
              responceList.add(value);

            }).catchError((error) => print(error));
          }).catchError((error) => print(error));
        }).catchError((error) => print(error));
      }).catchError((error) => print(error));
      print("first = $responceList");
      responceList.forEach((element) {
        metalslist.add(element.body);
      });

      return metalslist;
    }
    else if(_curr.contains('RUB')){
      String url1 = "https://www.goldapi.io/api/XAU/RUB";
      String url2 = "https://www.goldapi.io/api/XAG/RUB";
      String url3 = "https://www.goldapi.io/api/XPT/RUB";
      String url4 = "https://www.goldapi.io/api/XPD/RUB";
      await get(url1, headers: headers).then((value) {
        responceList.add(value);
        return get(url2, headers: headers).then((value) {
          responceList.add(value);
          return get(url3, headers: headers).then((value) {
            responceList.add(value);
            return get(url4, headers: headers).then((value) {
              responceList.add(value);

            }).catchError((error) => print(error));
          }).catchError((error) => print(error));
        }).catchError((error) => print(error));
      }).catchError((error) => print(error));
      print("first = $responceList");
      responceList.forEach((element) {
        metalslist.add(element.body);
      });

      return metalslist;
    }
    else if(_curr.contains('SGD')){
      String url1 = "https://www.goldapi.io/api/XAU/SGD";
      String url2 = "https://www.goldapi.io/api/XAG/SGD";
      String url3 = "https://www.goldapi.io/api/XPT/SGD";
      String url4 = "https://www.goldapi.io/api/XPD/SGD";

      await get(url1, headers: headers).then((value) {
        responceList.add(value);
        return get(url2, headers: headers).then((value) {
          responceList.add(value);
          return get(url3, headers: headers).then((value) {
            responceList.add(value);
            return get(url4, headers: headers).then((value) {
              responceList.add(value);

            }).catchError((error) => print(error));
          }).catchError((error) => print(error));
        }).catchError((error) => print(error));
      }).catchError((error) => print(error));
      print("first = $responceList");

      responceList.forEach((element) {
        metalslist.add(element.body);
      });

      return metalslist;
    }
    else if(_curr.contains('BTC')){
      String url1 = "https://www.goldapi.io/api/XAU/BTC";
      String url2 = "https://www.goldapi.io/api/XAG/BTC";
      String url3 = "https://www.goldapi.io/api/XPT/BTC";
      String url4 = "https://www.goldapi.io/api/XPD/BTC";
      await get(url1, headers: headers).then((value) {
        responceList.add(value);
        return get(url2, headers: headers).then((value) {
          responceList.add(value);
          return get(url3, headers: headers).then((value) {
            responceList.add(value);
            return get(url4, headers: headers).then((value) {
              responceList.add(value);
            }).catchError((error) => print(error));
          }).catchError((error) => print(error));
        }).catchError((error) => print(error));
      }).catchError((error) => print(error));
      print("first = $responceList");
      responceList.forEach((element) {
        metalslist.add(element.body);
      });
      return metalslist;
    }
    else return metalslist;
  }
}
