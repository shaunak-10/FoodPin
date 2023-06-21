//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Shaunak Mehta on 09/06/23.
//

import UIKit

class ReviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(data: restaurant.image)
        
        let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            backgroundImageView.addSubview(blurEffectView)
        
        for rateButton in rateButtons {
            rateButton.alpha = 0
        }

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        var add = 0.0
        
        for rateButton in rateButtons{
            
            
            UIView.animate(withDuration: 0.4, delay: 0.1+add, options: [], animations: {
                
                rateButton.alpha = 1.0
            }, completion: nil)
            
            add += 0.05
            
        }
    }

    
        

    

    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var rateButtons: [UIButton]!

    var restaurant = Restaurant()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
