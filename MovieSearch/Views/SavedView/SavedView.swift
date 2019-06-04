//
//  SavedView.swift
//  MovieSearch
//

import UIKit

class SavedView: UIView {
	//MARK:- Properties
	var backgroundContainerView: GradientContainerView = {
		var view = GradientContainerView(colorOne: nil, colorTwo: nil)
		return view
	}()
	
	var titleTitle: UILabel = {
		var title = UILabel(frame: .zero)
		title.font = UsableFonts.titleFont
		title.text = "Saved"
		title.textAlignment = .left
		title.allowsDefaultTighteningForTruncation = true
		title.textColor = UIColor.white
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	var savedMoviesTableView: UITableView = {
		var tableView = UITableView(frame: .zero, style: .plain)
		tableView.backgroundColor = UIColor.clear
		tableView.register(SavedMoviesTableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifier.savedResultsCell.identity)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.isScrollEnabled = false
		tableView.separatorColor = .white
		return tableView
	}()
	
	var savedResultsTableViewHeight: NSLayoutConstraint?
	var savedResultsTableViewTop: NSLayoutConstraint?
	var savedResultsTableViewTrailing: NSLayoutConstraint?
	var savedResultsTableviewLeading: NSLayoutConstraint?
	var savedResultsTableViewBottom: NSLayoutConstraint?
	var mainTitleTop: NSLayoutConstraint?
	var mainTitleLeading: NSLayoutConstraint?
	var mainTitleTrailing: NSLayoutConstraint?
	var savedTableViewDelegate: SavedResultsTableViewDelegate? {
		didSet {
			self.savedMoviesTableView.delegate = self.savedTableViewDelegate
			self.savedMoviesTableView.dataSource = self.savedTableViewDelegate
		}
	}
	
	//MARK:- Init Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		savedMoviesTableView.backgroundColor = .clear
	}
	
	//MARK:- Methods
	func setUpViews() {
		[backgroundContainerView].forEach({addSubview($0)})
		[titleTitle, savedMoviesTableView].forEach({addSubview($0)})
		
		setUpContainerView()
		setUpTitleView()
		setUpSavedResultsTableView()
	}

}

extension SavedView {
	//MARK:- Setup views
	private func setUpContainerView() {
		backgroundContainerView.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor)
	}
	
	private func setUpTitleView() {
		mainTitleTop = titleTitle.topAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.topAnchor, constant: 100)
		mainTitleLeading = titleTitle.leadingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 35)
		mainTitleTrailing = titleTitle.trailingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -35)
		titleTitle.heightAnchor.constraint(equalToConstant: 60)
		NSLayoutConstraint.activate([
			mainTitleTrailing!,
			mainTitleLeading!,
			mainTitleTop!
			])
	}
	
	private func setUpSavedResultsTableView() {
		savedResultsTableViewHeight = savedMoviesTableView.heightAnchor.constraint(equalToConstant: savedMoviesTableView.contentSize.height)
		savedResultsTableViewTop = savedMoviesTableView.topAnchor.constraint(equalTo: titleTitle.bottomAnchor, constant: 106)
		savedResultsTableviewLeading = savedMoviesTableView.leadingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 35)
		savedResultsTableViewTrailing = savedMoviesTableView.trailingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -35)
		savedResultsTableViewBottom = savedMoviesTableView.bottomAnchor.constraint(equalTo: backgroundContainerView.bottomAnchor, constant: -50)

		NSLayoutConstraint.activate([
			savedResultsTableviewLeading!,
			savedResultsTableViewTop!,
			savedResultsTableViewHeight!,
			savedResultsTableViewTrailing!
			])
	}
}


extension SavedView {
	//MARK:- Orientation layout
	func portrait() {
		savedResultsTableViewTop?.isActive = false
		savedResultsTableViewTrailing?.isActive = false
		savedResultsTableviewLeading?.isActive = false
		savedResultsTableViewBottom?.isActive = false
		deactivateConstraints(savedResultsTableViewTop!,
							  savedResultsTableViewTrailing!,
							  savedResultsTableviewLeading!,
							  savedResultsTableViewBottom!)
		mainTitleTop?.isActive = false
		mainTitleLeading?.isActive = false
		setUpTitleView()
		setUpSavedResultsTableView()
	}
	
	func landscape() {
		deactivateConstraints(
			savedResultsTableViewTop!,
			savedResultsTableviewLeading!,
			savedResultsTableViewTrailing!)
		deactivateConstraints(mainTitleTop!,
							  mainTitleLeading!,
							  mainTitleTrailing!)
		if savedMoviesTableView.indexPathsForVisibleRows!.count > 5 {
			savedMoviesTableView.isScrollEnabled = true
			savedResultsTableViewBottom = savedMoviesTableView.bottomAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -50)
			savedResultsTableViewBottom?.isActive = true
			savedResultsTableViewHeight?.isActive = false
		}
		savedResultsTableViewTop = savedMoviesTableView.topAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.topAnchor, constant: 100)
		savedResultsTableViewTrailing = savedMoviesTableView.trailingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -35)
		savedResultsTableviewLeading = savedMoviesTableView.leadingAnchor.constraint(equalTo: titleTitle.trailingAnchor, constant: 35)
		
		mainTitleTop = titleTitle.topAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.topAnchor, constant: 100)
		mainTitleLeading = titleTitle.leadingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 35)
		NSLayoutConstraint.activate([
			savedResultsTableViewTop!,
			savedResultsTableViewTrailing!,
			savedResultsTableviewLeading!,
			mainTitleTop!,
			mainTitleLeading!
			])
	}
}


