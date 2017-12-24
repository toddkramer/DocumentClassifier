//
//  ViewController.swift
//
//  Copyright (c) 2017 Todd Kramer (http://www.tekramer.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import WebKit
import DocumentClassifier

extension Classification.Category {

    var color: UIColor {
        return UIColor(named: rawValue) ?? UIColor(named: "App") ?? .darkGray
    }

}

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var classificationLabelBottomConstraint: NSLayoutConstraint!
    
    let classifier = DocumentClassifier()

    lazy var percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addKeyboardObservers()
        configureTextView()
    }

    func classify(_ text: String) {
        guard let classification = classifier.classify(text) else { return }
        let prediction = classification.prediction
        updateInterface(for: prediction)
    }

    func updateInterface(for prediction: Classification.Result) {
        guard let percent = percentFormatter.string(from: NSNumber(value: prediction.probability)) else { return }
        classificationLabel.text = prediction.category.rawValue + " " + "(\(percent))"
        changeInterfaceColor(to: prediction.category.color)
    }

    func configureTextView() {
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func clearButtonTapped(_ sender: Any) {
        textView.text = ""
        classificationLabel.text = "None"
        changeInterfaceColor(to: UIColor(named: "App"))
    }

    func changeInterfaceColor(to color: UIColor?) {
        classificationLabel.backgroundColor = color
        navigationController?.navigationBar.barTintColor = color
    }

}

// MARK: - UITextViewDelegate

extension ViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        classify(textView.text)
    }

}

// MARK: - Keyboard

extension ViewController {

    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleKeyboard), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toggleKeyboard), name: .UIKeyboardWillHide, object: nil)
    }

    @objc private func toggleKeyboard(for notification: Notification) {
        guard let attributes = keyboardAttributes(for: notification) else { return }
        UIView.animate(withDuration: attributes.animationDuration) {
            self.classificationLabelBottomConstraint.constant = -attributes.size.height
            self.view.layoutIfNeeded()
        }
    }

    private func keyboardAttributes(for notification: Notification) -> (size: CGSize, animationDuration: Double)? {
        guard
            let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue?.size,
            let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
            else { return nil }
        return (keyboardSize, animationDuration)
    }

}

