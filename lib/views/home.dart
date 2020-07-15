import 'package:big_news/helper/data.dart';
import 'package:big_news/helper/news.dart';
import 'package:big_news/models/Category_models.dart';
import 'package:big_news/models/article_model.dart';
import 'package:big_news/views/arcticle_view.dart';
import 'package:big_news/views/category_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Categorymodel>  categories =new List<Categorymodel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  //var articles;
  @override
  void initState() {
    
    
    super.initState();
    categories=getcategories();
    getNews();

  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles=newsClass.news;
    //_loading=true;

    setState(() {
      _loading= false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Big'),
            Text('News', style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w800
            ),
            )
          ],
        ),
        elevation: 0.0,
      ),
      
      body: _loading ? Center(
        child: Container(
          
          child: CircularProgressIndicator(),
        ),
      )
       : SingleChildScrollView(
        child: Container(
         //color: Colors.grey,
          child:Column(
   
            children: <Widget>[
              //Categories 

              Container(
                padding: EdgeInsets.symmetric(horizontal:16),
                height: 70.0,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context ,index){
                    return CategoryTitle(
                      imageUrl: categories[index].imageURL,
                      categoeyName: categories[index].categoryName,
                    );
                  }
                ),
              ),

              //Blogs
              
              Container(
                padding: EdgeInsets.only(top:16.0),
                color: Colors.grey[100],
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


class CategoryTitle extends StatelessWidget {

final String imageUrl, categoeyName;
CategoryTitle({this.imageUrl,this.categoeyName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>CategoryView(
            category:categoeyName.toLowerCase(),
          )
          ));

      },
          child: Container(
        margin: EdgeInsets.only(right:15),
        child: Stack(
          children: <Widget>[
            ClipRRect
              (borderRadius: BorderRadius.circular(6),              
                child: CachedNetworkImage
                (imageUrl:imageUrl, height: 60.0, width: 120.0, fit: BoxFit.cover,)
                ),
                Container(
                  alignment: Alignment.center,
                  height: 60.0, width: 120.0, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black38,
                  ),
                  child: Text(categoeyName, style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600
                  ),
                ),
              )
            ],
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
    