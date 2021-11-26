import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_bili_f/db/hi_cache.dart';
import 'package:my_bili_f/http/core/hi_error.dart';
import 'package:my_bili_f/http/core/hi_net.dart';
import 'package:my_bili_f/http/request/test_request.dart';

import 'model/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _counter = 0;

  @override
  void initState() {
    super.initState();
    HiCache.preInit();
  }

  test() {
    var jsonStr =
        "{ \"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";
    print('jsonStr: ${jsonStr is String}');
    Map<dynamic, dynamic> res = jsonDecode(jsonStr);
    print('name: ${res['name']}');
    print('url: ${res['url']}');
  }

  test1() {
    var ownerMap = {
      "name": "Dendid",
      "face": "https://www.baidu.com",
      "fans": 123,
      "userInfo": {
        "name": "iron man",
        "age": 90,
      }
    };
    print(ownerMap is Map);
    // Owner res = Owner.fromJson(ownerMap);
    Result res = Result.fromJson(ownerMap);
    print('owner: ${res.name}');
    print('owner: ${res.face}');
    print('owner: ${res.fans}');
    print('owner: ${res.userInfo.name}');
    print('owner: ${res.userInfo.age}');
  }

  void test2() {
    HiCache.getInstance()!.setString('aa', '1234');
    var val = HiCache.getInstance()!.get('aa');
    print(val);
  }

  void _incrementCounter() async {
    TestRequest request = TestRequest();
    request
        .add('name', '卡布奇诺')
        .add('password', '123456')
        .addHeader('connectTimeout', 50 * 1000)
        .addHeader('receiveTimeout', 50 * 1000)
        .addHeader("contentType", "application/json");
    try {
      var result = await HiNet.instance.fire(request);
      print('main: ${result}');
    } on NeedAuth catch (e) {
      print(e);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    // jsonDecode 将字符串转成
    // test();
    // test1();
    test2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
