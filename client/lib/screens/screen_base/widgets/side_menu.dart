import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/screens/screen_base/data/screens_data.dart';
import 'package:whisper/states/screen/screen.dart';
import 'item.dart';
import 'package:whisper/widgets/rive/rive.dart';

class SideMenu extends ConsumerStatefulWidget {
  const SideMenu({super.key});

  @override
  ConsumerState createState() => _SideMenuState();
}

class _SideMenuState extends ConsumerState<SideMenu> {
  int selectedScreen = 0;
  double iconHeight = 30;

  @override
  Widget build(BuildContext context) {
    selectedScreen = ref.watch(screenProvider);
    return Scaffold(
      backgroundColor: blueSwatch,
      body: Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: ListView.separated(
          itemCount: icons.length,
          itemBuilder: (BuildContext context, int ind) {
            return Item(
              riveWidget: icons[ind]?.copyWith(
                height: iconHeight,
                controller: controllers[ind],
                onInit: () {
                  if (selectedScreen == ind) {
                    controllers[ind]?.changeState();
                  }
                },
              ),
              text: menuTitle[ind],
              isSelected: selectedScreen == ind,
              onTap: () {
                setState(() {
                  controllers[ind]?.changeState();
                  ref.read(screenProvider.notifier).screen = ind;
                  if (onTapped[ind] != null) {
                    onTapped[ind]!(context);
                  }
                });
              },
            );
          },
          separatorBuilder: (BuildContext context, int ind) {
            return const SizedBox(height: 20);
          },
        ),
      ),
    );
  }
}
