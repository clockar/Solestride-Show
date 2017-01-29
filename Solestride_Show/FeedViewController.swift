//
//  ViewController.swift
//  Solestride_Show
//
//  Created by Keenan Rebera on 9/15/16.
//  Copyright © 2016 Keenan Rebera. All rights reserved.
//

import UIKit
import MapKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollContentView: UIView!
    
    
    let taglist = ["Hills", "Uphill", "Flat", "Loop", "Out and Back", "Longrun"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideKeyboardWhenTappedAround()
        makeTagContainer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rewindToMain(segue: UIStoryboardSegue) {
    
    }


}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FEED_CELL") as! FeedViewTableCell
        cell.initCell(route: cell.dummyData())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FeedViewTableCell
        performSegue(withIdentifier: "EXPAND_CELL", sender: cell)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EXPAND_CELL" {
            let cell = sender as! FeedViewTableCell
            let data = cell.route
            let dest = segue.destination as! FeedDetailViewController
            dest.data = data
        }
    }
    
}

extension FeedViewController: UIScrollViewDelegate {
    
    func makeTagContainer(){
        var moveOver : CGFloat = 0.0
        for tag in taglist {
            //MARK: UNIFINISHED
            let wordView = UILabel()
            wordView.text = tag
            wordView.backgroundColor = UIColor.slsSunYellowColor()
            wordView.layer.cornerRadius = 3
            wordView.clipsToBounds = true
            wordView.center = scrollContentView.center
            wordView.frame = CGRect(origin: CGPoint(x: scrollContentView.frame.origin.x + moveOver, y: scrollContentView.frame.origin.y), size: CGSize(width: 200, height: 24))
            wordView.sizeToFit()
            moveOver = wordView.frame.maxX - scrollContentView.frame.origin.x + 10.0
            scrollContentView.frame = CGRect(x: scrollContentView.frame.origin.x, y: scrollContentView.frame.origin.y, width: moveOver, height: scrollContentView.frame.height)
            self.view.addSubview(wordView)
            scrollContentView.addSubview(wordView)
            print("added subview \(tag)")
        }
    }
    
}

class FeedViewTableCell: UITableViewCell, MKMapViewDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timesSavedLabel: UILabel!
    @IBOutlet weak var favoritedImageView: UIImageView!
    
    @IBOutlet weak var mapview: MKMapView!
    var route: Route?
    
    func dummyData() -> Route {
        return Route(timesSaved: 23, distance: 3.5, title: "My Run", creator_User: User(handle: "@aliciousness"), favorited: true)
    }
    
    func initCell(route: Route) {
        self.route = route
        profileImageView.image = route.creator_User.profile
        titleLabel.text = route.title
        profileNameLabel.text = route.creator_User.handle
        distanceLabel.text = "\(route.distance) mi"
        timesSavedLabel.text = "\(route.timesSaved) runners saved"
        favoritedImageView.image = route.favorited ? #imageLiteral(resourceName: "favoriteActive") : #imageLiteral(resourceName: "favoriteInactive")
    }
    
}

extension UIColor {
    class func slsPaleGreyColor() -> UIColor {
        return UIColor(red: 232.0 / 255.0, green: 232.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }
    
    class func slsSunYellowColor() -> UIColor {
        return UIColor(red: 253.0 / 255.0, green: 228.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
