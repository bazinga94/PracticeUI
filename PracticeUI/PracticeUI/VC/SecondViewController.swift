//
//  SecondViewController.swift
//  PracticeUI
//
//  Created by 60067671 on 2021/08/05.
//

import UIKit

class SecondViewController: UIViewController {

	@IBOutlet weak var tableview: UITableView!

	weak var delegate: WebViewCellDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		tableview.delegate = self
		tableview.dataSource = self
	}
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 1 {
			let cell = tableview.dequeueReusableCell(withIdentifier: "WebTableViewCell", for: indexPath) as! WebTableViewCell
			cell.delegate = self
			self.delegate = cell
			return cell
		} else {
			let cell: UITableViewCell = UITableViewCell.init(frame: .init(x: 0, y: 0, width: self.tableview.frame.width, height: 20))
			cell.backgroundColor = .red
			return cell
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if (scrollView.contentOffset.y).truncatingRemainder(dividingBy: 10) == 0 {
			delegate?.reloadWebview()
		}
	}
}

extension SecondViewController: WebViewControllerDelegate {
	func reloadWebViewCell() {
		DispatchQueue.main.async {
//			self.tableview.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
			self.tableview.reloadData()
		}
	}
}

protocol WebViewControllerDelegate: class {
	func reloadWebViewCell()
}

