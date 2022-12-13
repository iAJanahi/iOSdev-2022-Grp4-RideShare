//
//  HomePageViewController.swift
//  RYDE
//
//  Created by iOSdev on 28/11/2022.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        pageControlView.numberOfPages = imagesArray.count
        // Do any additional setup after loading the view.
        startTimer()
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
}
