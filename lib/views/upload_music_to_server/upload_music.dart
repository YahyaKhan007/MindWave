import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app_using_bloc/bloc/upload_music/upload_music_bloc.dart';
import 'package:music_app_using_bloc/models/music_model.dart';

import '../Utils/utils.dart';

class UploadMusicToServer extends StatefulWidget {
  final String folderName;
  final MusicModel musicFoldr;
  const UploadMusicToServer(
      {super.key, required this.folderName, required this.musicFoldr});

  @override
  State<UploadMusicToServer> createState() => _UploadMusicToServerState();
}

class _UploadMusicToServerState extends State<UploadMusicToServer> {
  TextEditingController nameController = TextEditingController();
  FocusNode nameControllerFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        centerTitle: true,
        title: Text(
          // "UPLOAD MUSIC TO SERVER",
          "UPLOAD TO ${widget.folderName}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17.sp, letterSpacing: -1),
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 10.w),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: theme.brightness == Brightness.dark
                  ? AppShadows.blackThemeShadow
                  : AppShadows.lightThemeShadow),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.surface,
              child: Icon(
                Icons.arrow_back,
                color: theme.colorScheme.onSurface,
                size: 20.r,
              ),
            ),
          ),
        ),
      ),
      body: Align(
          alignment: Alignment.center,
          child: BlocBuilder<UploadMusicBloc, UploadMusicState>(
            builder: (context, state) {
              if (state.fileName != null && state.file != null) {
                nameController.text = state.fileName!;
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Visibility(
                    //   visible: state.file != null ? false : true,
                    //   child: InkWell(
                    //     onTap: () async {
                    //       // Get.to(() => OneClicLogin());

                    //       // try {
                    //       //   final MusicModel musicModel = MusicModel(
                    //       //       instrumental: [],
                    //       //       ambients: [],
                    //       //       nature: [],
                    //       //       traditional: [],
                    //       //       guided: [],
                    //       //       binaural: [],
                    //       //       chants: [],
                    //       //       mindfulness: [],
                    //       //       yoga: [],
                    //       //       solfeggio: [],
                    //       //       gentle: [],
                    //       //       peacefull: [],
                    //       //       sunrise: [],
                    //       //       soft: [],
                    //       //       heaven: []);

                    //       //   // ^ ------------------------------

                    //       //   await FirebaseFirestore.instance
                    //       //       .collection("meditation_music")
                    //       //       .doc('Q3e167zbw0VBXoFXGYDqqPYVF2v2')
                    //       //       .set(musicModel.toJson())
                    //       //       .then((value) =>
                    //       //           Get.showSnackbar(const GetSnackBar(
                    //       //             message: 'Done',
                    //       //             title: 'Done',
                    //       //             backgroundColor: Colors.green,
                    //       //           )));
                    //       //   Get.back();
                    //       //   Get.dialog(GetSnackBar(
                    //       //     title: 'done',
                    //       //     message: 'done',
                    //       //     backgroundColor: Colors.green,
                    //       //   ));
                    //       // } catch (e) {
                    //       //   Get.back();
                    //       //   Get.back();
                    //       //   Get.dialog(GetSnackBar(
                    //       //     title: 'done',
                    //       //     message: 'done',
                    //       //     backgroundColor: Colors.red,
                    //       //   ));
                    //       // }

                    //       try {
                    //         Get.dialog(Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             AlertDialog(
                    //               contentPadding: EdgeInsets.zero,
                    //               titlePadding: EdgeInsets.zero,
                    //               backgroundColor:
                    //                   Colors.transparent.withOpacity(0.1),
                    //               content: Center(
                    //                   child: CircularProgressIndicator.adaptive(
                    //                 backgroundColor:
                    //                     Theme.of(context).colorScheme.onSurface,
                    //               )),
                    //             ),
                    //           ],
                    //         ));
                    //         final MusicModel musicModel = MusicModel(
                    //             instrumental: [],
                    //             ambients: [],
                    //             nature: [],
                    //             traditional: [],
                    //             guided: [],
                    //             binaural: [],
                    //             chants: [],
                    //             mindfulness: [],
                    //             yoga: [],
                    //             solfeggio: [],
                    //             gentle: [],
                    //             peacefull: [],
                    //             sunrise: [],
                    //             soft: [],
                    //             heaven: []);
                    //         // ... your model initialization ...

                    //         await FirebaseFirestore.instance
                    //             .collection("meditation_music")
                    //             .doc('Q3e167zbw0VBXoFXGYDqqPYVF2v2')
                    //             .set(musicModel.toJson())
                    //             .then((value) {
                    //           Get.showSnackbar(const GetSnackBar(
                    //             message: 'Done',
                    //             title: 'Done',
                    //             backgroundColor: Colors.green,
                    //           ));
                    //           Get.back();
                    //         });
                    //       } catch (e) {
                    //         log("Error: $e");
                    //         Get.back();
                    //         Get.dialog(const GetSnackBar(
                    //           title: 'Error',
                    //           message: 'An error occurred. Please try again.',
                    //           backgroundColor: Colors.red,
                    //         ));
                    //       }
                    //     },
                    //     child: Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 20.w, vertical: 15.h),
                    //       decoration: BoxDecoration(
                    //           boxShadow: theme.brightness == Brightness.light
                    //               ? AppShadows.lightThemeShadow
                    //               : AppShadows.blackThemeShadow,
                    //           borderRadius: BorderRadius.circular(15.r),
                    //           color: theme.colorScheme.surface),
                    //       child: Text(
                    //         "Create FireStore Collection",
                    //         style: TextStyle(
                    //             color: theme.colorScheme.onSurface,
                    //             fontWeight: FontWeight.w700,
                    //             letterSpacing: 0),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Visibility(
                      visible: state.file != null ? false : true,
                      child: InkWell(
                        onTap: () {
                          context
                              .read<UploadMusicBloc>()
                              .add(MusicPickerEvent());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 15.h),
                          decoration: BoxDecoration(
                              boxShadow: theme.brightness == Brightness.light
                                  ? AppShadows.lightThemeShadow
                                  : AppShadows.blackThemeShadow,
                              borderRadius: BorderRadius.circular(15.r),
                              color: theme.colorScheme.surface),
                          child: Text(
                            "Pick Music",
                            style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: state.file != null ? true : false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              splashColor: null,
                              focusColor: null,
                              hoverColor: null,
                              overlayColor: null,
                              highlightColor: null,
                              onTap: () {
                                nameControllerFocus.unfocus();
                              },
                              child: Container(
                                height: size.height * .3,
                                width: size.width * .6,
                                decoration: BoxDecoration(
                                    boxShadow:
                                        theme.brightness == Brightness.light
                                            ? AppShadows.lightThemeShadow
                                            : AppShadows.blackThemeShadow,
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: theme.colorScheme.surface),
                                child: Center(
                                  child: Icon(
                                    Icons.audio_file_outlined,
                                    size: 90.sp,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: Text(state.fileName != null
                                  ? state.fileName.toString()
                                  : ''),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 25.w),
                            //   child: TextFormField(
                            //     focusNode: nameControllerFocus,
                            //     cursorColor: theme.colorScheme.onSurface,
                            //     minLines: 1,
                            //     maxLines: 5,
                            //     controller: nameController,
                            //     decoration: const InputDecoration(
                            //         border: InputBorder.none),
                            //   ),
                            // ),
                          ],
                        )),
                    SizedBox(
                      height: 35.h,
                    ),
                    Visibility(
                      visible: state.file != null ? true : false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              log(state.fileName.toString());
                              log(state.file.toString());
                              log(widget.folderName.toString());
                              log(widget.musicFoldr.toString());

                              context.read<UploadMusicBloc>().add(
                                  MusicUploading(
                                      musicModel: widget.musicFoldr,
                                      choosedFile: state.file!,
                                      choosedFileName: state.fileName!,
                                      isLoading: true,
                                      folderName: widget.folderName));
                              try {
                                if (state.isLoading == true) {
                                  // Get.dialog(AlertDialog(
                                  //   title: Center(
                                  //     child: CircularProgressIndicator(
                                  //       color: theme.colorScheme.onSurface,
                                  //     ),
                                  //   ),
                                  // ));
                                } else {}
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                  boxShadow:
                                      theme.brightness == Brightness.light
                                          ? AppShadows.lightThemeShadow
                                          : AppShadows.blackThemeShadow,
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: theme.colorScheme.surface),
                              child: Text(
                                "Upload Music",
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0),
                              ),
                            ),
                          ),
                          InkWell(
                            // onTap: () {
                            //   log(nameController.text.toString());
                            // },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                  boxShadow:
                                      theme.brightness == Brightness.light
                                          ? AppShadows.lightThemeShadow
                                          : AppShadows.blackThemeShadow,
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: theme.colorScheme.surface),
                              child: Text(
                                "Reset",
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
