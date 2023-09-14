import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_taggy/flutter_taggy.dart';

Future<void> handleTaggyMethodCall(
  BuildContext context,
  Future<dynamic> fileFuture,
) async {
  try {
    final result = await fileFuture;
    //ignore:use_build_context_synchronously
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * .5,
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const Text(
                  'Operation was a success! below is the result:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                if (result is TaggyFile)
                  Text(result.formatAsString())
                else
                  const Text(
                      'None; the operation does not return a [TaggyFile]'),
              ],
            ),
          ),
        );
      },
    );
  } catch (e) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sorry, an error occurred'),
          content: Text(e.toString()),
        );
      },
    );
  }
}

Tag getDefaultTag() {
  return Tag(
    tagType: TagType.FilePrimaryType,
    album: '',
    trackTitle: '',
    trackArtist: '',
    trackTotal: 10,
    trackNumber: 1,
    discNumber: 1,
    discTotal: 2,
    year: null,
    recordingDate: '',
    language: '',
    pictures: [],
  );
}
