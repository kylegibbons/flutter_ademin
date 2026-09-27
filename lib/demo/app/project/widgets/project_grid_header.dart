import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/project/project_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/dropdown.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:go_router/go_router.dart';

class ProjectGridHeader extends StatelessWidget {
  const ProjectGridHeader({
    super.key,
    required this.isMobile,
    required this.popupSearchbar,
    required this.themeData,
    required this.mediaQueryData,
    required this.controller,
  });

  final bool isMobile;
  final GlobalKey<PopupMenuButtonState<dynamic>> popupSearchbar;
  final ThemeData themeData;
  final MediaQueryData mediaQueryData;
  final ProjectController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Add Project button
        isMobile
            ? CustomIconButton(
                icon: Icons.add,
                iconColor: Colors.white,
                buttonColor: kSuccessColor,
                onTap: () {
                  GoRouter.of(context).go(RouteUri.createProject);
                },
              )
            : FlatButton(
                kText: 'Add Project',
                bgColor: kSuccessColor,
                kTextColor: Colors.white,
                onPressed: () {
                  GoRouter.of(context).go(RouteUri.createProject);
                },
                kLeadingIcon: Icons.add,
              ),
        Spacer(),

        // Search by title and description
        isMobile
            ? PopupMenuButton(
                key: popupSearchbar,
                splashRadius: 0.0,
                tooltip: '',
                position: PopupMenuPosition.under,
                color: themeData.colorScheme.surface,
                constraints: BoxConstraints(
                  maxWidth: mediaQueryData.size.width <= kScreenWidthMd
                      ? mediaQueryData.size.width
                      : 360,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: OutlineSearchBar(
                        hintText: 'Search projects',
                        onChanged: controller.search,
                        autofocus: true,
                      ),
                    ),
                  ),
                ],
                child: CustomIconButton(
                  icon: Icons.search,
                  iconColor: kTextColor,
                  buttonColor: themeData.colorScheme.surface,
                  onTap: () {
                    popupSearchbar.currentState?.showButtonMenu();
                  },
                  isOutlined: true,
                ),
              )
            : SizedBox(
                width: 240,
                child: OutlineSearchBar(
                  hintText: 'Search projects',
                  onChanged: controller.search,
                ),
              ),
        SizedBox(width: isMobile ? kDefaultPadding / 2 : kDefaultPadding),

        // Sort
        isMobile
            ? PopupMenuButton<ProjectSortOption>(
                // Use any icon you prefer
                tooltip: 'Sort',
                onSelected: (option) {
                  controller.changeSort(option);
                },
                itemBuilder: (context) => ProjectSortOption.values.map((opt) {
                  return PopupMenuItem<ProjectSortOption>(
                    value: opt,
                    child: Text(opt.label),
                  );
                }).toList(),
                child: CustomIconButton(
                  icon: Icons.sort,
                  iconColor: kTextColor,
                  buttonColor: themeData.colorScheme.surface,
                  isOutlined: true,
                ),
              )
            : CustomDropdownButton<ProjectSortOption>(
                label: 'Sort',
                color: kTextColor,
                outlineColor: themeData.colorScheme.outline,
                type: DropdownType.outline,
                items: ProjectSortOption.values.map((opt) {
                  return DropdownMenuItem(value: opt, child: Text(opt.label));
                }).toList(),
                value: controller._sortOption,
                onChanged: (option) {
                  if (option != null) controller.changeSort(option);
                },
              ),
      ],
    );
  }
}

// project header controller

class ProjectController extends ChangeNotifier {
  final List<Project> allProjects;
  List<Project> visibleprojects = [];

  final int _itemsPerPage = 12;
  int _currentPage = 1;
  String _searchQuery = '';
  ProjectSortOption _sortOption = ProjectSortOption.aToZ;

  ProjectController({required this.allProjects}) {
    _applyFilters();
  }

  void search(String query) {
    _searchQuery = query.toLowerCase();
    _currentPage = 1;
    _applyFilters();
  }

  void changeSort(ProjectSortOption option) {
    _sortOption = option;
    _applyFilters();
  }

  void loadMore() {
    if (_currentPage * _itemsPerPage < _filteredprojects.length) {
      _currentPage++;
      _applyFilters();
    }
  }

  List<Project> get _filteredprojects => allProjects.where((task) {
    return task.title.toLowerCase().contains(_searchQuery) ||
        task.description.toLowerCase().contains(_searchQuery);
  }).toList();

  void _applyFilters() {
    List<Project> list = [..._filteredprojects];

    switch (_sortOption) {
      case ProjectSortOption.aToZ:
        list.sort((a, b) => a.title.compareTo(b.title));
        break;
      case ProjectSortOption.dueDate:
        list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case ProjectSortOption.newest:
        list.sort((a, b) => b.assignedDate.compareTo(a.assignedDate));
        break;
      case ProjectSortOption.priority:
        list.sort(
          (a, b) =>
              _priorityValue(b.priority).compareTo(_priorityValue(a.priority)),
        );
        break;
    }

    visibleprojects = list.take(_currentPage * _itemsPerPage).toList();
    notifyListeners();
  }

  int _priorityValue(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return 3;
      case 'medium':
        return 2;
      case 'low':
      default:
        return 1;
    }
  }

  bool get canLoadMore =>
      _currentPage * _itemsPerPage < _filteredprojects.length;
}

// project sort options

enum ProjectSortOption { aToZ, dueDate, newest, priority }

extension ProjectSortOptionExtension on ProjectSortOption {
  String get label {
    switch (this) {
      case ProjectSortOption.aToZ:
        return 'A to Z';
      case ProjectSortOption.dueDate:
        return 'Due Date';
      case ProjectSortOption.newest:
        return 'Newest';
      case ProjectSortOption.priority:
        return 'Priority';
    }
  }
}
