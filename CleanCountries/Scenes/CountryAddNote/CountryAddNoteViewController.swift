//
//  CountryAddNoteViewController.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation
import UIKit
import Combine

class CountryAddNoteViewController: UIViewController, Storyboarded {
    
    // MARK: - Controls
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var roundedView: RoundedCornerView!
    
    // MARK: - Properties
    var interactor: CountryAddNoteInteractorProtocol?
    var router: CountryAddNoteRouterProtocol?
    
    // MARK: - View models
    
    private var noteViewModel: CountryAddNoteModels.NoteViewModel?
    
    // MARK: - Internal variables
    
    var country: Country?

    var onSave: ((Country) -> ())?
    
    // MARK: - Keyboard events
    let keyboardWillOpen = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map {$0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect}
        .map {$0.height}
    
    let keyboardWillHide =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat(0)}
    
    var cancellables: [AnyCancellable] = []
    
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNote()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancellables.forEach { $0.cancel() }
    }
    
    func configure() {
        titleLabel.text = "add_note_title".localized
        
        cancellables.append(
            Publishers.Merge(keyboardWillOpen, keyboardWillHide)
                .subscribe(on: RunLoop.main)
                .sink(receiveValue: { value in
                    if value > 0 {
                        if (self.scrollView.frame.origin.y + self.scrollView.frame.size.height - value) < self.roundedView.frame.origin.y + self.roundedView.frame.size.height {
                            DispatchQueue.main.async {
                                UIView.animate(withDuration: 0.5) {
                                    self.scrollView.contentOffset.y = self.roundedView.frame.origin.y
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self.scrollView.contentOffset.y = 0
                            }
                        }
                    }
                })
        )
        
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        textView.addDoneButton(title: "text_view_done".localized,
                               target: self,
                               selector: #selector(tapDone(sender:)))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.textView.becomeFirstResponder()
        }
    }
    
    func fetchNote() {
        if let countryToFetch = country {
            self.interactor?.fetchNote(for: CountryAddNoteModels.FetchRequest(country: countryToFetch))
        }
    }
}

// MARK: - Events

extension CountryAddNoteViewController: CountryAddNoteViewProtocol {
    func displayNote(with viewModel: CountryAddNoteModels.NoteViewModel) {
        textView.text = viewModel.displayedNote.note
    }
}

// MARK: - Taps

extension CountryAddNoteViewController {
    @IBAction func saveTapped(_ sender: Any) {
        if let countryID = country?.id {
            if let savedCountry = interactor?.saveNote(textView.text, for: countryID) {
                onSave?(savedCountry)
            }
            router?.close()
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        router?.close()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func tapDone(sender: Any) {
        view.endEditing(true)
    }
}
