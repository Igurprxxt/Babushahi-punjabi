// TODO: Ask API from the their developer
import 'package:dio/dio.dart';
import '../models/news.dart';

class TopNews {
  static Future<List<News>> fetch() async {
    // This method returns the top news
    final dio = Dio();
    late final List<News> news;
    try {
      final response = await dio.get(
          'https://www.babushahi.in/appapi/topnews.php?secretkey=Z3sEuW4!a5NZ');
      if (response.statusCode == 200) {
        final data = response.data;
        news = data.map<News>((json) => News.fromJson(json)).toList();
        return news;
      } else {
        // TODO: Handle this error
        print('200 nhi aay bro');
        throw Exception('Failed to load news, non 200 status code');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load news, failed to make API call');
    }
  }
}
