import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'player_model.dart';
export 'player_model.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({
    super.key,
    required this.track,
    required this.tracklist,
    required this.tracktitle,
  });

  final String? track;
  final List<String>? tracklist;
  final List<String>? tracktitle;

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  late PlayerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlayerModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().playerState = true;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: const AlignmentDirectional(-1.0, 0.0),
          image: Image.asset(
            'assets/images/NEW2_LOGO-TRANS.png',
          ).image,
        ),
        gradient: LinearGradient(
          colors: [
            FlutterFlowTheme.of(context).primary,
            FlutterFlowTheme.of(context).accent1
          ],
          stops: const [0.0, 1.0],
          begin: const AlignmentDirectional(0.0, -1.0),
          end: const AlignmentDirectional(0, 1.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).primary,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: Icon(
                    Icons.arrow_back,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
                width: 1.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/new-qasas-f219mx/assets/3tgx6hyivp6h/NEW2_LOGO-PWA-512-Noa.png',
                width: 300.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: custom_widgets.QasasPlayer(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  initialUrl: FFAppConstants.initialTrack,
                  sliderActiveColor: FlutterFlowTheme.of(context).secondary,
                  sliderInactiveColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  backwardIconPath: Icon(
                    Icons.replay_10,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  forwardIconPath: Icon(
                    Icons.forward_10,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  backwardIconColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  forwardIconColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  pauseIconPath: Icon(
                    Icons.pause_sharp,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  playIconPath: Icon(
                    Icons.play_arrow,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  pauseIconColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  playIconColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  playbackDurationTextColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  previousIconPath: Icon(
                    Icons.skip_previous_sharp,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  nextIconPath: Icon(
                    Icons.skip_next,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  previousIconColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  nextIconColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  dropdownTextColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  timerIcon: Icon(
                    Icons.timer_sharp,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  playlistImage:
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/new-qasas-f219mx/assets/3tgx6hyivp6h/NEW2_LOGO-PWA-512-Noa.png',
                  musicUrls: FFAppConstants.tracks,
                  musicTitles: FFAppConstants.titles,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
