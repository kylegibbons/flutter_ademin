import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/gallery/gallery_data.dart';
import 'package:flutter_ademin/demo/page/gallery/gallery_models.dart';
import 'package:flutter_ademin/demo/page/gallery/widgets/gallery_category_selector.dart';
import 'package:flutter_ademin/demo/page/gallery/widgets/gallery_thumbnail.dart';
import 'package:flutter_ademin/demo/page/gallery/widgets/gallery_slider_dialog.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).gallery; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showGallerySlider({
    required BuildContext context,
    required List<GalleryItem> items,
    required int initialIndex,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return GallerySliderDialog(items: items, initialIndex: initialIndex);
      },
    );
  }

  String selectedCategory = 'All';

  List<String> get uniqueCategories =>
      galleryItems.map((item) => item.category).toSet().toList();

  // responsive grid item count based on screen width
  int calculateCrossAxisCount(double width) {
    if (width >= kScreenWidthXxxl) return 6;
    if (width >= kScreenWidthXl) return 4;
    if (width >= kScreenWidthLg) return 3;
    if (width >= kScreenWidthSm) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = calculateCrossAxisCount(screenWidth);

    final filteredItems = selectedCategory == 'All'
        ? galleryItems
        : galleryItems
              .where((item) => item.category == selectedCategory)
              .toList();

    return PortalMasterLayout(
      body: ListView(
        children: [
          //header
          PageHeader(
            title: lang.gallery.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.gallery, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // category selector
                GalleryCategorySelector(
                  categories: uniqueCategories,
                  selectedCategory: selectedCategory,
                  onCategorySelected: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                SizedBox(height: kDefaultPadding),

                // gallery grid view
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                  child: GridView.builder(
                    key: ValueKey<String>(
                      selectedCategory,
                    ), // Important for AnimatedSwitcher

                    itemCount: filteredItems.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: kDefaultPadding,
                      crossAxisSpacing: kDefaultPadding,
                    ),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return GestureDetector(
                        onTap: () {
                          showGallerySlider(
                            context: context,
                            items: filteredItems,
                            initialIndex: index,
                          );
                        },
                        child: GalleryThumbnail(
                          item: item,
                          themeData: themeData,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}
