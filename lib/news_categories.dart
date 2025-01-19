// This file stores the global state of news categories
// This is created due to change in the client requirement for the tab very frequently.
// So creating a global list of tabs and then using it in the tab bar and tab bar view and the choose interest page

import 'package:flutter/material.dart';
import 'screens/home.dart';

final Map<String, String> _newsChoices = <String, String>{
  // The keys are to be shown in the Ui, the values to used for api calls
  // NOTE: If change the length of this list, then also change the length of the _tabController in HomeTab
  'ਕਰੰਟ ਖਬਰ': 'currentnews',
  // 'Regional Briefs': '',
  'ਐਜੂਕੇਸ਼ਨ-ਕੈਰੀਅਰ': 'education',
  'ਨਵੇਂ ਟਰੈਂਡਜ': 'trends',
  'ਤਬਾਦਲੇ/ ਬਦਲੀਆਂ': 'transfers',
  'ਮਨ ਪਰਚਾਵਾ': 'entertainment',
  'ਬਿਜ਼ਨਸ ਜਗਤ': 'business',
  'ਸਿਹਤ / ਸਪੋਰਟਸ': 'sports',
  'ਦੇਸ਼-ਦੁਨੀਆ': 'worldnews',
  'ਕੀ ਤੁਹਾਨੂੰ ਪਤਾ ਹੈ ?': 'doyouoknow',
  'ਬਾਬੂਸ਼ਾਹੀ ਡਾਟਾ ਬੈਂਕ': 'databank',
  'ਸ਼ਖ਼ਸੀਅਤ / ਇੰਟਰਵਿਊ': 'personality',
  'ਵੀਡੀਓ ਗੈਲਰੀ': 'videogallery',
  'ਕਿਤਾਬਾਂ - ਸਾਹਿਤ': 'books',
  'ਬਲੌਗਜ਼ / ਓਪੀਨੀਅਨ': 'blogs',
  'ਰਿਜਨਲ ਖ਼ਬਰਾਂ': 'regionalnews'
  // 'Health and Fitness': '',
};

Map<String, String> get newsChoices => _newsChoices;

List<Tab> tabBarHeaders() {
  // This returns the list of Tabs for the tab bar
  List<Tab> _tabBarViewTabs = [
    // First TabView is the home tab that shows user interest news
    const Tab(text: 'Home'),
  ];
  _newsChoices.forEach((key, value) {
    _tabBarViewTabs.add(Tab(
      text: key,
    ));
  });

  return _tabBarViewTabs;
}

List<Widget> tabBarViews({String? searchKeyword}) {
  // This returns the list of Tabs for the tab bar
  List<Widget> tabBarViewTabs = [];

  tabBarViewTabs.add(const HomeTab());

  _newsChoices.forEach((key, value) {
    tabBarViewTabs.add(
      CategoryHomeTab(newsCategory: value),
    );
  });

  return tabBarViewTabs;
}
