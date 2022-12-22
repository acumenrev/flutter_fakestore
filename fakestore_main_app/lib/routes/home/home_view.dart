import 'package:fakestore_main_app/routes/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);
  final homeScreenProvider = StateProvider<HomeViewModel>((ref) {
    return HomeViewModel();
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeScreenProvider);
    return Container(
      color: viewModel.mainColor,
    );
  }
}
