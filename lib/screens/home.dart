// This is the main page where the user can see the news feed.
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../DataStore/category_cache.dart';
import '../controllers/category_news.dart';
import '../controllers/top_news.dart';
import '../controllers/user_interest_news.dart';
import '../models/news.dart';
import '../news_categories.dart';
import '../widgets/loading.dart';
import '../widgets/news_list.dart';
import '../widgets/news_slider.dart';
import '../news_categories.dart' as newsCategories;
import 'menu.dart';

// Creating cache Outside the class to avoid reinitialization on every build
final CategoryNewsDataCache cache = CategoryNewsDataCache();

class HomePage extends StatefulWidget {
  final newTabIndex;
  const HomePage({super.key, this.newTabIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // generate tabs form global data file
  List<Tab> topTabs = newsCategories.tabBarHeaders();

  Future<void> _openSocials(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void _launchAppStore() async {
    final String url = Platform.isAndroid
        ? 'https://play.google.com/store/apps/details?id=com.babushahi.english&hl=en'
        : 'https://apps.apple.com/in/app/babushahi-english/id1242727658';
    print(url);
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  final List<Widget> _tabBarViewTabs = newsCategories.tabBarViews();

  late final _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 16,
      vsync: this,
    );
    const oneSec = Duration(seconds: 200);
    Timer.periodic(oneSec, (Timer t) {
      print('Timer chal rha hai');
      cache.clearCache();
      // Clearing whole state as the top slider is not cached
      setState(() {
        _HomePageState;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.newTabIndex != null) {
      // Check if the tab index is -1
      if (widget.newTabIndex != -1) {
        // Doing this to avoid the error of tab index out of range, although this error must not occur
      }

      if (_tabController.index < topTabs.length - 1) {
        // Scroll to the next tab
        _tabController.animateTo(widget.newTabIndex);
      }
    } else {
      // print("null aaya");
    }
    return DefaultTabController(
      length: 16,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE8ECF0),
          toolbarHeight: 100,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/babushahi-icon-punjabi.png',
                    height: 40,
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials(
                          'https://www.facebook.com/BabushahiDotCom?mibextid=ZbWKwL');
                    },
                    child: Image.asset(
                      'assets/images/facebook_logo.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials(
                          'https://youtube.com/@BabushahiTimesNetwork');
                    },
                    child: Image.asset(
                      'assets/images/youtube_logo.png',
                      height: 50,
                      width: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials(
                          'https://twitter.com/Babushahikhabar?t=vmvHfBOTjZ7Q0JQPueyFVw&s=09');
                    },
                    child: Image.asset(
                      'assets/images/twitter_logo.png',
                      height: 27,
                      width: 27,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials(
                          'https://www.instagram.com/invites/contact/?i=1szcho49tfws8&utm_content=hfkvq2y');
                    },
                    child: Image.asset(
                      'assets/images/instagram_logo.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials('https://t.me/babushahitimes');
                    },
                    child: Image.asset(
                      'assets/images/telegram_logo.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials('');
                    },
                    child: GestureDetector(
                      child: Image.asset(
                        'assets/images/linkedin_logo.png',
                        height: 30,
                        width: 30,
                      ),
                      onTap: () {
                        _openSocials(
                            'https://www.linkedin.com/in/baljit-balli-69017b20');
                      },
                    ),
                  ),
                  GestureDetector(
                    // TODO: Add link to babshai english app
                    onTap: _launchAppStore,
                    child: Image.asset(
                      'assets/images/babushahi-icon-english.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
              Container(
                width: 160,
                height: 30,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _openSocials('https://www.babushahihindi.com');
                    },
                    child: Image.asset(
                      'assets/images/babushahi_hindi.gif',
                      width: 160,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              )
            ],
          ),
          bottom: AppBar(
            elevation: 0,
            bottomOpacity: 0,
            backgroundColor: const Color(0xffE8ECF0),
            title: TabBar(
              controller: _tabController,
              tabs: topTabs,
              isScrollable: true,
              indicatorColor: const Color(0xff1A52C2),
              labelColor: const Color(0xff1A52C2),
              unselectedLabelColor: const Color(0xffE31D1D),
            ),
            leading: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Menu()));
              },
            ),
            actions: [
              // Added scroll icon, that will scroll few the tabs on click
              IconButton(
                onPressed: () {
                  // Check if the tab index is less than the total number of tabs
                  if (_tabController.index < topTabs.length - 1) {
                    // Scroll to the next tab
                    _tabController.animateTo(_tabController.index + 1);
                  }
                  // _tabController.animateTo(_tabController.index + 1);
                },
                iconSize: 20,
                splashRadius: 30,
                icon: const Icon(
                  // size: 10,
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 251,
              child: FutureBuilder<List<News>>(
                  future: TopNews.fetch(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(snapshot.data);
                      return newsSlider(context: context, data: snapshot.data!);
                    }
                    if (snapshot.hasError) {
                      return const Text('An Unexpected error Occurred');
                    } else {
                      // Showing Shimmer loading effect while fetching data from API
                      return newsTopLoadingWidget();
                    }
                  }),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _tabBarViewTabs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  // This Widget shows User preference news
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _HomePageState;
        });
      },
      child: Column(
        children: [
          // Padding(
          //   padding:
          //       const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: const [
          //       Icon(
          //         Icons.home,
          //         color: Colors.black54,
          //         size: 35,
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            child: FutureBuilder<List<News>>(
                future: UserInterestNews.fetch(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return newsList(snapshot.data!);
                  }
                  if (snapshot.hasError) {
                    return const Text('An Unexpected error Occurred');
                  } else {
                    return newsListLoadingWidget();
                    // return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class CategoryHomeTab extends StatefulWidget {
  // This Widget shows
  // - category wise news (category to be passed as a param)
  const CategoryHomeTab({super.key, required this.newsCategory});
  final String newsCategory;
  @override
  State<CategoryHomeTab> createState() => _CategoryHomeTabState();
}

class _CategoryHomeTabState extends State<CategoryHomeTab> {
  @override
  Widget build(BuildContext context) {
    String _getNewsCategoryFullName(name) {
      // This method return the user friendly and readable name of the category
      return newsChoices.entries
          .firstWhere((element) => element.value == name)
          .key;
    }

    return RefreshIndicator(
      onRefresh: () async {
        print("Success");
        setState(() {
          _HomePageState;
        });
      },
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // widget.newsCategory.toString(),
                  _getNewsCategoryFullName(widget.newsCategory),
                  style: const TextStyle(
                    color: Color(0xffE31D1D),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: cache.getData(widget.newsCategory, context),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return newsList(snapshot.data!);
                  }
                  if (snapshot.hasError) {
                    return const Text('An Unexpected error Occurred');
                  } else {
                    return newsListLoadingWidget();
                    // return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class SearchTab extends StatefulWidget {
  const SearchTab(this.searchKeyword, {super.key});
  final String searchKeyword;

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Search Results',
                style: TextStyle(
                  color: Color(0xffE31D1D),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
