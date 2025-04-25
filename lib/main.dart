import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:image_picker/image_picker.dart';
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
              // 사진
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

  // late 키워드 -> 초기화 필요.
  late ValueNotifier<dynamic> selectedImgTopLeft;
  late ValueNotifier<dynamic> selectedImgTopRight;
  late ValueNotifier<dynamic> selectedImgBottomLeft;
  late ValueNotifier<dynamic> selectedImgBottomRight;

  // text field 변수
  TextEditingController inputTitleController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //입력 필드 겁증용 key

  // 초기화
  @override
  void initState() {
    selectedImgBottomRight = ValueNotifier(null);
    selectedImgBottomLeft = ValueNotifier(null);
    selectedImgTopRight = ValueNotifier(null);
    selectedImgTopLeft = ValueNotifier(null);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NEDA", style: GoogleFonts.nanumPenScript(
          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 24),
        ),),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new, color: Colors.black,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body:

      SingleChildScrollView(
        child: Column(
          // 왼쪽 정렬
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 선택 위젯
            Container(
              margin: EdgeInsets.all(8),
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
                  SelectImg(
                    selectedImg: selectedImgTopLeft,
                  ),
                  SelectImg(
                    selectedImg: selectedImgTopRight,
                  ),
                  SelectImg(
                    selectedImg: selectedImgBottomLeft,
                  ),
                  SelectImg(
                    selectedImg: selectedImgBottomRight,
                  ),
                ],
              ),
            ),
            // 텍스트 작성 필드
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16,),
              child: Text('한 줄 일기', style: GoogleFonts.nanumPenScript(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w800,),
              ),),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
              child: Form(
                key: formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '한 줄 일기를 작성해주세요 (최대 8글자)',
                    hintStyle: GoogleFonts.nanumPenScript(fontSize: 16,),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffE1E1E1),
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )
                    )
                  ),
                  maxLength: 8, // 최대 글자수
                  controller: inputTitleController,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class SelectImg extends StatefulWidget {

  final ValueNotifier<dynamic>? selectedImg; // 갤러리에서 새로 선택한 이미지;

  const SelectImg({super.key, this.selectedImg,});

  @override
  State<SelectImg> createState() => _SelectImgState();
}

class _SelectImgState extends State<SelectImg> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xffF4F4F4),
        ),
        child: // 3항 연산자 사용.
        widget.selectedImg?.value == null ?
          // 선택된 이미지가 없는 경우
          const Icon(Icons.image, color: Color(0xff868686),)
              :
          // 선택된 이미지가 있는 경우
          Container(
            height: MediaQuery.of(context).size.width,
            child : Image.file(widget.selectedImg!.value, fit: BoxFit.cover,)
          )
      ),
      onTap: () => getGelleryImage(),
    );
  }

  void getGelleryImage() async{
    // 갤러리에서 이미지 가지고오는 함수

    var image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10,);

    if(image != null) { // 이미지가 선택 된 경우
      widget.selectedImg?.value = File(image.path);

      setState(() {

      });

      return;
    }
  }
}

