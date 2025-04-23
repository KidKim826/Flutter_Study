import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'neda',
      debugShowCheckedModeBanner: false, // 우측 상단 debug 표시 제거
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const MainScreen(),
      // 라우터
      routes: {
        '/main' : (context) => const MainScreen(),
        '/write' : (context) => const WriteScreen(),
      },
    );
  }
}

// main screen
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('NEDA',
        style: GoogleFonts.nanumPenScript(
          textStyle : const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w800
          ),
        ),) ,
        backgroundColor : Colors.white ,
        elevation : 0 ,
    ),
        body: Container(
          color: Color(0xffFAF9E6), // 앞 4글자는 투명도, 뒤는 컬러코드
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.width,
                child: GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                    ),
                    physics: const NeverScrollableScrollPhysics(), // 스크롤 막기
                  children: [
                    Container(
                      color: Colors.black,
                    ),
                    Container(
                      color: Colors.white,
                    ),
                    Container(
                      color: Colors.blue,
                    ),
                    Container(
                      color: Colors.yellow,
                    ),
                  ],
                ),
              ),
              // 제목바탕 
              Transform.rotate(
                angle: 60 * math.pi/180,
                child: Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(70, 85,),
                    )
                  ),
                ),
              ),
              // 제목
              Text('is Title', style: GoogleFonts.nanumPenScript(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                )
              )),
              // 날짜
              Positioned(
                bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(8), // all 은 상하좌우 전체 해당
                      child: Text(
                              '2025.04.23',
                              style: GoogleFonts.nanumPenScript(
                                  textStyle: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  )
                              ),
                      ),
                    ),
                  ),
              ),
              // 수정하기, 삭제하기
              Positioned(
                top: 8,
                right: 0,
                child:
                  PopupMenuButton<String>(child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),),
                    child: Icon(
                      Icons.more_vert, size: 24, color: Colors.white,),
                  ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(child: Text('modify'),
                      onTap: (){}, // 수정하기 함수 작성
                      ),
                      PopupMenuItem<String>(child: Text('delete'),
                        onTap: (){}, // 삭제하기 함수 작성
                      ),
                    ] ,
                  ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).pushNamed('/write');
          },
          child: Icon(Icons.add, color: Colors.white,),
        ),
    );
  }
}

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('modify page')),
    );
  }
}

