import 'dart:io' as io;

String currentPath = '';
Map<String, Directory> fileSystem = <String, Directory>{};

Future<void> main() async {
  final io.File input = io.File('input.txt');
  final List<String> lines = await input.readAsLines();

  lines.forEach((element) => parseLine(element));

  int totalSize = 0;
  int totalDiskSize = 70000000;
  int totalUsedSpace = fileSystem['/']!.calculateSize();
  int freeSpace = totalDiskSize - totalUsedSpace;
  int treshold = 30000000 - freeSpace;

  final List<Directory> targetDirectories = fileSystem.values
      .where((Directory dir) => dir.calculateSize() >= treshold)
      .toList();
  targetDirectories
      .sort((a, b) => a.calculateSize().compareTo(b.calculateSize()));

  print('Target dir size: ${targetDirectories.first.calculateSize()}');
}

void parseLine(String line) {
  final List<String> instruction = line.split(' ');

  if (instruction[0] == '\$') {
    parseCommand(
        instruction[1], instruction.length > 2 ? instruction[2] : null);
  } else if (instruction[0] == 'dir') {
    return;
  } else {
    createFile(instruction[1], int.parse(instruction[0]));
  }
}

void parseCommand(String command, String? argument) {
  if (command == 'cd') {
    changeDirectory(argument!);
  }
}

void changeDirectory(String argument) {
  if (argument == '/') {
    currentPath = '/';
    createDirectory(currentPath, '');
  } else if (argument == '..') {
    currentPath = currentPath.substring(0, currentPath.lastIndexOf('/'));
    if (currentPath.isEmpty) {
      currentPath = '/';
    }
  } else {
    currentPath = currentPath == '/' ? '/$argument' : '$currentPath/$argument';
    createDirectory(currentPath, argument);
  }
}

void createDirectory(String path, String name) {
  if (fileSystem.containsKey(path)) {
    return;
  }

  final Directory directory = Directory(path: path, name: name);
  fileSystem[path] = directory;

  if (path == '/') {
    return;
  }

  String parentPath = path.substring(0, path.lastIndexOf('/'));
  if (parentPath.isEmpty) {
    parentPath = '/';
  }
  fileSystem[parentPath]?.subDirectories.add(directory);
}

void createFile(String name, int size) {
  final File file = File(
    path: currentPath,
    name: name,
    size: size,
  );

  fileSystem[currentPath]!.files.add(file);
}

class Directory {
  Directory({
    required this.path,
    required this.name,
  });

  final List<Directory> subDirectories = <Directory>[];
  final List<File> files = <File>[];
  final String path;
  final String name;

  int calculateSize() {
    int totalSize = 0;

    for (File file in files) {
      totalSize += file.size;
    }

    for (Directory sub in subDirectories) {
      totalSize += sub.calculateSize();
    }

    return totalSize;
  }
}

class File {
  const File({
    required this.path,
    required this.name,
    required this.size,
  });

  final String path;
  final String name;
  final int size;
}
