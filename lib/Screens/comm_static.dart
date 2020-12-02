import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommStatic extends StatefulWidget {
  @override
  _CommStaticState createState() => _CommStaticState();
}

class _CommStaticState extends State<CommStatic> {
  void openBrowser() async {
    final url =
        'https://medium.com/startupsco/the-full-list-of-400-slack-communities-5545e82cf65d';
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Teleporting you to medium site',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(
          seconds: 2,
        ),
      ),
    );
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
        webOnlyWindowName: url,
        enableDomStorage: true,
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Looks like the medium url has moved',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'StudGO',
          style: TextStyle(
              color: Colors.green[600],
              fontSize: 31,
              fontFamily: 'MavenPro',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Community Forum',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/cm1.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'A Community Forum is an online “meeting place” that is used to engage with others to debate, share knowledge and communicate with others about a wide range of topics participants are interested in discussing.As it relates to customer experience, a Community Forum is a type of self-service support where customers can find a resolution to their problems without having to contact a customer service agent. As the saying goes, the best number of contacts is zero. Customers want to solve questions themselves. \n An online community forum is an online space created by an organization or a brand, where members, customers and fans alike can congregate, ask questions, receive peer-to-peer support, discuss interests surrounding the brand and make social connections.  ',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Is an Online Community Forum Right for You?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Now, the million dollar question. You know the ins and outs of community and the number of benefits that it brings to the table. So, is it right for you? Is it something that your organization needs? \nYes, absolutely. \nWhile we may be a bit bias, being aware of the massive benefits that a community can bring to an organization will do that to you! \nNow, while the size of your organization and customer base might play a role in the type of platform that you select for your community, there are a number of other factors that should also be taken into consideration when making your decision. \nThese factors can all be summed into one question: how much control do you want to have over your community?\nEssentially, the more control you have over your community, the more likely that your community will be able to thrive and fulfill its purpose, as discussed in the previous section. When you select a social media platform for your community, there is an inherent lack of control over a number of different factors, including:',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/cm2.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '• Culture',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '• Design',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	• Privacy',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	•	Authenticity',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Social media communities only allow for so much customization, and ultimately, they don’t give you the tools you need to make your community an extension of your brand personality. This is something that most organizations care about since it’s their brand personality that attracts customers in the first place.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'How To Connect And Share Your Knowledge Through Online Communities And Forums',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Online communities and forums provide learners with a platform to share their thoughts, have healthy discussions, get feedback, clarify their questions, and learn new, industry-relevant information. It provides an avenue for like-minded people to connect and share knowledge.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/cm3.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'First of all, let’s understand the difference between online communities and forums. Online communities are platforms where questions will be asked, and members can answer. Forums are more like discussion groups where people speak their opinions and share information. The thread of questions and answers, and discussions will be visible for anyone to see. Sometimes, they will be visible only to members. A majority of these online communities and forums are free to use. Anyone can create an account, ask and answer questions, and participate in discussions',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '•	Top Programming Communities for Developers & Hackers In 2020',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/cm6.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '•	Different Communites',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	1. StackOverFlow: 	StackOverflow is an absolute must as a programmer community for anyone who is serious about web development.\mSince its founding in 2008, it’s been the go-to sites for over 4.7 million developers. It is without a doubt one of the best places to find an answer to pretty much any coding question.\mThe site has a carrot and stick approach that works well. They reward users who answer questions often and do so thoughtfully. StackOverflow also helps ensure this by suspending users who demonstrate any unhelpful behaviour. You can rest assured that you are receiving top notch advice anytime you are looking for help.The only drawback to this programming community is that there is so much going on, it can be daunting for the novice coder. Take your time, spend a little while lurking and reading and then jump in when you’re ready. The community is a friendly bunch.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/sof.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	2.Quora : 	Quora is a top-ranked question and answering community that can form the basis of a successful marketing campaign. This is how to do it.\nQuora is not only a highly ranked question and answer community, it’s one of the top online destinations in the world.\nThis makes it a great place to begin the process of making a site popular and improving rankings and traffic.\n\nHow Does Quora Work?\nQuora is an online community of people providing answers to questions.\nPeople from around the world visit Quora to ask questions from a community of people who answer them.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/quora.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	3. Reddit:	Reddit is a community-determined aggregator of content.\nIt is a social platform where users submit posts that other users ‘upvote’ or ‘downvote’ based on if they like it. If a post gets lots of upvotes it moves up the Reddit rankings so that more people can see it. If it gets downvotes it quickly falls and disappears from most people’s view.Reddit is split out into sub-communities, or subreddits. They can be created by any user around any subject, whether it’s something broad like technology, or as specific as a single joke. Each subreddit feeds into the full Reddit list of submissions meaning a post in any subreddit (unless it’s private) could reach the front page of the website.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/reddit.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	4.Medium:	 Medium is an American online publishing platform developed by Evan Williams and launched in August 2012. It is owned by A Medium Corporation.[2] The platform is an example of social journalism, having a hybrid collection of amateur and professional people and publications, or exclusive blogs or publishers on Medium, and is regularly regarded as a blog host.\nThe platform software provides a full WYSIWYG user interface when editing online, with various options for formatting provided as the user edits over rich text format.\nOnce an entry is posted, it can be recommended and shared by other people, in a similar manner to Twitter. Posts can be upvoted in a similar manner to Reddit, and content can be assigned a specific theme, in the same way as Tumblr.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/medium.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	5.Kaggle:	 Kaggle, a subsidiary of Google LLC, is an online community of data scientists and machine learning practitioners. Kaggle allows users to find and publish data sets, explore and build models in a web-based data-science environment, work with other data scientists and machine learning engineers, and enter competitions to solve data science challenges.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/kaggle.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	The Full List of 400 Slack Communities',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: openBrowser,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'https://medium.com/startupsco/the-full-list-of-400-slack-communities-5545e82cf65d',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
