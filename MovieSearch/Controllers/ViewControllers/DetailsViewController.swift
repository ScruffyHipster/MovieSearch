//
//  DetailsViewController.swift
//  MovieSearch
//
//  Created by Tom Murray on 22/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
	
	weak var coordinator: DetailsCoordinator?
	
	var detailsView: DetailsView?
	
	var movieDetails: MovieDetails?
	
	var addSuffix = { (string: String) -> String in
		var chars = string.filter({$0 == ","})
		return !chars.isEmpty ? "s" : ""
	}
	
	var orientation: Orientation {
		get {
			return UIDevice.current.orientation.isPortrait ? Orientation.portrait : Orientation.landscape
		}
	}
	
	var gradientView: GradientContainerView = {
		return GradientContainerView(frame: .zero)
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setUp()
    }
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	func setUp() {
		setUpBackgroundGradient()
		setUpDetailsView()
		setUpActionButtons()
	}
	
	private func setUpDetailsView() {
		detailsView = DetailsView(orientation: orientation)
		setupMovieDetails()
		view.addSubview(detailsView!)
		detailsView?.anchor(top: view.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
	}
	
	func setupMovieDetails() {
		guard let details = movieDetails else {return}
		let informationContainer = detailsView?.informationContainerView
		detailsView?.gradientImageContainerView.mainImage.downloadImage(from: details.poster)
		informationContainer?.mainTitle.text = details.title
		informationContainer?.actorsLabel.text = "Actor\(addSuffix(details.actors)): \(details.actors)"
		informationContainer?.directorLabel.text = "Director\(addSuffix(details.director)): \(details.director)"
		informationContainer?.writersLabel.text = "Writer\(addSuffix(details.writer)): \(details.writer)"
		informationContainer?.plotInfo.text = details.plot
		informationContainer?.ratingLabel.text = "imdb rating: \(details.imdbRating)"
	}

	private func setUpBackgroundGradient() {
		gradientView.frame = self.view.bounds
		self.view.insertSubview(gradientView, at: 0)
	}

	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		switch orientation {
		case .landscape:
			self.detailsView?.landscape()
		case .portrait:
			self.detailsView?.portrait()
		}
	}
	
	private func setUpActionButtons() {
		detailsView?.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
	}
	
	@objc func dismissView() {
		dismiss(animated: true, completion: {
			self.coordinator?.dismissDetailsVC()
		})
		
	}
}

extension DetailsViewController: Storyboarded {
	
}
