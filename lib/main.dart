import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_blog_hive/http_service/http_service.dart';
import 'package:task_blog_hive/modal/blog_data_modal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return const MaterialApp(
        home: HomePage(),
      );
    });
  }
}

extension DateTimeExtension on DateTime {
  String timeAgo() {
    DateTime now = DateTime.now();
    Duration difference = now.difference(this);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BlogDataModal? blogData;
  bool isLoading = true;
  String? error;

  String parseContent(String? text) {
    if (text == null || text.isEmpty) return 'No content';

    String cleaned = text.replaceAll(RegExp(r'\!\[.*?\]'), '');

    cleaned = cleaned.replaceAll(RegExp(r'\[.*?\]'), '');

    cleaned = cleaned.replaceAll(RegExp(r'\(https?:\/\/\S+\)'), '');

    cleaned = cleaned.replaceAll(RegExp(r'https?:\/\/\S+'), '');

    cleaned = cleaned.replaceAll(RegExp(r'<[^>]*>'), '');

    cleaned = cleaned.replaceAll(RegExp(r'\s+'), ' ').trim();

    return cleaned.isEmpty ? 'No content' : cleaned;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      String apiUrl = 'https://api.hive.blog/';

      Map<String, dynamic> bodyData = {
        "id": 1,
        "jsonrpc": "2.0",
        "method": "bridge.get_ranked_posts",
        "params": {"sort": "trending", "tag": "", "observer": "hive.blog"}
      };

      String body = jsonEncode(bodyData);

      Map<String, String> headers = {
        "accept": "application/json, text/plain, */*",
        "Content-type": "application/json"
      };

      Response? response = await HttpService.postAPI(
        apiURL: apiUrl,
        body: body,
        headers: headers,
      );

      if (response?.statusCode == 200) {
        setState(() {
          blogData = BlogDataModal.fromJson(jsonDecode(response!.body));
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load posts';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  Widget buildLoadingState() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 8,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 7.px,
              horizontal: 20.px,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.px),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(5.px),
                child: Row(
                  children: [
                    Shimmer(
                      gradient: const LinearGradient(
                          colors: [Colors.white, Colors.grey, Colors.white]),
                      child: Container(
                        color: Colors.white,
                        height: 80.px,
                        width: 100.px,
                      ),
                    ),
                    SizedBox(width: 8.px),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.grey,
                            Colors.white
                          ]),
                          child: Container(
                            height: 15.px,
                            width: 150.px,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.px),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.px),
                        Shimmer(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.grey,
                            Colors.white
                          ]),
                          child: Container(
                            height: 15.px,
                            width: 150.px,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.px),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.px),
                        Shimmer(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.grey,
                            Colors.white
                          ]),
                          child: Container(
                            height: 15.px,
                            width: 150.px,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.px),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error ?? 'An error occurred',
            style: TextStyle(color: Colors.red, fontSize: 16.px),
          ),
          SizedBox(height: 16.px),
          ElevatedButton(
            onPressed: fetchData,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget buildPostsList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        vertical: 0.px,
        horizontal: 20.px,
      ),
      itemCount: blogData?.result?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final post = blogData?.result?[index];
        if (post == null) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 7.px),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.px),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.px,
                    vertical: 5.px,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${post.author}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.px,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          post.communityTitle != null
                              ? ' in ${post.communityTitle}'
                              : ' in #hive',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.px,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        ' • ${DateTime.parse(post.created ?? '').timeAgo()}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.px,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.px,
                    right: 10.px,
                    bottom: 5.px,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildPostImage(post, index),
                      SizedBox(width: 5.px),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              parseContent(post.title) ?? 'No title',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              parseContent(post.body) ?? 'No content',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up_outlined,
                                  color: Colors.grey,
                                  size: 15.px,
                                ),
                                SizedBox(width: 5.px),
                                Text('${post.stats?.totalVotes ?? 0}'),
                                SizedBox(width: 15.px),
                                Icon(
                                  Icons.comment_outlined,
                                  color: Colors.grey,
                                  size: 15.px,
                                ),
                                SizedBox(width: 5.px),
                                Text('${post.children ?? 0}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPostImage(dynamic post, int index) {
    final hasValidImage = post.jsonMetadata?.image != null &&
        post.jsonMetadata?.image?.isNotEmpty == true;

    return Image.network(
      hasValidImage
          ? post.jsonMetadata!.image![0]
          : 'https://picsum.photos/536/35$index',
      width: 100.px,
      height: 80.px,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 100.px,
          height: 80.px,
          color: Colors.grey,
          child: const Icon(Icons.error, color: Colors.white),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.grey,
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 15.px,
                    top: 15.px,
                  ),
                  child: Text(
                    'All posts',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.px,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: isLoading
                        ? buildLoadingState()
                        : error != null
                            ? buildErrorState()
                            : buildPostsList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
