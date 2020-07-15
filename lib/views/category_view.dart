

import 'package:big_news/helper/news.dart';
import 'package:big_news/models/article_model.dart';
import 'package:big_news/views/arcticle_view.dart';
import 'package:flutter/material.dart';

import 'arcticle_view.dart';

class CategoryView extends StatefulWidget {
final String category;
CategoryView({this.category});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading=true;



  @override
  void initState() {
    
    super.initState();
    getCategoryNews();
  }
   getCategoryNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles=newsClass.news;
        setState(() {
      _loading= false;
    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Big'),
            Text('News', style: TextStyle(
              color: Colors.blue
            ),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
              child: Container(
              padding:EdgeInsets.symmetric(horizontal:16),
              child: Icon(Icons.save)),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      )
       : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:5),
          child: Column(
            children: <Widget>[
              //Blogs
                
                Container(
                  padding: EdgeInsets.only(top:16.0),
                  child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    //scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      return BlogTitle(
                        imageurl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                      );

                    }),
                
                )

            ],
            ),
            ),
       ),
      
    );
  }
}


class BlogTitle extends StatelessWidget {

    final String imageurl,title,desc,url;
    BlogTitle({@required this.url,@required this.imageurl,@required this.desc,@required this.title});

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ArticleView(
              blogUrl: url,

            )
          )
          );
        },
              child: Container(
          color: Colors.white70,
          margin: EdgeInsets.only(bottom:16),
          child: Column(
            
           
            children:<Widget>[
                Padding(padding: EdgeInsets.symmetric(horizontal:16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(imageurl),
                  ),
                ),
                SizedBox(height: 8,
                  ),
                Padding( 
                  padding: EdgeInsets.symmetric(horizontal:16),
                    child: Text(title,style: TextStyle(
                    
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(desc,style: TextStyle(
                    color:Colors.black87
                  ),
                  ),
                )
              ]
            ),
         ),
      );
      }

    }
    