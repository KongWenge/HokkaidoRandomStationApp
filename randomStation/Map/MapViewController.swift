//
//  MapViewController.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/19.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import UIKit

class MapViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let scrollView = UIScrollView(frame: view.frame)
        view.addSubview(scrollView)
        
        let image = UIImage(named: "hokkaidoMap")!
        let scale: CGFloat = 0.2
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: size))
        imageView.image = image
        scrollView.addSubview(imageView)
        scrollView.contentOffset = CGPoint(x:image.size.width/2, y:image.size.height/2)
        scrollView.contentSize = imageView.frame.size
        scrollView.maximumZoomScale = 1.5
        scrollView.minimumZoomScale = 0.5
        scrollView.delegate = self
    }
}

extension MapViewController: UIScrollViewDelegate {
    // scrollviewがスケーリングした時に、拡大or縮小するviewを返すメソッド
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        for imageView in scrollView.subviews where imageView is UIImageView {
            return imageView
        }
        return nil
    }
}
