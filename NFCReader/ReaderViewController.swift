//
//  ReaderViewController.swift
//  NFCReader
//
//  Created by Francisco Javier Chacon de Dios on 10/02/18.
//  Copyright © 2018 Francisco Javier Chacon de Dios. All rights reserved.
//

import UIKit
import CoreNFC

class ReaderViewController: UIViewController {

    let readerView: ReaderView = ReaderView()
    var nfcReaderSession: NFCNDEFReaderSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        readerView.button.addTarget(self, action: #selector(startScanningBook(_:)), for: .touchUpInside)
        view.addSubview(readerView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let readerViewTopConstraint: NSLayoutConstraint = NSLayoutConstraint(item: readerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let readerViewLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint(item: readerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let readerViewTrailingConstraint: NSLayoutConstraint = NSLayoutConstraint(item: readerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let readerViewBottomConstraint: NSLayoutConstraint = NSLayoutConstraint(item: readerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraints([readerViewTopConstraint, readerViewLeadingConstraint, readerViewTrailingConstraint, readerViewBottomConstraint])
    }

}

extension ReaderViewController: NFCNDEFReaderSessionDelegate {

    @objc func startScanningBook(_ sender: UIButton) {
        nfcReaderSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcReaderSession?.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        let alertController: UIAlertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertActionOK: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertActionOK)
        present(alertController, animated: true, completion: nil)
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        let alertMessageController: UIAlertController = UIAlertController(title: "Message", message: String(messages.count), preferredStyle: .alert)
        let alertMessageActionOK: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertMessageController.addAction(alertMessageActionOK)
        present(alertMessageController, animated: true, completion: nil)
    }

}

