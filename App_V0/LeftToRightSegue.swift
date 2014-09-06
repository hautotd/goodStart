//
//  LeftToRightSegue.swift
//  App_V0
//
//  Created by Dimitri Hautot on 06/09/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import Foundation
import UIKit

@objc(LeftToRightSegue) class LeftToRightSegue: UIStoryboardSegue {
    
    override func perform() {
        let sourceViewController = self.sourceViewController as UIViewController
        let destinationViewController = self.destinationViewController as UIViewController
        let transition : CATransition = CATransition()
        transition.duration = 2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        
        UIView.transitionFromView(sourceViewController.view, toView: destinationViewController.view, duration: 2, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        //sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
    }
    
}