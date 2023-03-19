import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _bgMusicPlayer = AudioPlayer();
  final AudioPlayer _correctAnswerPlayer = AudioPlayer();
  final AudioPlayer _wrongAnswerPlayer = AudioPlayer();

  bool _canSFXPlay = true;
  bool _canBGMusicPlay = true;

  IconData _musicSettingsIcon = Icons.headphones;
  IconData _sfxSettingsIcon = Icons.music_note;

// Background Music Settings

  void playBGMusic() async {
    if (_bgMusicPlayer.state == PlayerState.stopped) {
      await _bgMusicPlayer.setPlaybackRate(1.25);
      await _bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgMusicPlayer.play(AssetSource("music.mp3"));
    }
    notifyListeners();
  }

  void pauseBGMusic() async {
    if (_bgMusicPlayer.state == PlayerState.playing) {
      await _bgMusicPlayer.pause();
    }
    notifyListeners();
  }

  void resumeBGMusic() async {
    if (_bgMusicPlayer.state == PlayerState.paused) {
      await _bgMusicPlayer.resume();
    }
  }

  void checkMusicSettings() async {
    _canBGMusicPlay = !_canBGMusicPlay;
    if (_canBGMusicPlay) {
      await _bgMusicPlayer.setVolume(1);
      _musicSettingsIcon = Icons.headset;
    } else {
      await _bgMusicPlayer.setVolume(0);
      _musicSettingsIcon = Icons.headset_off;
    }
    notifyListeners();
  }

  IconData getMusicSettingsIcon() {
    return _musicSettingsIcon;
  }

// SFX Functions

  void playCorrectAnswerAudio() {
    if (_canSFXPlay) {
      _correctAnswerPlayer.play(AssetSource("correct.mp3"));
    }
    notifyListeners();
  }

  void playWrongAnswerAudio() {
    if (_canSFXPlay) {
      _wrongAnswerPlayer.play(AssetSource("wrong.mp3"));
    }
    notifyListeners();
  }

  void checkSFXSettings() {
    _canSFXPlay = !_canSFXPlay;
    _sfxSettingsIcon = _canSFXPlay ? Icons.music_note : Icons.music_off;
    notifyListeners();
  }

  IconData getSFXSettingsIcon() {
    return _sfxSettingsIcon;
  }
}
