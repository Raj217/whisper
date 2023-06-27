part of rive_widgets;

class RiveWidgetBase extends StatelessWidget {
  final double height;
  final double width;
  final void Function(bool)? onStateChange;
  final RiveBase controller;
  final bool addBG;
  final void Function(RiveBase)? onInit;
  const RiveWidgetBase({
    Key? key,
    this.height = 30,
    this.width = 30,
    this.addBG = true,
    this.onInit,
    this.onStateChange,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(
      height: height,
      width: width,
      child: RiveAnimation.asset(
        controller.src(context),
        artboard: controller.artBoard,
        onInit: (Artboard artBoard) {
          controller.getRiveInputBool(artBoard);
          if (onInit != null) onInit!(controller);
        },
      ),
    );
    void onPressed() {
      if (onStateChange != null) {
        if (controller.changeState()) {
          onStateChange!(controller.state);
        }
      }
    }

    return onStateChange == null
        ? child
        : addBG
            ? IconButton(
                onPressed: onPressed,
                icon: child,
              )
            : GestureDetector(
                onTap: onPressed,
                child: child,
              );
  }
}
