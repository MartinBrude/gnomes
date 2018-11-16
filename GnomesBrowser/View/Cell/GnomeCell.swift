//
//  GnomeCell.swift
//  GnomesBrowser
//
//  Created by Martin on 13/10/2018.
//  Copyright © 2018 M. All rights reserved.
//

import UIKit
import Kingfisher

class GnomeCell: UITableViewCell {

    @IBOutlet weak var gnomeImageView: UIImageView!
    @IBOutlet weak private var gnomeNameLabel: UILabel!
    @IBOutlet weak private var gnomeAgeLabel: UILabel!
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var weightLabel: UILabel!
    @IBOutlet weak private var heightLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak private var professionsLabel: UILabel!
    @IBOutlet weak private var friendsLabel: UILabel!

    static var reuseIdentifier : String {
        get {
            return "GnomeCell"
        }
    }

    static var nibName : String {
        get {
            return "GnomeCell"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        gnomeImageView.kf.indicatorType = .activity
    }

    func setImageNotFound() {
        gnomeImageView.image = UIImage(named: "image-not-found")
    }

    func setImage(imagePath : String) {
        gnomeImageView.kf.setImage(with: URL(string: imagePath), placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { (image, error, cacheType, url) in
            if error != nil {
                self.setImageNotFound()
            }
        }
    }

    func setGnome(_ gnome : Gnome) {
        setImage(imagePath: gnome.thumbnail)
        gnomeNameLabel.text = gnome.name
        gnomeAgeLabel.text = "Age: \(gnome.age)"
        heightLabel.text = "Height: \(gnome.height)"
        weightLabel.text = "Weight: \(gnome.weight)"
        cityLabel.text = "City: \(gnome.city!)"
        hairColorLabel.text = "Hair color: \(gnome.hairColor)"
        professionsLabel.text = "Professions: \(gnome.professions.joined(separator: ", "))"
        friendsLabel.text = "Friends: \(gnome.friends.joined(separator: ", "))"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        gnomeImageView.image = nil
    }
}
