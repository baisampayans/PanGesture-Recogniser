//
//  ViewController.swift
//  grid_pan_gesture_track
//
//  Created by Baisampayan Saha on 2/13/19.
//  Copyright © 2019 Baisampayan Saha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var size = 15
    var cells = [String: UIView]()
    var selectedCell: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numberOfSquaresInXAxis = Int(view.frame.width)/size
        let numberOfSquaresInYAxis = Int(view.frame.height)/size
        
        for j in 0...numberOfSquaresInYAxis {
            for i in 0...numberOfSquaresInXAxis {
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.layer.borderWidth = 0.2
                cellView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cellView.frame = CGRect(x: i * size, y: j * size, width: size, height: size)
                view.addSubview(cellView)
                
                let key = "\(i)\(j)"
                cells[key] = cellView
            }
        }
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)

        let i = Int(location.x/CGFloat(size))
        let j = Int(location.y/CGFloat(size))
        
        print(i,j)
        
        let key = "\(i)\(j)"
        guard let cellView = cells[key] else { return }
        
        view.bringSubviewToFront(cellView)
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
            
        }
        selectedCell = cellView
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
            
        }, completion: nil)
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
    
    
}


