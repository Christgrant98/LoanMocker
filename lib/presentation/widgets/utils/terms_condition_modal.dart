import 'package:flutter/material.dart';

import 'text_view.dart';

class TermsConditionContent extends StatelessWidget {
  const TermsConditionContent({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              TextView(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod eget justo sit amet dignissim. Pellentesque auctor ipsum nec ligula sollicitudin, a lobortis justo auctor. Praesent sed tincidunt nisl. Sed euismod tincidunt ante nec tincidunt. Sed fermentum libero vel velit ultrices, non interdum tortor rhoncus. Nulla facilisi. Donec eget consequat elit. Sed id odio sed ex interdum venenatis. Quisque vehicula, justo vel tristique bibendum, nunc risus vulputate libero, nec placerat nisi orci id lectus.',
                  textAlign: TextAlign.justify,
                  fontSize: 10),
              SizedBox(
                height: 15,
              ),
              TextView(
                  text:
                      'Sed ac posuere mi. Phasellus blandit feugiat nisi, id feugiat felis venenatis vel. Ut vehicula ex at urna hendrerit interdum. Cras suscipit dolor non bibendum finibus. Duis massa nibh, iaculis nec ornare et, imperdiet vitae magna. Aliquam nec metus sollicitudin elit tincidunt tempus in sit amet enim. Nulla elementum, lectus eu sagittis congue, neque augue bibendum enim, molestie porta nulla neque a diam. Morbi imperdiet magna neque, a commodo sem sagittis at. Curabitur commodo fringilla nibh, et laoreet leo. Praesent et consectetur tortor. Nulla elementum porta nunc, et pretium leo molestie eget. Etiam id fermentum lorem. Aliquam non nibh a felis convallis efficitur sed at sapien.',
                  textAlign: TextAlign.justify,
                  fontSize: 10),
              SizedBox(
                height: 15,
              ),
              TextView(
                  text:
                      'Maecenas imperdiet augue enim, eu pharetra nunc aliquet vitae. Etiam mollis pharetra lectus id fringilla. Suspendisse quis scelerisque lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In at nunc eu diam imperdiet semper sed vel eros. Praesent nec malesuada massa, id venenatis mi. Nunc sit amet turpis et mauris venenatis dignissim vel eu metus.',
                  textAlign: TextAlign.justify,
                  fontSize: 10),
              SizedBox(
                height: 15,
              ),
              TextView(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod eget justo sit amet dignissim. Pellentesque auctor ipsum nec ligula sollicitudin, a lobortis justo auctor. Praesent sed tincidunt nisl. Sed euismod tincidunt ante nec tincidunt. Sed fermentum libero vel velit ultrices, non interdum tortor rhoncus. Nulla facilisi. Donec eget consequat elit. Sed id odio sed ex interdum venenatis. Quisque vehicula, justo vel tristique bibendum, nunc risus vulputate libero, nec placerat nisi orci id lectus.',
                  textAlign: TextAlign.justify,
                  fontSize: 10),
              SizedBox(
                height: 15,
              ),
              TextView(
                  text:
                      'Maecenas imperdiet augue enim, eu pharetra nunc aliquet vitae. Etiam mollis pharetra lectus id fringilla. Suspendisse quis scelerisque lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In at nunc eu diam imperdiet semper sed vel eros. Praesent nec malesuada massa, id venenatis mi. Nunc sit amet turpis et mauris venenatis dignissim vel eu metus.',
                  textAlign: TextAlign.justify,
                  fontSize: 10),
              SizedBox(
                height: 15,
              ),
              TextView(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod eget justo sit amet dignissim. Pellentesque auctor ipsum nec ligula sollicitudin, a lobortis justo auctor. Praesent sed tincidunt nisl. Sed euismod tincidunt ante nec tincidunt. Sed fermentum libero vel velit ultrices, non interdum tortor rhoncus. Nulla facilisi. Donec eget consequat elit. Sed id odio sed ex interdum venenatis. Quisque vehicula, justo vel tristique bibendum, nunc risus vulputate libero, nec placerat nisi orci id lectus.',
                  textAlign: TextAlign.justify,
                  fontSize: 10),
            ],
          ),
        ),
      );
}
