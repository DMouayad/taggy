import 'dart:math';

import 'package:example/utils.dart';
import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/material.dart';
import 'package:flutter_taggy/flutter_taggy.dart';

/// Taggy's theme color
const kTaggyColor = Color(0xFF44A5DD);

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  double get screenWidth => MediaQuery.of(this).size.width;
}

void main() {
  // Remember to call [initialize] before you use [flutter_taggy]
  Taggy.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter_taggy Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kTaggyColor),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPickingAFile = false;
  String? pickedFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primaryContainer,
        title: const Text("Taggy Demo"),
      ),
      body: Center(
        child: ListView(
          children: [
            FileSelectionSection(
                onSelectFile: onSelectFile, pickedFilePath: pickedFilePath),
            if (pickedFilePath != null) ...[
              const ListTile(
                title: Text(
                  'Second:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'From the features-sections below, choose the action that you would like to explore:',
                ),
              ),
              ReadTagsSection(filePath: pickedFilePath!),
              const SizedBox(height: 10),
              WritingTagsSection(filePath: pickedFilePath!),
              const SizedBox(height: 10),
              RemoveTagsSection(filePath: pickedFilePath!),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> onSelectFile() async {
    if (isPickingAFile) {
      return;
    } else {
      isPickingAFile = true;
      final pickedFile = await fp.FilePicker.platform.pickFiles(
        allowCompression: false,
        type: fp.FileType.custom,
        lockParentWindow: true,
        allowedExtensions: [
          'FLAC',
          'Flac',
          'aac',
          'mp3',
          'mp4',
          'wav',
        ],
      );
      isPickingAFile = false;
      // we only need the path from the picked file
      setState(() {
        pickedFilePath = pickedFile?.paths.first;
      });
    }
  }
}

class FileSelectionSection extends StatelessWidget {
  const FileSelectionSection({
    super.key,
    required this.onSelectFile,
    required this.pickedFilePath,
  });

  final void Function() onSelectFile;
  final String? pickedFilePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const ListTile(
          title: Text('First:', style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text(
            'You need to specify the path of the file you want to perform the action(s) on.',
          ),
        ),
        Expanded(
          flex: 0,
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.center,
            children: [
              const Text(
                'Selected file path: ',
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: kTaggyColor),
              ),
              Text('"${pickedFilePath ?? 'None'}"'),
              SizedBox(width: MediaQuery.of(context).size.width * .3),
              TextButton.icon(
                onPressed: onSelectFile,
                label: const Text("choose an audio file"),
                icon: const Icon(Icons.file_open_outlined),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class ReadTagsSection extends StatelessWidget {
  const ReadTagsSection({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Reading Tags',
      iconData: Icons.sticky_note_2_outlined,
      content: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          FilledButton.tonal(
            onPressed: () =>
                handleTaggyMethodCall(context, Taggy.readAll(filePath)),
            child: const Text('Read all'),
          ),
          FilledButton.tonal(
            onPressed: () =>
                handleTaggyMethodCall(context, Taggy.readPrimary(filePath)),
            child: const Text('Read Primary'),
          ),
          FilledButton.tonal(
            onPressed: () =>
                handleTaggyMethodCall(context, Taggy.readAny(filePath)),
            child: const Text('Read any'),
          ),
        ],
      ),
    );
  }
}

class WritingTagsSection extends StatefulWidget {
  const WritingTagsSection({super.key, required this.filePath});

  final String filePath;

  @override
  State<WritingTagsSection> createState() => _WritingTagsSectionState();
}

class _WritingTagsSectionState extends State<WritingTagsSection> {
  double tagsToWriteCount = 1;
  List<Tag> tags = [];
  Tag tag = const Tag(tagType: TagType.FilePrimaryType, pictures: []);
  bool keepOtherTags = false;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Writing Tags',
      iconData: Icons.edit_outlined,
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: context.screenWidth * .8,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 10,
            runSpacing: 12,
            children: [
              Text(
                'Writing as the primary tag:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.onPrimaryContainer,
                ),
              ),
              FilledButton.tonal(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          width: min(context.screenWidth * .8, 500),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 18),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Tag properties',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  FilledButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('DONE'),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  children: [
                                    TagPropTextField(
                                      label: 'Track title',
                                      initialValue: tag.trackTitle,
                                      onChanged: (value) {
                                        tag = tag.copyWith(trackTitle: value);
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Track Artist',
                                      initialValue: tag.trackArtist,
                                      onChanged: (value) {
                                        tag = tag.copyWith(trackArtist: value);
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Track Album',
                                      initialValue: tag.album,
                                      onChanged: (value) {
                                        tag = tag.copyWith(album: value);
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Album Artist',
                                      initialValue: tag.albumArtist,
                                      onChanged: (value) {
                                        tag = tag.copyWith(albumArtist: value);
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Producer',
                                      initialValue: tag.producer,
                                      onChanged: (value) {
                                        tag = tag.copyWith(producer: value);
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Release Date',
                                      initialValue: tag.originalReleaseDate,
                                      onChanged: (value) {
                                        tag = tag.copyWith(
                                            originalReleaseDate: value);
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Recording Date',
                                      initialValue: tag.recordingDate,
                                      onChanged: (value) {
                                        tag =
                                            tag.copyWith(recordingDate: value);
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Year',
                                      initialValue: tag.year?.toString(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          tag = tag.copyWith(
                                              year: int.tryParse(value));
                                        } else {
                                          tag = tag.copyWith(year: null);
                                        }
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Track Number',
                                      initialValue: tag.trackNumber?.toString(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          tag = tag.copyWith(
                                              trackNumber: int.tryParse(value));
                                        } else {
                                          tag = tag.copyWith(trackNumber: null);
                                        }
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Track total',
                                      initialValue: tag.trackTotal?.toString(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          tag = tag.copyWith(
                                              trackTotal: int.tryParse(value));
                                        } else {
                                          tag = tag.copyWith(trackTotal: null);
                                        }
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Disc Number',
                                      initialValue: tag.discNumber?.toString(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          tag = tag.copyWith(
                                              discNumber: int.tryParse(value));
                                        } else {
                                          tag = tag.copyWith(discNumber: null);
                                        }
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Disc total',
                                      initialValue: tag.discTotal?.toString(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          tag = tag.copyWith(
                                              discTotal: int.tryParse(value));
                                        } else {
                                          tag = tag.copyWith(discTotal: null);
                                        }
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Genre',
                                      initialValue: tag.genre,
                                      onChanged: (value) {
                                        tag = tag.copyWith(genre: value);
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Language',
                                      initialValue: tag.language,
                                      onChanged: (value) {
                                        tag = tag.copyWith(language: value);
                                      },
                                    ),
                                    TagPropTextField(
                                      label: 'Lyrics',
                                      initialValue: tag.lyrics,
                                      onChanged: (value) {
                                        tag = tag.copyWith(lyrics: value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('view/edit "tag-to-write"'),
              ),
              SizedBox(
                width: 230,
                child: CheckboxListTile(
                  title: const Text(
                    'Should keep other tags: ',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: keepOtherTags,
                  onChanged: (value) {
                    setState(() => keepOtherTags = value ?? false);
                  },
                ),
              ),
              FilledButton.tonal(
                onPressed: () {
                  handleTaggyMethodCall(
                    context,
                    Taggy.writePrimary(
                      path: widget.filePath,
                      tag: tag,
                      keepOthers: keepOtherTags,
                    ),
                  );
                },
                child: const Text('Write to file'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagPropTextField extends StatelessWidget {
  const TagPropTextField({
    super.key,
    this.initialValue,
    required this.label,
    required this.onChanged,
  });

  final String? initialValue;
  final String label;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        onChanged: onChanged,
        initialValue: initialValue,
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: context.colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}

class RemoveTagsSection extends StatefulWidget {
  const RemoveTagsSection({super.key, required this.filePath});

  final String filePath;

  @override
  State<RemoveTagsSection> createState() => _RemoveTagsSectionState();
}

class _RemoveTagsSectionState extends State<RemoveTagsSection> {
  TagType tagToRemoveType = TagType.FilePrimaryType;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Removing Tags',
      iconData: Icons.sticky_note_2_outlined,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Remove all tags:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () => handleTaggyMethodCall(
                      context, Taggy.removeAll(widget.filePath)),
                  child: const Text('Remove All'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'Remove by Tag type: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  DropdownMenu(
                    onSelected: (type) {
                      if (type != null) {
                        setState(() => tagToRemoveType = type);
                      }
                    },
                    hintText: 'Select tag type',
                    dropdownMenuEntries: TagType.values
                        .map((e) => DropdownMenuEntry(
                              value: e,
                              label: e.name,
                            ))
                        .toList(),
                  ),
                  const SizedBox(width: 20),
                  FilledButton.tonal(
                    onPressed: () {
                      handleTaggyMethodCall(
                        context,
                        Taggy.removeTag(
                            path: widget.filePath, tagType: tagToRemoveType),
                      );
                    },
                    child: const Text("Remove"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.iconData,
    required this.content,
  });

  final String title;
  final IconData iconData;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withOpacity(.2),
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            leading: Icon(iconData, color: context.colorScheme.primary),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          content,
        ],
      ),
    );
  }
}
