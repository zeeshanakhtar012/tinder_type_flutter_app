import 'package:blaxity/constants/colors.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'item_chat_plus_option.dart';

class ChatInputField extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: Colors.black,
      child: Row(
        children: [
          InkWell(
              onTap: (){
                ItemPlusChatOptions.showChatOptions(context);
              },
              child: SvgPicture.asset("assets/icons/icon_user_chat.svg")).marginOnly(
            top: 10.sp,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a message",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.emoji_emotions_outlined, ),
            onPressed: () {
              // EmojiPicker(
              //   // onEmojiSelected: (Category category, Emoji emoji) {
              //   //   // Do something when emoji is tapped (optional)
              //   // },
              //   onBackspacePressed: () {
              //     // Do something when the user taps the backspace button (optional)
              //     // Set it to null to hide the Backspace-Button
              //   },
              //   // textEditingController: textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
              //   // config: Config(
              //   //   height: 256,
              //   //   bgColor: const Color(0xFFF2F2F2),
              //   //   checkPlatformCompatibility: true,
              //   //   emojiViewConfig: EmojiViewConfig(
              //   //     // Issue: https://github.com/flutter/flutter/issues/28894
              //   //     emojiSizeMax: 28 *
              //   //         (foundation.defaultTargetPlatform == TargetPlatform.iOS
              //   //             ?  1.20
              //   //             :  1.0),
              //   //   ),
              //   //   swapCategoryAndBottomBar:  false,
              //   //   skinToneConfig: const SkinToneConfig(),
              //   //   categoryViewConfig: const CategoryViewConfig(),
              //   //   bottomActionBarConfig: const BottomActionBarConfig(),
              //   //   searchViewConfig: const SearchViewConfig(),
              //   // ),
              // );
            },
          ),
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {
            },
          ),
          Container(
            height: 35.h,
            width: 70.14.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: AppColors.buttonColor,
            ),
            child: Center(
              child: Text("Send", style: TextStyle(
                color: Colors.white,
                fontSize: 12.36.sp,
              ),),
            ),
          ),
        ],
      ),
    );
  }
  // void _showEmojiPicker() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return EmojiPicker(
  //         // onEmojiSelected: (Category category, Emoji emoji) {
  //         //   textEditingController
  //         //     ..text += emoji.emoji
  //         //     ..selection = TextSelection.fromPosition(
  //         //       TextPosition(offset: textEditingController.text.length),
  //         //     );
  //         // },
  //         onBackspacePressed: () {
  //           // Handle backspace pressed if needed
  //         },
  //         textEditingController: textEditingController,
  //         config: Config(
  //           height: 256,
  //           checkPlatformCompatibility: true,
  //           swapCategoryAndBottomBar: false,
  //           skinToneConfig: const SkinToneConfig(),
  //           categoryViewConfig: const CategoryViewConfig(),
  //           bottomActionBarConfig: const BottomActionBarConfig(),
  //           searchViewConfig: const SearchViewConfig(),
  //         ),
  //       );
  //     },
  //   );
  // }
}
