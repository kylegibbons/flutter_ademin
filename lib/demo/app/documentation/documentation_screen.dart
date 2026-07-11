import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/documentation/documentation_models.dart';
import 'package:flutter_ademin/demo/app/documentation/widget/documentation_header.dart';
import 'package:flutter_ademin/demo/app/documentation/widget/documentation_markdown_area.dart';
import 'package:flutter_ademin/demo/app/documentation/widget/documentation_sidebar.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class DocumentationScreen extends StatefulWidget {
  const DocumentationScreen({super.key});

  @override
  State<DocumentationScreen> createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).documentation;
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(body: DocumentationViewer());
  }
}

// Documentation Viewer

class DocumentationViewer extends StatefulWidget {
  const DocumentationViewer({super.key});

  @override
  State<DocumentationViewer> createState() => _DocumentationViewerState();
}

class _DocumentationViewerState extends State<DocumentationViewer> {
  late Future<List<DocCategory>> _manifestFuture;
  DocItem? _selectedDoc;
  bool _isMobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _manifestFuture = DocService.loadManifest();
  }

  void toggleMenu() => setState(() => _isMobileMenuOpen = !_isMobileMenuOpen);

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return FutureBuilder<List<DocCategory>>(
      future: _manifestFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final categories = snapshot.data!;
        // Set default item
        _selectedDoc ??= categories.first.items.first;

        return LayoutBuilder(
          builder: (context, constraints) {
            final bool isDesktop = constraints.maxWidth >= 850;

            return Stack(
              children: [
                // Layer 1: Main Layout (Sidebar + Content)
                Row(
                  children: [
                    if (isDesktop)
                      Container(
                        width: 280,
                        padding: EdgeInsetsDirectional.only(
                          top: isDesktop ? kDefaultPadding / 4 : topPadding,
                          bottom: kDefaultPadding / 4,
                          start: kDefaultPadding / 4,
                          end: kDefaultPadding / 4,
                        ),
                        child: Card(
                          child: DocumentationSidebar(
                            categories: categories,
                            isDesktop: isDesktop,
                            selectedDoc: _selectedDoc,
                            onSelectDoc: (item) {
                              setState(() => _selectedDoc = item);
                            },
                            onCloseMenu: toggleMenu,
                          ),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          top: isDesktop ? kDefaultPadding / 4 : topPadding,
                          bottom: kDefaultPadding / 4,
                          start: 0,
                          end: kDefaultPadding / 4,
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              DocumentationHeader(
                                isDesktop: isDesktop,
                                onMenuTap: toggleMenu,
                              ),
                              Expanded(
                                child: DocumentationMarkdownArea(
                                  selectedDoc: _selectedDoc,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Layer 2: Mobile Overlay (Scrim)
                if (!isDesktop && _isMobileMenuOpen)
                  GestureDetector(
                    onTap: toggleMenu,
                    child: Container(color: Colors.black54),
                  ),

                // Layer 3: Mobile Sidebar Animation
                if (!isDesktop)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    left: _isMobileMenuOpen ? 0 : -300,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 300,
                      color: Theme.of(context).colorScheme.surface,
                      child: DocumentationSidebar(
                        categories: categories,
                        isDesktop: isDesktop,
                        selectedDoc: _selectedDoc,
                        onSelectDoc: (item) {
                          setState(() => _selectedDoc = item);
                        },
                        onCloseMenu: toggleMenu,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
