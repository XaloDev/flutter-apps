import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {


  ImageSourceSheet({this.onImageSelected});

  final Function(File) onImageSelected;
  final ImagePicker picker = ImagePicker();



  @override
  Widget build(BuildContext context){


    Future<void> editImage(String path) async {
     final File croppedFile = await ImageCropper.cropImage(
          sourcePath: path,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Editar Imagem',
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
          ),
        iosUiSettings: const IOSUiSettings(
          title: 'Editar imagem',
          cancelButtonTitle: 'Cancelar',
            doneButtonTitle: 'Concluir'
        )
      );
     if(croppedFile != null){
       onImageSelected(croppedFile);
     }
    }


    if(Platform.isAndroid) {
      return BottomSheet(
        onClosing: (){},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              onPressed: () async {
                final PickedFile file =
                await picker.getImage(source: ImageSource.camera);
                editImage(file.path);
              },
              child: const Text('Câmera'),
            ),
            FlatButton(
              onPressed: () async {
                final PickedFile file =
                await picker.getImage(source: ImageSource.gallery);
                editImage(file.path);
              },
              child: const Text('Galeria'),
            ),

          ],

        ),
    );
    } else {
      return CupertinoActionSheet(
          message: const Text('Escolha a origem da foto'),
          cancelButton: CupertinoActionSheetAction(
            onPressed: Navigator.of(context).pop,
            child: const Text('Cancelar',style: TextStyle(color: Colors.red),),
          ),
        actions: <Widget> [
          CupertinoActionSheetAction(
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
              editImage(file.path);
              },
              child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
              editImage(file.path);
            },
            child: const Text('Galeria'),
          )
        ],
      );
    }
  }
}
