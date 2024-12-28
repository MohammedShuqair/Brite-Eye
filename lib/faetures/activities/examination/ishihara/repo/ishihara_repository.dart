import '../models/test_plate.dart';

class IshiharaRepository {
  var plates = <TestPlate>[
    TestPlate('What do you see in this image?', 'assets/ishihara/p1.png', 0, [
      '12',
      'something else'
    ], [
      'All people should see a number 12, including those with total color blindness',
      'Please see the plate before answering'
    ]),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p2.png',
      0,
      ['8', '3', 'nothing'],
      [
        'Normal color vision',
        'Red green color blindness',
        'Total color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p3.png',
      0,
      ['29', '70', 'nothing'],
      [
        'Normal color vision',
        'Red green color blindness',
        'Total color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p4.png',
      0,
      ['5', '2', 'nothing'],
      [
        'Normal color vision',
        'Red green color blindness',
        'Total color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p5.png',
      0,
      ['3', '5', 'nothing'],
      [
        'Normal color vision',
        'Red green color blindness',
        'Total color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p6.png',
      0,
      ['15', '17', 'nothing'],
      [
        'Normal color vision',
        'Red green color blindness',
        'Total color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p7.png',
      0,
      ['74', '21', 'nothing'],
      [
        'Normal color vision',
        'Red green color blindness',
        'Total color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p8.png',
      0,
      ['6', 'nothing'],
      [
        'Normal color vision',
        'Color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p9.png',
      0,
      ['45', 'nothing'],
      [
        'Normal color vision',
        'Color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p10.png',
      0,
      ['5', 'nothing'],
      [
        'Normal color vision',
        'Color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p11.png',
      0,
      ['7', 'nothing'],
      [
        'Normal color vision',
        'Color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p12.png',
      0,
      ['16', 'nothing'],
      [
        'Normal color vision',
        'Color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p13.png',
      0,
      ['73', 'nothing'],
      [
        'Normal color vision',
        'Color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p14.png',
      1,
      ['5', 'nothing'],
      [
        'Red green color blindness',
        'Normal color vision',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p15.png',
      0,
      ['45', 'nothing'],
      [
        'Red green color blindness',
        'Normal color vision',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p16.png',
      0,
      ['26', 'only 6', '6 and faint 2', 'only 2', '2 and faint 6'],
      [
        'Normal color vision',
        'Red color blind (protanopia)',
        'Mild red color blind (prontanomaly)',
        'Green color blind (deuteranopia)',
        'Mild green color blind (deuteranomaly)',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p17.png',
      0,
      ['42', 'only 2', '2 and faint 4', 'only 4', '4 and faint 2'],
      [
        'Normal color vision',
        'Red color blind (protanopia)',
        'Mild red color blind (prontanomaly)',
        'Green color blind (deuteranopia)',
        'Mild green color blind (deuteranomaly)',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p18.png',
      0,
      [
        'purple and red lines',
        'purple line',
        'purple line and faint red line',
        'red line',
        'red line and faint purple line'
      ],
      [
        'Normal color vision',
        'Red color blind (protanopia)',
        'Mild red color blind (prontanomaly)',
        'Green color blind (deuteranopia)',
        'Mild green color blind (deuteranomaly)',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p19.png',
      0,
      ['No line, just colours', 'Wiggly line'],
      [
        'Normal or Total color blindness',
        'Red green color blindness ',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p20.png',
      0,
      [
        'Green Wiggly line',
        'No line, just colours',
      ],
      [
        'Normal color vision',
        'have form of color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p21.png',
      0,
      [
        'Orange Wiggly line',
        'No line, just colours',
      ],
      [
        'Normal color vision',
        'have form of color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p22.png',
      0,
      [
        'blue-green or yellow-green wiggly line',
        'blue-green and red line',
        'No line, just colours'
      ],
      [
        'Normal color vision',
        'Red green color blind',
        'total color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p23.png',
      0,
      [
        'red and orange wiggly line',
        'red and blue-green wiggly line',
        'No line, just colours'
      ],
      [
        'Normal color vision',
        'Red green color blind',
        'total color blindness',
      ],
    ),
    TestPlate(
      'What do you see in this image?',
      'assets/ishihara/p24.png',
      0,
      ['line', 'something else'],
      [
        'All people should see a number 12, including those with total color blindness',
        'Please see the plate before answering'
      ],
    ),
  ];
}
