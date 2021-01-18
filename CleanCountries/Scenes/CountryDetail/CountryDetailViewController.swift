//
//  CountryDetailViewController.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import UIKit

import UIKit
import MapKit

class CountryDetailViewController: UIViewController, Storyboarded {
    
    // MARK: - Controls
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCode2lLabel: UILabel!
    @IBOutlet weak var countryCode2lValueLabel: UILabel!
    @IBOutlet weak var countryCode3lLabel: UILabel!
    @IBOutlet weak var countryCode3lValueLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - Properties
    var interactor: CountryDetailInteractorProtocol?
    var router: CountryDetailRouterProtocol?
    
    // MARK: - Internal variables
    
    var country: Country?
    
    // MARK: - View models
    
    private var countryViewModel: CountryDetailModels.CountryViewModel?
    
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        view.accessibilityIdentifier = "CountryDetailViewController"
        super.viewDidLoad()
        configure()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Events

extension CountryDetailViewController {
    
    func configure() {
        noteLabel.textColor = .lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(Self.showNote))
        noteLabel.isUserInteractionEnabled = true
        noteLabel.addGestureRecognizer(tap)
        
        self.countryCode2lLabel.text = "country_detail_code_2l_text".localized
        self.countryCode3lLabel.text = "country_detail_code_3l_text".localized
    }
    
    func fetchData() {
        if let c = country {
            self.interactor?.fetchCountry(for: CountryDetailModels.FetchRequest(country: c))
        }
    }
    
    private func loadInfo() {
        guard let viewModel = self.countryViewModel else { return }
        DispatchQueue.main.async {
            self.title = viewModel.displayedCountry.name
            self.countryNameLabel.text = viewModel.displayedCountry.officialName
            self.countryCode2lValueLabel.text = viewModel.displayedCountry.code2l
            self.countryCode3lValueLabel.text = viewModel.displayedCountry.code3l
            self.noteLabel.text = viewModel.displayedCountry.note
            self.noteButton.setImage(viewModel.displayedCountry.noteButtonImage, for: .normal)
            self.noteButton.setImage(viewModel.displayedCountry.noteButtonImage, for: .highlighted)
            
            
            let latitude = Double(viewModel.displayedCountry.latitude)
            let longitude = Double(viewModel.displayedCountry.longitude)
            if let lat = latitude, let lon = longitude {
                let countryLocation = CLLocation(latitude: lat, longitude: lon)
                self.centerMapOnLocation(location: countryLocation, zoom: viewModel.displayedCountry.zoom)
            }
            let url = (viewModel.displayedCountry.imageUrl != nil ? URL(string: viewModel.displayedCountry.imageUrl!) : nil)
            self.flagImageView.downloadImage(with: url)
        }
    }
    
    private func centerMapOnLocation(location: CLLocation, zoom: Int) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 360 / pow(2, Double(zoom)) * Double(mapView.frame.size.width) / 256)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                                       longitude: location.coordinate.longitude),
                                        span: span)
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            self.mapView.addAnnotation(annotation)
        }
    }
    
    @objc func showNote() {
        if let c = country {
            router?.showNote(for: c)
        }
    }
    
}

// MARK: - VIP cycle

extension CountryDetailViewController: CountryDetailViewProtocol {
    func displayCountry(with viewModel: CountryDetailModels.CountryViewModel) {
        countryViewModel = viewModel
        loadInfo()
    }
}

// MARK: - Taps

extension CountryDetailViewController {
    @IBAction func noteTapped(_ sender: Any) {
        showNote()
    }
}
