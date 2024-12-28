import 'package:brite_eye/faetures/activities/examination/ishihara/ui/widget/next_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/Ishihara_provider.dart';
// import 'package:pro';

class IshiharaScreen extends StatelessWidget {
  static const String id = '/ishihara';

  const IshiharaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Consumer<IshiharaProvider>(
          builder: (context, provider, child) {
            return const Text('Ishihara Test');
          },
        ),
      ),
      body: Consumer<IshiharaProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: provider.controller,
                    itemCount: provider.getPlatesLength(),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18, bottom: 12),
                            child: Image.asset(
                              provider.getPlateImage(),
                              width: width / 1.5,
                            ),
                          ),
                          Text(provider.getPlateHint()),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: width - (24 * 2),
                            child: Wrap(
                              alignment: WrapAlignment.spaceAround,
                              runSpacing: 8,
                              children: [
                                for (int index = 0;
                                    index < provider.getOptionsLength();
                                    index++)
                                  FittedBox(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 4),
                                      child: RadioMenuButton(
                                        value: index,
                                        groupValue: provider.currentChoice,
                                        onChanged: provider.setChoice,
                                        child: Text(
                                          provider.getOption(index),
                                        ),
                                        style: provider.choiceSelected &&
                                                provider.currentChoice == index
                                            ? MenuItemButton.styleFrom(
                                                foregroundColor:
                                                    provider.isCorrect()
                                                        ? Colors.green
                                                        : Colors.redAccent,
                                                shadowColor:
                                                    provider.isCorrect()
                                                        ? Colors.green
                                                        : Colors.redAccent,
                                                surfaceTintColor:
                                                    Colors.yellowAccent)
                                            : null,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                if (provider.choiceSelected) ...{
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(18)),
                      child: Text('Result: ${provider.getDescription()!}')),
                },
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (!provider.firstPage)
                      SizedBox(
                        height: 56,
                        child: NavButton.previous(
                          onTapNext: () {
                            provider.previousPlate();
                          },
                        ),
                      ),
                    SizedBox(
                      height: 56,
                      child: NavButton.next(
                        onTapNext: () {
                          provider.nextPlate();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
