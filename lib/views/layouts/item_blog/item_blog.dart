import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/models/blog.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_selectable_button.dart';

class ItemBlog extends StatelessWidget {
  bool? isHome = false;
  Blog blog;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height*1;
    final width = MediaQuery.sizeOf(context).width*1;
    return InkWell(
      onTap: (){
        Get.to(LayoutBlog());
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFF1D1D1D),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFFA7713F),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isHome==false)Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/icon_blog.svg",
                ),
                Text("Blog", style: AppFonts.subscriptionTitle,).marginOnly(
                  left: 10.sp,
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    // Get.to(ScreenEditEventIndividual());
                  },
                  child: SvgPicture.asset(
                    "assets/icons/icon_share.svg",
                  ),
                ),
              ],
            ).marginSymmetric(vertical: 6.h),
            Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              height: 240.h,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(5.r),
                ),
                image: DecorationImage(
                  image: NetworkImage(APiEndPoint.imageUrl+blog.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text( '${blog.title}',
              style: AppFonts.subscriptionTitle.copyWith(
                color: Color(0xFFC19B61),
                fontSize: 16.sp
              ),
            ),
            if (blog.tags!=null)Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,

                children:List.generate(blog.tags!.length, (index) =>  IntrinsicWidth(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    height: 24.h,
                    // width: 70.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurStyle: BlurStyle.inner,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFA7713F)),
                    ),
                    child: Text(
                      blog.tags![index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.sp,
                      ),
                    ).marginOnly(left: 4.sp),
                  ),
                ).marginOnly(right: 10.w),)
            ).marginSymmetric(
              vertical: 15.sp,
            ),
            Text(
                style: AppFonts.subtitle.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp
                ),
                "${blog.content}"),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomSelectbaleButton(
                onTap: (){
                  // Get.to(ScreenBlogDetails());
                },
                borderRadius: BorderRadius.circular(20),
                width: 104.w,
                height: 35.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Read",

              ),
            ).marginSymmetric(
              vertical: 15.sp,
            )
          ],
        ),
      ),
    );
  }

  ItemBlog({
    this.isHome,
    required this.blog,
  });
}
