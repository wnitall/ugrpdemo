import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shorts',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    ShortsScreen(),
    UserProfileScreen(),
    Text('지도 화면'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Shorts'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '쇼츠',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '계정',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '지도',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ShortsScreen extends StatefulWidget {
  @override
  _ShortsScreenState createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  late List<VideoPlayerController> _controllers = [];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Dummy video list. 실제 앱에서는 동적으로 리스트를 구성해야 합니다.
    _pageController = PageController();
    _controllers = [
      VideoPlayerController.asset('assets/videos/video1.mp4')
        ..initialize().then((_) {
          setState(() {});
          _controllers[0].play();
        }),
      VideoPlayerController.asset('assets/videos/video2.mp4')
        ..initialize().then((_) {
          setState(() {});
          _controllers[1].play();
        }),
      VideoPlayerController.asset('assets/videos/video3.mp4')
        ..initialize().then((_) {
          setState(() {});
          _controllers[2].play();
        }),
      VideoPlayerController.asset('assets/videos/video4.mp4')
        ..initialize().then((_) {
          setState(() {});
          _controllers[3].play();
        }),
      VideoPlayerController.asset('assets/videos/video5.mp4')
        ..initialize().then((_) {
          setState(() {});
          _controllers[4].play();
        }),
      VideoPlayerController.asset('assets/videos/video6.mp4')
        ..initialize().then((_) {
          setState(() {});
          _controllers[5].play();
        }),
      // 더 많은 동영상을 추가하세요.
    ];

    _controllers.forEach((controller) {
      controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _controllers.length,
      itemBuilder: (context, index) {
        return VideoPlayerScreen(controller: _controllers[index]);
      },
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final VideoPlayerController controller;

  VideoPlayerScreen({required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? GestureDetector(
      onTap: () {
        controller.value.isPlaying ? controller.pause() : controller.play();
      },
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
}

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사용자 계정'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // 설정 화면 이동 로직 추가
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text('게시물 수', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('100'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text('팔로워', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('200K'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text('팔로잉', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('300'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(30, (index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/150'),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
