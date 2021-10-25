//
//  VideoViewController.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import UIKit
import AVKit
import AVFoundation
import Combine
@available(iOS 13.0, *)
class VideoViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var imageVideo: UIImageView!
    @IBOutlet weak var pitchView: UITextView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Variable
    var bag = Set<AnyCancellable>()
    var viewModel = VideoViewModel()
    var image: String = ""
    var detail : Detail?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        // Do any additional setup after loading the view.
    }
    
    func initViewMode(viewModel : VideoViewModel) {
        self.viewModel = viewModel
    }
    
    private func bindViewModel() {
        titleLabel.text = viewModel.titleT.value
        subtitleLabel.text = viewModel.subtitle.value
        viewModel.pitch.sink(receiveValue: {
            pitch in
            self.pitchView.text = pitch
        }).store(in: &bag)
        viewModel.connexion.sink(receiveValue: {
            isError  in
            if isError {
                showError(errorDescription: NSLocalizedString("NoConnection", comment: ""))
            }
        }).store(in: &bag)
        viewModel.isLoading.sink(receiveValue: { res in
            if res{
                showLoader(view: self.view)
            }else{
                hideLoader(view: self.view)
            }
        }).store(in: &bag)
        viewModel.getDetailsSerie()
    }
    
    @IBAction func playVideoAction(_ sender: Any) {
        let videoURL = URL(string: "https://bitmovin-a.akamaihd.net/content/bbb/stream.m3u8")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }

}
