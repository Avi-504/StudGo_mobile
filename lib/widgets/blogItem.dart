import 'package:StudGo/Screens/Blogs.dart';
import 'package:StudGo/Screens/comments.dart';
import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/Screens/likescreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogItem extends StatefulWidget {
  final String author;
  final String blogID;
  final String blogWriter;
  final String content;
  final Map likes;
  final String photo;
  final String tags;
  final String title;
  final String timeAgo;
  BlogItem({
    this.blogID,
    this.blogWriter,
    this.content,
    this.likes,
    this.photo,
    this.tags,
    this.title,
    this.author,
    this.timeAgo,
  });
  @override
  _BlogItemState createState() => _BlogItemState();
}

class _BlogItemState extends State<BlogItem> {
  var likescount;
  var delete = false;
  int getLikesCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((value) {
      if (value) {
        count += 1;
      }
    });
    return count;
  }

  Widget blogHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(widget.photo),
        backgroundColor: Colors.transparent,
      ),
      title: GestureDetector(
        onTap: () => () {},
        child: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: Text(
        widget.timeAgo,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void handleLikePost() {
    var _isLiked = widget.likes[currentUser.email] == true;
    if (_isLiked) {
      setState(() {
        likescount -= 1;
        widget.likes[currentUser.email] = false;
      });
      blogref.document(widget.blogID).updateData({
        'likes': widget.likes,
      });
    } else if (!_isLiked) {
      setState(() {
        likescount += 1;
        widget.likes[currentUser.email] = true;
      });
      blogref.document(widget.blogID).updateData({
        'likes': widget.likes,
      });
    }
  }

  void deleteBlog(
      {String title = 'Are you Sure?',
      String content = 'Do you want to delete this blog?'}) async {
    var blogOwner = widget.blogWriter == currentUser.email;
    if (!blogOwner) {
      return;
    }
    delete = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Yes'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('No'),
          ),
        ],
      ),
    );
    if (delete == (null)) {
      return;
    } else if (delete == false) {
      return;
    } else {
      await commentRef.document(widget.blogID).delete();
      await blogref.document(widget.blogID).delete();
    }
  }

  Widget blogFooter() {
    likescount = getLikesCount(widget.likes);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: GestureDetector(
                  onTap: handleLikePost,
                  child: Icon(
                    Icons.favorite,
                    size: 28,
                    color: Colors.red,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 30),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Comments(
                    blogID: widget.blogID,
                  ),
                )),
                child: Icon(
                  Icons.mode_comment,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: likescount == 0
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LikeScreen(
                                blogid: widget.blogID,
                              )));
                    },
              child: Container(
                margin: EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  '$likescount likes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 20,
                top: 2,
              ),
              child: Text(
                widget.author,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Expanded(
              child: Text(
                widget.tags,
                softWrap: true,
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget blogBody() {
    return GestureDetector(
      onLongPress: deleteBlog,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.content}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        blogHeader(),
        blogBody(),
        blogFooter(),
        Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
