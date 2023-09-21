// Bloc Pattern for the feed.
// STEP-1: Imports
// STEP-2: List of Feeds
// STEP-3: Stream controller
// STEP-4: Stream sink getter
// STEP-5: Constructor - Add Likes, Listen to the changes
// STEP-6: Core functions
// STEP-7: Dispose
//Stream Is Already Been Cooked In Flutter

import 'dart:async';

class Feed {
  int? id, type;
  bool likes, isSaved;
  String feedId,
      title,
      description,
      category,
      subcategory,
      time,
      name,
      avatarImg,
      bannerImg,
      location,
      comments,
      members;

  Feed(
      {this.id,
      required this.feedId,
      required this.type,
      required this.title,
      required this.description,
      required this.category,
      required this.subcategory,
      required this.time,
      required this.name,
      required this.avatarImg,
      required this.bannerImg,
      required this.location,
      required this.likes,
      required this.comments,
      required this.members,
      required this.isSaved});
}

class QuestionModel {
  String question;

  QuestionModel({required this.question});
}

class Category {
  bool isSelected = false;
  String categoryType;

  Category({required this.categoryType});
}

class FeedBloc {
  List<Feed> feedList = [
    Feed(
        feedId: "1",
        type: 0,
        title: 'Prani Kumar',
        isSaved: true,
        description:
            'Information Technology (IT) Hub: Hyderabad is often referred to as "Cyberabad" due to its significant presence in the IT and technology industry...',
        category: '',
        subcategory: '',
        time: '',
        name: 'What is the condition of real estate in hyderabad?',
        avatarImg: 'https://www.w3schools.com/w3images/avatar1.png',
        bannerImg: 'https://www.w3schools.com/w3images/avatar1.png',
        location: '',
        likes: false,
        comments: '24',
        members: '24'),

  ];

  // 2. Stream controller
  final _feedListStreamController = StreamController<List<Feed>>();
  final _feedLikeIncrementController = StreamController<Feed>();
  final _feedLikeDecrementController = StreamController<Feed>();

  // 3. Stream Sink Getter
  Stream<List<Feed>> get feedListStream => _feedListStreamController.stream;
  StreamSink<List<Feed>> get feedListSink => _feedListStreamController.sink;

  StreamSink<Feed> get feedLikeIncrement => _feedLikeIncrementController.sink;
  StreamSink<Feed> get feedLikeDecrement => _feedLikeDecrementController.sink;

 

 
}
