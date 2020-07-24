

import UIKit

class CarouselFlowLayout: UICollectionViewFlowLayout {
    
    let activeDistance: CGFloat = 200
    let zoomFactor: CGFloat = 0.3
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        
        if let collectionView = collectionView{
            itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard collectionView != nil else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect).map {$0}
        
        return rectAttributes
    }
    

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        
        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: collectionView.contentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        let attribute =  rectAttributes.filter { (attribute) -> Bool in
            if velocity == .zero{
                return collectionView.contentOffset.x...collectionView.contentOffset.x + collectionView.bounds.width ~= attribute.center.x
            }else if velocity.x > 0 {
                return collectionView.contentOffset.x + collectionView.bounds.width < attribute.frame.maxX
            }else{
                return collectionView.contentOffset.x > attribute.frame.minX
            }
        }
        if !attribute.isEmpty {
            return CGPoint(x: attribute[0].frame.minX , y: proposedContentOffset.y)
        }
        return CGPoint(x: proposedContentOffset.x , y: proposedContentOffset.y)
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
}
