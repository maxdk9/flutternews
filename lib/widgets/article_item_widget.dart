import 'package:flutter/material.dart';
import 'package:flutternews/model/article.dart';
import 'package:flutternews/screens/webview_screen.dart';
import 'package:flutternews/theme/constants.dart';

class ArticleItemWidget extends StatefulWidget {
  const ArticleItemWidget({
    Key? key,
    required this.article,
    required this.changeArticleFavorites,
    //required this.SetFavorite
  }) : super(key: key);
  final Article article;
  final Function changeArticleFavorites;
  @override
  _ArticleItemWidgetState createState() => _ArticleItemWidgetState();
}

class _ArticleItemWidgetState extends State<ArticleItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 5))
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Container(
                  child: Image.network((widget.article.urlToImage == null ||
                          widget.article.urlToImage.isEmpty)
                      ? UrlImageNotFound
                      : widget.article.urlToImage),
                  height: 130,
                  width: 130,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.article.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.article.publishedAt.substring(0, 10),
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.article.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                print('11');
                Navigator.pushNamed(context, WebviewScreen.id,
                    arguments: widget.article);
              },
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: MaterialButton(
                height: 20,
                minWidth: 20,
                onPressed: onPressedFavorites,
                child: Icon(
                  Icons.favorite,
                  color: this.widget.article.favorite
                      ? Colors.yellow
                      : Colors.grey,
                ),
              )),
        ],
      ),
    );
  }

  void onPressedFavorites() {
    this.widget.article.favorite = !this.widget.article.favorite;
    this.widget.changeArticleFavorites(this.widget.article);
    setState(() {});
  }
}
