//
//  PushViewControllerAnimatedTransitioning.swift
//  VK
//
//  Created by Дмитрий Супрун on 9.11.22.
//

import UIKit

/// PushViewController animation
final class PushViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Methods
    
    let timeInterval = 0.5
    
    // MARK: - Public Methods
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        timeInterval
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.view(forKey: .from) else { return }
        guard let destination = transitionContext.view(forKey: .to) else { return }
        destination.alpha = 0
        
        let heightView = transitionContext.containerView.frame.height
        let widthView = transitionContext.containerView.frame.width
        
        transitionContext.containerView.addSubview(destination)
        destination.frame = transitionContext.containerView.frame
        destination.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            .concatenating(CGAffineTransform(translationX: heightView / 2 + widthView / 2, y: -widthView / 2))
        
        source.frame = transitionContext.containerView.frame
        
        UIView.animate(withDuration: timeInterval, delay: 0, options: .curveEaseOut) {
            destination.transform = .identity
            destination.alpha = 1
            destination.layer.cornerRadius = 50
            source.alpha = 0
        } completion: { completed in
            transitionContext.completeTransition(completed)
        }
    }
}
