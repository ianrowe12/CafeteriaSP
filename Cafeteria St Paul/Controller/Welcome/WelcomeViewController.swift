//
//  WelcomeViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 7/3/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
    
 
    var currentPage = 0 {
        didSet{ //whenever this value changes, check if its the last page, if it is, change the title of the button
            pageControl.currentPage = currentPage
            if currentPage ==  welcomePages.welcomePages.count - 1{
                nextButton.setTitle("I understand and agree with what I just read. Proceed to app.", for: .normal)
                nextButton.titleLabel?.font = UIFont.italicSystemFont(ofSize: 18)
                nextButton.titleLabel?.textAlignment = .center
                buttonWidthConstraint.constant = 250
                buttonHeightConstraint.constant = 80
            } else {
                nextButton.setTitle("Next", for: .normal)
                nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
                buttonWidthConstraint.constant = 152
                buttonHeightConstraint.constant = 52
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 4
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        if currentPage == welcomePages.welcomePages.count - 1{
             performSegue(withIdentifier: "proceedToApp", sender: self)
            UserDefaults.standard.notFirstTime = true
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(welcomePages.welcomePages.count)
        return welcomePages.welcomePages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionViewCell", for: indexPath) as! WelcomeCollectionViewCell
        let currentPage = welcomePages.welcomePages[indexPath.row]
        print(currentPage.title)
        cell.setupCell(page: currentPage)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)  //.x means in the x axis. That division will give us the current page
 
    }

    
}
