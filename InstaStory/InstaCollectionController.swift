//
//  InstaCollectionController.swift
//  InstaStory
//
//  Created by ozgen dindar on 21.07.2020.
//  Copyright © 2020 ozgen dindar. All rights reserved.
//

import UIKit
import AVKit


class InstaCollectionContoller: UICollectionViewController{
    var storyList = Story.stories

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = CarouselFlowLayout()
        collectionView.decelerationRate = .fast
    }
    
    private func prevStoryItem(indexPath: IndexPath, xLocation: CGFloat){
        let limit = 0
        
        if storyList[indexPath.row].state == limit{
            let scrollIndexPath = IndexPath(item: max(limit, indexPath.row - 1), section: indexPath.section)
            collectionView.scrollToItem(at: scrollIndexPath, at: .centeredHorizontally, animated: true)
        }else{
        storyList[indexPath.row].state = max(limit,(storyList[indexPath.row].state - 1))
        }
        
    }
    
    private func nextStoryItem(indexPath: IndexPath, xLocation: CGFloat){
        let itemLimit = storyList[indexPath.row].storyList.count - 1
        let storyLimit = collectionView.numberOfItems(inSection: 0) - 1
        
        if storyList[indexPath.row].state == itemLimit{
            let scrollIndexPath = IndexPath(item: min(storyLimit,indexPath.row + 1), section: indexPath.section)
            collectionView.scrollToItem(at: scrollIndexPath, at: .centeredHorizontally, animated: true)
        }else{
            storyList[indexPath.row].state = min((storyList[indexPath.row].state + 1),itemLimit)
        }
    }
    
    @IBAction func onTapped(_ sender: UITapGestureRecognizer) {
        print(sender.location(in: self.view).x)
        let xLocation = sender.location(in: self.view).x
        
        let indexPath = collectionView.indexPathsForVisibleItems[0]
        if collectionView.frame.width / 5 > xLocation{
           prevStoryItem(indexPath: indexPath, xLocation: xLocation)
        }else{
           nextStoryItem(indexPath: indexPath, xLocation: xLocation)
        }
        collectionView.reloadItems(at: [collectionView.indexPathsForVisibleItems[0]])
    }
    @IBAction func onTouch(_ sender: UILongPressGestureRecognizer) {
        
        guard let cell = self.collectionView.visibleCells[0] as? InstaCollectionViewCell else{
            return}
        

        switch sender.state{
        case .ended:
            cell.play()
            break
        case .began:
            cell.pause()
            break
        default:
            cell.pause()
            break
        }
    }
}

extension InstaCollectionContoller{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           storyList.count
       }
       
       override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
           if let cell = cell as? InstaCollectionViewCell{
               cell.play()
           }
       }
       
       override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
           if let cell = cell as? InstaCollectionViewCell{
               cell.pause()
           }
       }
       
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           let type = storyList[indexPath.row].getCurrStory().type
           
           switch type {
           case StoryType.movie:
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: InstaCollectionViewCell.self), for: indexPath) as? InstaCollectionViewCell else{
                   fatalError("\(String(describing: InstaCollectionViewCell.self)) error")
               }
               let index = storyList[indexPath.row].state
               cell.config(url: storyList[indexPath.row].storyList[index].url)
               return cell
           case StoryType.image:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: InstaImageCell.self), for: indexPath) as? InstaImageCell else{
                   fatalError("\(String(describing: InstaImageCell.self)) error")
               }
               cell.config(url: storyList[indexPath.row].getCurrStory().url)
               return cell
           }
       }
}

extension InstaCollectionContoller: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
}

extension InstaCollectionContoller: UIGestureRecognizerDelegate{
    
   
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let cell = self.collectionView.visibleCells[0] as? InstaCollectionViewCell {
            cell.pause()
        }
        
        if gestureRecognizer is UITapGestureRecognizer{
            let xLocation = touch.location(in: self.view).x
            let leftLimit = self.view.frame.width / 5
            let rightLimit = self.view.frame.width / 5 * 4
            
            return  xLocation.isLess(than: leftLimit) || rightLimit.isLess(than: xLocation)
        }
        
        return true
    }
        
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer is UITapGestureRecognizer) || (otherGestureRecognizer is UITapGestureRecognizer) {
            return false
        }
        return true
    }
}


