import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarState {
  const SidebarState({
    this.isSidebarMinimized = false,
    this.selectedRoute,
  });

  final bool isSidebarMinimized;
  final String? selectedRoute;

  SidebarState copyWith({
    bool? isSidebarMinimized,
    String? selectedRoute,
  }) {
    return SidebarState(
      isSidebarMinimized: isSidebarMinimized ?? this.isSidebarMinimized,
      selectedRoute: selectedRoute ?? this.selectedRoute,
    );
  }
}

class SidebarController extends Notifier<SidebarState> {
  @override
  SidebarState build() => const SidebarState();

  void toggleSidebar() {
    state = state.copyWith(
      isSidebarMinimized: !state.isSidebarMinimized,
    );
  }

  void setSidebarState(bool minimized) {
    if (state.isSidebarMinimized == minimized) return;

    state = state.copyWith(isSidebarMinimized: minimized);
  }

  void setSelectedRoute(String uri) {
    if (state.selectedRoute == uri) return;

    state = state.copyWith(selectedRoute: uri);
  }
}

class SidebarHoverController extends Notifier<bool> {
  @override
  bool build() => false;

  void setHoverState(bool isHovered) {
    if (state == isHovered) return;

    state = isHovered;
  }
}

final sidebarProvider = NotifierProvider<SidebarController, SidebarState>(
  SidebarController.new,
);

final sidebarHoverProvider =
    NotifierProvider<SidebarHoverController, bool>(
      SidebarHoverController.new,
    );
