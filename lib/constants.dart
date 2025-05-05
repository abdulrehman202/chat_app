import 'package:flutter/material.dart';

class Constants {
  
  static String APP_NAME = 'Bubble Chat';
  static String BASE_IMAGE_PATH  = 'assets/images/';
  static String SPLASH_ICON_PATH  = '${BASE_IMAGE_PATH}splash_icon.png';
  static String FONT_NAME  = 'Jost';
  
  static getParentWidth(BuildContext context)
  {
    return MediaQuery.of(context).size.width;
  }

  getParentHeight(BuildContext context)
  {
    return MediaQuery.of(context).size.height;
  }


}