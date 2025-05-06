import 'package:flutter/material.dart';

class Constants {
  
  static String APP_NAME = 'Bubble Chat';
  static String BASE_IMAGE_PATH  = 'assets/images/';
  static String SPLASH_ICON_PATH  = '${BASE_IMAGE_PATH}splash_icon.png';
  static String FONT_NAME  = 'Jost';

  static  getMonth(int num)
  {
    switch(num)
    {
      case 1:
      return 'January';

      case 2:
      return 'February';

      case 3:
      return 'March';

      case 4:
      return 'April';

      case 5:
      return 'May';

      case 6:
      return 'June';

      case 7:
      return 'July';

      case 8:
      return 'August';

      case 9:
      return 'September';

      case 10:
      return 'October';

      case 11:
      return 'November';

      case 12:
      return 'December';

      default:
      return '';


    }
  }
  
  static getParentWidth(BuildContext context)
  {
    return MediaQuery.of(context).size.width;
  }

  getParentHeight(BuildContext context)
  {
    return MediaQuery.of(context).size.height;
  }
  
  static String get12hrsTime(DateTime dtime)
  {
    String time = '';
    String unit = 'am';
    String min = dtime.minute.toString(), hour = dtime.hour.toString();
    
    if(dtime.hour>12)
    {
      hour = (dtime.hour-12).toString();
      unit = 'pm';
    }

    time = '$hour:${min.padLeft(2,'0')} $unit';
    return time;
  }

  static String get24hrsTime(DateTime dtime)
  {
    return '${dtime.hour.toString().padLeft(2,'0')}:${dtime.minute.toString().padLeft(2,'0')}';
  }

}