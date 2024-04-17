import 'package:aladang_app/screen/startup/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constant.dart';

class GetStartedScreen extends StatefulWidget{

  const GetStartedScreen({super.key});
  @override
    State<GetStartedScreen> createState()=>_GetStartedScreen();
}

class _GetStartedScreen extends State<GetStartedScreen>{
  final int numberPage=3;
  final PageController pageController=PageController(initialPage: 0);

  final selectedIndex=ValueNotifier(0);

  final illustrations=[
    "assets/gifs/gif1.gif",
    "assets/gifs/istockphoto_illustration_step1.jpg",
    "assets/gifs/shopping_peoplegreate_illustration_step2.jpg"
  ];
  final titles=[
    "Easy Market Search",
    "Professional Reviewer",
    "Find ideal Idea"
  ];
  final descriptions=[
      "Search for new markets and hungry for new ideas, opportunity and excitement.",
      "try our services we will provide you our best analysis research for free.",
      "Fusce elementum et elit eget placerat. Praesent suscipit metus nec dolor vestibulum, id pretium sapien ornare"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child:  Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment. topCenter,
              end: Alignment. bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
              Color.fromARGB(255, 121, 8, 214),
              Color.fromARGB(255, 149, 82, 170),
              Color.fromARGB(255, 226, 166, 221),
              Color.fromARGB(255, 63, 17, 142),
              ],
            ),
          ),
            child:Column(
                children: [
                  Expanded(child: PageView.builder(
                    controller: pageController,
                    itemCount: illustrations.length,
                      itemBuilder: (context,index){
                    return _PageLayout(
                        illustrations: illustrations[index],
                        titles: titles[index],
                        descriptions: descriptions[index]
                    );
                  },
                  onPageChanged: (value){
                    selectedIndex.value=value;
                  },
                  ),
                  ),
                  ValueListenableBuilder(valueListenable: selectedIndex, builder: (context,index,child){
                      return  Padding(
                          padding: const EdgeInsets.only(top: 16,bottom: 10),
                          child: Wrap(
                            spacing: 8,
                            children: List.generate(illustrations.length, (indexIndicator){
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 8,
                                width: indexIndicator==index?24:8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: indexIndicator==index?
                                      primaryColor
                                      :primaryColor.withOpacity(0.5),
                                ),
                              );
                            }),
                          ),
                      );
                  }),
                  Padding(
                      padding: const EdgeInsets.all(14),
                      child:ValueListenableBuilder(
                          valueListenable: selectedIndex,
                          builder: (context,index,child){
                            if(index==illustrations.length-1){
                              return SizedBox(
                                width:MediaQuery.of(context).size.width ,
                                height: 48,
                                child: ElevatedButton(

                                  onPressed: (){
                                    //LoginScreen
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const StartScreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),

                                    )
                                  ),
                                  child:const Text("Get Started"),
                                ),
                              );
                            }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: (){
                                      pageController.jumpToPage(illustrations.length-1);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    ),
                                    child:const Text("Skip"),
                                  ),
                                  // TextButton(
                                  //   onPressed: (){
                                  //
                                  //   },
                                  //   style: ButtonStyle(
                                  //     backgroundColor:
                                  //     MaterialStateProperty.all<Color>(Colors.red),
                                  //   ),
                                  //   child: const Text("Skip",
                                  //     style: TextStyle(color: Colors.white),
                                  //   ),
                                  // ),
                                  ElevatedButton(
                                    onPressed: (){
                                      final nextPage=selectedIndex.value+1;
                                      pageController.animateToPage(
                                        nextPage,
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(13)
                                        )
                                    ),
                                    child:const Text("Next"),
                                  ),
                                ],
                              );
                          }
                        ),
                  ),
                ],
              ),
              ),
      ),
    );
  }
}

class _PageLayout extends StatelessWidget{

  const _PageLayout({
    required this.illustrations,
    required this.titles,
    required this.descriptions
  });
  final String illustrations;
  final String titles;
  final String descriptions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height* 0.4,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(illustrations),
          ),
          const SizedBox(height: 30,),
          Text(
            titles,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
            selectionColor: Colors.white,
          ),
          const SizedBox(height: 16,),
          Text(
            descriptions,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            //selectionColor: Colors.blue,
          )
        ],
      ),
    );
  }

}