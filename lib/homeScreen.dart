import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int hours = 0, min = 0, sec = 0, millisec = 0;
  String showhours = "00", showmin = "00", showsec = '00', showmillisec = '00';
  bool started = false;
  List Laps = [];
  Timer? timer;

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void resetfun() {
    timer!.cancel();
    setState(() {
      hours = 0;
      min = 0;
      sec = 0;
      millisec = 0;
      showhours = "00";
      showmin = "00";
      showsec = "00";
      showmillisec = "00";
      started = false;
      Laps = [];
    });
  }

  void startfun() {
    started = true;
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      int localmillisec = millisec + 10;
      int localsec = sec;
      int localmin = min;
      int localhours = hours;

      if (localmillisec > 999) {
        localmillisec = 0;
        localsec++;
      }
      if (localsec > 59) {
        localsec = 0;
        localmin++;
      }
      if (localmin > 59) {
        localmin = 0;
        localhours++;
      }

      setState(() {
        millisec = localmillisec;
        sec = localsec;
        min = localmin;
        hours = localhours;

        showmillisec = (millisec >= 100)
            ? '$millisec'
            : (millisec >= 10)
                ? '0$millisec'
                : '00$millisec';
        showsec = (sec >= 10) ? '$sec' : '0$sec';
        showmin = (min >= 10) ? '$min' : '0$min';
        showhours = (hours >= 10) ? '$hours' : '0$hours';
      });
    });
  }

  void addLapsfun() {
    String lap = '$showhours:$showmin:$showsec.$showmillisec';
    setState(() {
      Laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'STOPWATCH APP',
                style: GoogleFonts.poppins(
                    fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              AvatarGlow(
                glowColor: Colors.blue,
                glowRadiusFactor: .4,
                glowCount: 2,
                glowShape: BoxShape.circle,
                duration: Duration(seconds: 3),
                repeat: true,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Center(
                      child: Text(
                    '$showhours:$showmin:$showsec.$showmillisec',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  height: 200,
                  child: ListView.builder(
                      itemCount: Laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Lap${index + 1}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400, fontSize: 18),
                              ),
                              Text(
                                ' ${Laps[index]}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: M,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          border: Border.all(color: Colors.black, width: 2)),
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.lightBlue),
                          ),
                          onPressed: () {
                            (!started) ? startfun() : stop();
                          },
                          child: Text(
                            (!started) ? 'START' : 'STOP',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ))),
                  IconButton(
                      onPressed: () {
                        addLapsfun();
                      },
                      icon: Icon(
                        Icons.timer,
                        color: Colors.black,
                        size: 30,
                      )),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          border: Border.all(color: Colors.black, width: 2)),
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.lightBlue),
                          ),
                          onPressed: () {
                            resetfun();
                          },
                          child: Text(
                            'RESET',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ))),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
