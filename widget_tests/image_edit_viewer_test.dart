import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit_bel_ham/components/add_post_components/add_post_clear_button.dart';
import 'package:reddit_bel_ham/components/add_post_components/image_edit_viewer.dart';

void main() {
  group('ImageEditViewer', () {
    late List<XFile> initialChoices;
    late Function() removeImage;
    late Function(List<XFile>) updateXFileList;

    setUp(() {
      initialChoices = [
        XFile('path/to/image1.jpg'),
      ];
      removeImage = () {};
      updateXFileList = (List<XFile> files) {};
    });

    testWidgets('renders CarouselSlider with chosen images', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ImageEditViewer(
            removeImage: removeImage,
            updateXFileList: updateXFileList,
            initialChoices: initialChoices,
          ),
        ),
      );

      expect(find.byType(CarouselSlider), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(initialChoices.length));
    });

    testWidgets('calls removeImage when ClearButton is pressed', (WidgetTester tester) async {
      bool removeImageCalled = false;
      removeImage = () {
        removeImageCalled = true;
      };

      await tester.pumpWidget(
        MaterialApp(
          home: ImageEditViewer(
            removeImage: removeImage,
            updateXFileList: updateXFileList,
            initialChoices: initialChoices,
          ),
        ),
      );

      await tester.tap(find.byType(AddPostClearButton));
      await tester.pumpAndSettle();

      expect(removeImageCalled, true);
    });

  });
}