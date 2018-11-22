//
//  ZLetterGestureRecognizer.swift
//  ZGestureRecogniser
//
//  Created by Ben Liu on 22/11/18.
//  Copyright © 2018 SunSuper. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class ZLetterGestureRecognizer: UIGestureRecognizer {

    var strokePart: Int = 0
    var strokePrecision: CGFloat = 10.0
    var firstTap: CGPoint = CGPoint.init(x: 0, y: 0)

    
//    override init(target: Any?, action: Selector?) {
//        weak self =
//        return super.init(target: target, action: action)
//
//    }

    override func reset() {
        self.strokePart = 0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.strokePrecision = 10.0; //A

        if (touches.count > 1) {
            self.state = UIGestureRecognizerState.failed
            return
        }
        self.firstTap = ((touches.first)?.location(in: self.view?.superview))!
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if (self.state == UIGestureRecognizerState.failed || self.state == UIGestureRecognizerState.recognized) {
            return
        }
        
        let currentPoint : CGPoint = ((touches.first)?.location(in: self.view?.superview))!
        let previousPoint : CGPoint = ((touches.first)?.previousLocation(in: self.view?.superview))!
        
        if(self.strokePart == 0 &&
            (currentPoint.x - self.firstTap.x) > 20.0 &&
            (currentPoint.x > previousPoint.x) &&
            (currentPoint.y - self.firstTap.y) <= self.strokePrecision ) {
            self.strokePart = 1;
        } else if ((self.strokePart == 1) &&
            (currentPoint.x < previousPoint.x) &&
            (currentPoint.y > previousPoint.y)) {
            self.strokePart = 2
        } else if ((self.strokePart == 2) && (currentPoint.x > previousPoint.x) && ((currentPoint.y - previousPoint.y) <= self.strokePrecision)) {
            self.strokePart = 3
            self.state = UIGestureRecognizerState.recognized
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        self.state = UIGestureRecognizerState.cancelled
        self.reset()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        self.reset()
    }
}

extension  ZLetterGestureRecognizer : UIGestureRecognizerDelegate {
    
}
