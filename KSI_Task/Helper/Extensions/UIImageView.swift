//
//  UIImageView.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import Kingfisher

extension UIImageView {
    func setImage(with imageUrl: String?, placeholder: Placeholder? = nil, indicatorType: IndicatorType = .none) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Limit memory cache size to 100 MB.
            ImageCache.default.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024
            // Limit memory cache to hold 30 images at most.
            ImageCache.default.memoryStorage.config.countLimit = 30
            // Memory image expires after 10 minutes.
            ImageCache.default.memoryStorage.config.expiration = .seconds(60 * 10)
            // means that the disk cache would expire in one week.
            ImageCache.default.diskStorage.config.expiration = .days(7)

            let urlString = imageUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let url = URL(string: urlString)
            let sampleSize = CGSize(width: self.frame.size.width * UIScreen.main.scale, height: self.frame.size.height * UIScreen.main.scale)
            let processor = DownsamplingImageProcessor(size: sampleSize)
            self.kf.indicatorType = indicatorType
            self.kf.setImage(with: url, placeholder: placeholder, options: [.backgroundDecode,
                                                                            .cacheOriginalImage,
                                                                            .transition(.none),
                                                                            .processor(processor)])
        }
    }
}
