import 'package:blaxity/controllers/blogs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_drawer.dart';
import '../../layouts/item_blog/item_blog.dart';

class LayoutBlog extends StatelessWidget {
  const LayoutBlog({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    BlogsController blogsController = Get.find<BlogsController>();
    blogsController.fetchBlogs();

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: SvgPicture.asset("assets/icons/notification.svg"),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Color(0xFFA7713F),
        onRefresh: () async {
           blogsController.fetchBlogs();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                  gradient: AppColors.buttonColor,
                  text: "Blog", style: AppFonts.titleLogin),
              Text(
                "Discover, Interact, and Connect with Others",
                style: AppFonts.subtitle,
              ), // Spacing between title and search row
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                height: 47.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff353535),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    blogsController.fetchBlogs(search: value);
                  },
                ),
              ).marginSymmetric(
                vertical: 10.h,
              ),
              Expanded(
                child: Obx(() {
                  if (blogsController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFA26837),
                      ),
                    );
                  } else if (blogsController.blogsList.isEmpty) {
                    return Center(child: Text("No Blogs"));
                  } else {
                    return ListView.builder(
                      itemCount: blogsController.blogsList.length,
                      // shrinkWrap: true,
                      physics: BouncingScrollPhysics(), // Disable scrolling for the list
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: ItemBlog(
                            isHome: true,
                            blog: blogsController.blogsList[index],
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
