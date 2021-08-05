//
//  WebTableViewCell.swift
//  PracticeUI
//
//  Created by 60067671 on 2021/08/05.
//

import UIKit

protocol WebViewCellDelegate: class {
	func reloadWebview()
}

class WebTableViewCell: UITableViewCell {

	@IBOutlet weak var webView: UIWebView!
	@IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!

	weak var delegate: WebViewControllerDelegate?

	override func awakeFromNib() {
		super.awakeFromNib()
		webView.delegate = self
		webView.scrollView.isScrollEnabled = false

		DispatchQueue.main.async {
			let request = URLRequest(url: URL(string: "https://comic.naver.com")!)
			self.webView.loadRequest(request)
		}
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	private func refreshWebView(by height: CGFloat) {
		webViewHeightConstraint.constant = height
		delegate?.reloadWebViewCell()
	}
}

extension WebTableViewCell: WebViewCellDelegate {
	func reloadWebview() {
		guard let webViewHeight = webView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight") as NSString? else {
			return
		}

//		let webviewHeight2 = self.webView.scrollView.contentSize.height
//		webViewHeightConstraint.constant = webviewHeight2

		let height = CGFloat(webViewHeight.floatValue)

		if height != webViewHeightConstraint.constant {
			refreshWebView(by: height)
		}
	}
}

extension WebTableViewCell: UIWebViewDelegate {
	func webViewDidStartLoad(_ webView: UIWebView) {

	}

	func webViewDidFinishLoad(_ webView: UIWebView) {
		guard let webViewHeight = webView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight") as NSString? else {
			return
		}

//		let webviewHeight2 = self.webView.scrollView.contentSize.height
//		webViewHeightConstraint.constant = webviewHeight2

		let height = CGFloat(webViewHeight.floatValue)

		refreshWebView(by: height)
	}
}

