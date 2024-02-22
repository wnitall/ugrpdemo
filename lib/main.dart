import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/////////////////////////////////////////////////////////////////
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo-1',
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

  //////////////////////////위에는 기본//////////////////////////
  // 설명 : home -> HomrScreen() -> HomeScreenState()
  // Home screen state에서 하단 아이콘 클릭하면 해당 화면으로 넘어가도록 구현하기 위해 _selectedIndex = [0,1,2] 정의.
  // 각 화면은 쇼츠 : ShortsScreen(), 유저 프로필 : UserProfileScreen(), 지도 : Text() 임.
  // 지도와 유저 프로필은 데이터 베이스, API 연동 공부가 덜되서 구현 못함

  // 하단 바의 해당 아이콘을 누르면 해당 아이콘에 해당하는 화면으로 이동하기 위한 _onTtemTapped 함수.
  // 누르면 index를 다시 설정해서, index에 해당하는 화면으로 이동하도록 구현
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 앱의 뼈대 구성.
  // 상단 바는 추후 기능 추가 및 수정 필요. 완전 기본 형태임
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단바
      appBar: AppBar(
        title: Text('Demo-1'),
      ),
      // 중앙 contents
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // 하단 바
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


// 쇼츠 생성 로직
// 기본 작업 ShortsScreen -> ShortsScreenState
class ShortsScreen extends StatefulWidget {
  @override
  _ShortsScreenState createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  // 비디오를 담을 변수
  late List<VideoPlayerController> _controllers = [];
  //
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // 정적인 video list 생성. 실제로는 video URL 받아와서 동적으로 생성해야함.
    _pageController = PageController(); // PageController : 플러터 프레임워크. PageView 위젯에서 동영상 스크롤 관리할때 씀.
    _controllers = [
      VideoPlayerController.asset('assets/videos/video1.mp4') // ideoPlayerController 이거도 마찬가지
        ..initialize().then((_) { // .. : cascade notation :
          // VideoPlayerController 객체에 대해 연속적인 메서드를 실행해줌(initialize : 동영상 초기화,,
          // setState : initialize가 되었을 경우 위젯 상태 변경(세팅해줌),,, )
          setState(() {});
          _controllers[0].play(); // 비디오 플레이
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
      // 지금 내 local에 있는 동영상 6개 가지고 그냥 돌림
    ];

    // 동영상 끝나면 다시 반복 재생
    _controllers.forEach((controller) {
      controller.setLooping(true);
    });
  }
  // 자원 해제
  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  // 동양상 리스트 수직 스크롤할 수 있도록 각종 설정
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController, // 페이지 리소스 동적으로 관리
      scrollDirection: Axis.vertical, // 수직 스크롤
      itemCount: _controllers.length, //
      itemBuilder: (context, index) {
        return VideoPlayerScreen(controller: _controllers[index]); // 실질적으로 비디오를 플레이하는 함수에 동영상 6개중 index에 맞는 객체 인자로 전달
      },
    );
  }
}

// 비디오 플레이
class VideoPlayerScreen extends StatelessWidget {
  final VideoPlayerController controller;

  VideoPlayerScreen({required this.controller});

  // GPT에게 문의해본 코드 뭔지 모름
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

// 유저 페이지 GPT 한테 정적으로 생성해 달라함. 이거는 일단 동영상 말고 다른 페이지가 뭐가 될지 몰라서 이렇게 설정.
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
