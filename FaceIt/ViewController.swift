//
//  ViewController.swift
//  FaceIt
//
//  Created by Praveen Murugesan on 9/24/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            let handler = #selector(FaceView.changeScale(recognizer:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)

            let tapHandler = #selector(toggleEyes(byReactingTo:))
            let tapRecognizer = UITapGestureRecognizer(target: self, action: tapHandler)
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            updateUI()
        }
    }

    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .Closed) ? .Open : .Closed
            expression = FacialExpression(eyes:eyes, eyeBrows: expression.eyeBrows, mouth: expression.mouth)
        }
    }

    var expression = FacialExpression(eyes: .Closed, eyeBrows: .Relaxed, mouth: .Smirk) {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        switch expression.eyes {
        case .Open:
            faceView?.eyesOpen = true
        case .Closed:
            faceView?.eyesOpen = false
        case .Squinting:
            faceView?.eyesOpen = false
        }

        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }

    private let mouthCurvatures = [FacialExpression.Mouth.Grin:0.5, .Frown:-1, .Smile:1,
        .Neutral:0.0, .Smirk:-0.5]


}

