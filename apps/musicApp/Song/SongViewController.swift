//
//  SongViewController.swift
//  musicApp
//
//  Created by Yibriam on 07/11/25.
//

import UIKit

struct Song {
    let title: String
    let artist: String
    let album: String
    let duration: TimeInterval
    let albumImage: UIImage
}

class SongViewController: UIViewController {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playbackSlider: UISlider!
    @IBOutlet weak var elapsedLabel: UILabel!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!

    var songs: [Song] = []
    var currentSongIndex = 0
    var playbackTimer: Timer?
    var currentPlaybackTime: TimeInterval = 0
    var isPlaying = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSongs()
        loadCurrentSong()
    }

    func setupSongs() {
        songs = [
            Song(title: "Dream On", artist: "Aerosmith", album: "Dream On", duration: 268, albumImage: UIImage(named: "album1")!),
            Song(title: "The Pretender", artist: "Foo Fighters", album: "Echoes, Silence, Patience & Grace", duration: 270, albumImage: UIImage(named: "album2")!),
            Song(title: "One", artist: "Metallica", album: "...And Justice for All", duration: 447, albumImage: UIImage(named: "album3")!)
        ]
    }

    func loadCurrentSong() {
        stopPlayback()
        currentPlaybackTime = 0
        let song = songs[currentSongIndex]
        titleLabel.text = song.title
        artistLabel.text = song.artist
        albumLabel.text = song.album
        albumImageView.image = song.albumImage
        playbackSlider.value = 0
        updatePlaybackUI()
        updatePlayPauseButton()
    }


    func startPlayback() {
        playbackTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            guard self.currentPlaybackTime < self.songs[self.currentSongIndex].duration else {
                self.forwardTapped(nil)
                return
            }
            self.currentPlaybackTime += 1
            self.updatePlaybackUI()
        }
    }

    func stopPlayback() {
        playbackTimer?.invalidate()
        playbackTimer = nil
    }

    func updatePlaybackUI() {
        let song = songs[currentSongIndex]
        playbackSlider.value = Float(currentPlaybackTime / song.duration)
        elapsedLabel.text = formatTime(currentPlaybackTime)
        remainingLabel.text = formatTime(song.duration - currentPlaybackTime)
    }

    func updatePlayPauseButton() {
        let imageName = isPlaying ? "pause_icon" : "play_icon"
        playPauseButton.setImage(UIImage(named: imageName), for: .normal)
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    @IBAction func playPauseTapped(_ sender: UIButton?) {
        isPlaying.toggle()
        updatePlayPauseButton()
        isPlaying ? startPlayback() : stopPlayback()
    }

    @IBAction func backTapped(_ sender: UIButton?) {
        currentSongIndex = max(currentSongIndex - 1, 0)
        loadCurrentSong()
        isPlaying = false
    }

    @IBAction func forwardTapped(_ sender: UIButton?) {
        currentSongIndex = min(currentSongIndex + 1, songs.count - 1)
        loadCurrentSong()
        isPlaying = false
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let song = songs[currentSongIndex]
        currentPlaybackTime = TimeInterval(sender.value) * song.duration
        updatePlaybackUI()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
