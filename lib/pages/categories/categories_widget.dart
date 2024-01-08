import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/nav_bar1/nav_bar1_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'categories_model.dart';
export 'categories_model.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({
    super.key,
    required this.tracktest,
    required this.tracklisttest,
    required this.indextest,
  });

  final String? tracktest;
  final List<String>? tracklisttest;
  final int? indextest;

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  late CategoriesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoriesModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pushNamed('Home');
            },
          ),
          title: Text(
            'categories',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Noto Kufi Arabic',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 200.0, 0.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      FFAppState().currentTrackIndex.toString(),
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    FutureBuilder<List<TracksRecord>>(
                      future: queryTracksRecordOnce(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<TracksRecord> listViewTracksRecordList =
                            snapshot.data!;
                        return ListView.builder(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            0,
                            0,
                            100.0,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewTracksRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewTracksRecord =
                                listViewTracksRecordList[listViewIndex];
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  FFAppState().currentURL =
                                      listViewTracksRecord.audioUrl;
                                  FFAppState().trackID =
                                      listViewTracksRecord.reference.id;
                                  FFAppState().trackList = (currentUserDocument
                                              ?.userTracks
                                              .toList() ??
                                          [])
                                      .map((e) => e.trackId)
                                      .toList()
                                      .cast<String>();
                                  FFAppState().currentTrackIndex =
                                      listViewIndex;
                                });

                                context.pushNamed(
                                  'Categories',
                                  queryParameters: {
                                    'tracktest': serializeParam(
                                      listViewTracksRecord.audioUrl,
                                      ParamType.String,
                                    ),
                                    'tracklisttest': serializeParam(
                                      listViewTracksRecord.trackUrlList,
                                      ParamType.String,
                                      true,
                                    ),
                                    'indextest': serializeParam(
                                      FFAppState().currentTrackIndex,
                                      ParamType.int,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: const TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );

                                setState(() {
                                  FFAppState().openAudio = true;
                                });
                                setState(() {
                                  FFAppState().trackID =
                                      listViewTracksRecord.reference.id;
                                });
                                setState(() {
                                  FFAppState().playerState = true;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 74.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 65.0,
                                                    height: 65.0,
                                                    decoration: const BoxDecoration(),
                                                    child: Hero(
                                                      tag: listViewTracksRecord
                                                          .audioThumbnail,
                                                      transitionOnUserGestures:
                                                          true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.network(
                                                          listViewTracksRecord
                                                              .audioThumbnail,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 50.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Text(
                                                        listViewTracksRecord
                                                            .title,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.play_arrow,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ].divide(const SizedBox(height: 30.0)),
                ),
              ),
            ),
            wrapWithModel(
              model: _model.navBar1Model,
              updateCallback: () => setState(() {}),
              child: const NavBar1Widget(),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 50.0, 20.0, 0.0),
              child: Container(
                width: double.infinity,
                height: 153.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
