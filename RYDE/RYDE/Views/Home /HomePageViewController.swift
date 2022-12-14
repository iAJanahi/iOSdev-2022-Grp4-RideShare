//
//  HomePageViewController.swift
//  RYDE
//
//  Created by iOSdev on 28/11/2022.
//

import UIKit
import MapKit

class HomePageViewController: UIViewController {
    
    // MARK: HomePageViewController Variables
    var imagesArray = [
    UIImage(named: "tesla"),
    UIImage(named: "mcdonalds"),
    UIImage(named: "logo"),
    UIImage(named: "cocacola"),
    ]
    var timer: Timer?
    var currentCellIndex = 0
    
    // MARK: HomePageViewController Outlets
    @IBOutlet var sliderCollectionView: UICollectionView!
    
    @IBOutlet var pageControlView: UIPageControl!
    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate let locationManager: CLLocationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        pageControlView.numberOfPages = imagesArray.count
        // Do any additional setup after loading the view.
        startTimer()
        
        //Get user location
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()

        // Specifies region to start with
        let region = MKCoordinateRegion(center: locationManager.location!.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(region, animated: true)
        
        // Sets limit to the camera movements
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        // Zoom range
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 30000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        mapView.showsUserLocation = true
        
        mapView.layer.cornerRadius = 10.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc
    func moveToNextIndex() {
        // Handling end of slider, when reached set index to 0 (start over)
        if currentCellIndex < imagesArray.count - 1 {
            currentCellIndex += 1
        }
        else {
            currentCellIndex = 0
        }
        sliderCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControlView.currentPage = currentCellIndex
    }
}


// Setting up the collection view for the carousel
extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! HomeCarouselCollectionViewCell
        
        cell.ImgCarousel.image = imagesArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollectionView.frame.width, height: sliderCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        print("Got back home!")
        _ = self.tabBarController?.selectedIndex = 1
    }
}
