import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  static const routeName = 'webview';

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen>
    with SingleTickerProviderStateMixin {
  String src = 'https://www.incryptoplus.com/secure/dashboard';
  int currentTab = 0;
  bool isLoading = false;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController controllerGlobal;
  AnimationController _animationController;
  Animation<double> _animation;
  AnimationStatus animationStatus = AnimationStatus.dismissed;
  bool isBottomNavOpened = false;

  void _selectTab(int index) {
    if (index != currentTab) {
      _animationController.repeat();
      setState(() {
        currentTab = index;
        isLoading = true;
      });
      switch (index) {
        case 0:
          controllerGlobal
              .loadUrl('https://www.incryptoplus.com/secure/dashboard');
          break;
        case 1:
          controllerGlobal
              .loadUrl('https://www.incryptoplus.com/secure/deposits');
          break;
        case 2:
          controllerGlobal
              .loadUrl('https://www.incryptoplus.com/secure/earnings');
          break;
        case 3:
          controllerGlobal
              .loadUrl('https://www.incryptoplus.com/secure/withdrawals');
          break;
        case 4:
          controllerGlobal
              .loadUrl('https://www.incryptoplus.com/secure/tickets');
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animation = Tween<double>(end: 1, begin: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        animationStatus = status;
      });
    Future.delayed(Duration.zero, () async {
      _animationController.repeat();
      setState(() {
        isLoading = true;
      });

      /*await _animationController.forward();
      await _animationController.reverse();
      await _animationController.forward();
      await _animationController.reverse();
      await _animationController.forward();
      await _animationController.reverse();*/
    });
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  Future<bool> _willPopCallback() async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      _animationController.repeat();
      setState(() {
        isLoading = true;
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: src,
              onWebViewCreated: (WebViewController webViewController) {
                controllerGlobal = webViewController;
                _controller.complete(webViewController);
              },
              navigationDelegate: (NavigationRequest request) async {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  return NavigationDecision.prevent;
                }
                if (request.url.startsWith('https://api.whatsapp.com') ||
                    request.url.startsWith('mailto:?')) {
                  await launchUrl(request.url);
                  return NavigationDecision.prevent;
                }
                if (request.url
                    .startsWith('https://www.incryptoplus.com/secure/dashboard')||request.url
                    .startsWith('https://www.incryptoplus.com/secure/deposits')||request.url
                    .startsWith('https://www.incryptoplus.com/secure/earnings')||request.url
                    .startsWith('https://www.incryptoplus.com/secure/withdrawals')||request.url
                    .startsWith('https://www.incryptoplus.com/secure/tickets')) {
                  setState(() {
                    isBottomNavOpened = true;
                  });
                } else {
                  setState(() {
                    isBottomNavOpened = false;
                  });
                }
                print('allowing navigation to $request');
                _animationController.repeat();
                setState(() {
                  isLoading = true;
                });
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
                if (url
                    .startsWith('https://www.incryptoplus.com/secure/dashboard')||url
                    .startsWith('https://www.incryptoplus.com/secure/deposits')||url
                    .startsWith('https://www.incryptoplus.com/secure/earnings')||url
                    .startsWith('https://www.incryptoplus.com/secure/withdrawals')||url
                    .startsWith('https://www.incryptoplus.com/secure/tickets')) {
                  setState(() {
                    isBottomNavOpened = true;
                  });
                } else {

                setState(() {
                    isBottomNavOpened = false;
                  });
                }
                if (url.startsWith(
                    'https://www.incryptoplus.com/secure/dashboard')) {
                  setState(() {
                    currentTab = 0;
                  });
                } else if (url.startsWith(
                    'https://www.incryptoplus.com/secure/deposits')) {
                  setState(() {
                    currentTab = 1;
                  });
                } else if (url.startsWith(
                    'https://www.incryptoplus.com/secure/earnings')) {
                  setState(() {
                    currentTab = 2;
                  });
                } else if (url.startsWith(
                    'https://www.incryptoplus.com/secure/withdrawals')) {
                  setState(() {
                    currentTab = 3;
                  });
                } else if (url.startsWith(
                    'https://www.incryptoplus.com/secure/tickets')) {
                  setState(() {
                    currentTab = 4;
                  });
                }
              },
              onPageFinished: (String url) {
                _animationController.stop();
                setState(() {
                  isLoading = false;
                });
                print('Page finished loading: $url');
              },
              gestureNavigationEnabled: true,
              // TODO(iskakaushik): Remove this when collection literals makes it to stable.
              // ignore: prefer_collection_literals
              javascriptChannels: <JavascriptChannel>[
                _toasterJavascriptChannel(context),
              ].toSet(),
            ),
            Visibility(
              visible: isLoading,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: isLoading? 1:0,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          child: Center(
                              child: Image.asset(
                            'assets/images/logo.png',
                            width: MediaQuery.of(context).size.width * 0.24,
                          )),
                        ),
                        SizedBox(
                          width:  MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          child: CircularProgressIndicator(
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Visibility(
          visible: isBottomNavOpened,
          child: BottomNavigationBar(
            onTap: _selectTab,
            currentIndex: currentTab,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Theme.of(context).primaryColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.dashboard_rounded),
                  icon: Icon(Icons.dashboard_outlined),
                  label: 'Dashboard'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.monetization_on_rounded),
                  icon: Icon(Icons.monetization_on_outlined),
                  label: 'Investments'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.account_balance_wallet_rounded),
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  label: 'Earnings'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.money_rounded),
                  icon: Icon(Icons.money),
                  label: 'Withdrawal'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.mail),
                  icon: Icon(Icons.mail_outline_rounded),
                  label: 'Help Desk'),
            ],
          ),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Cannot launch this Url')),
      );
    }
  }
}
