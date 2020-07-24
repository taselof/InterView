//
//  Models.swift
//  InstaStory
//
//  Created by ozgen dindar on 24.07.2020.
//  Copyright © 2020 ozgen dindar. All rights reserved.
//

import Foundation

let movies = ["https://www.radiantmediaplayer.com/media/big-buck-bunny-360p.mp4",
              "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"
]
let images = ["https://www.fillmurray.com/300/800",
              "https://via.placeholder.com/300x800",
              "https://loremflickr.com/300/800"
]

struct Story{
    let storyList: [StoryItem]
    var state = 0
    
    func getCurrStory() -> StoryItem{
        return storyList[state]
    }
}
enum StoryType{
    case image
    case movie
}

struct StoryItem{
    let url: URL
    let type: StoryType
    
    init(url: String, type: StoryType) {
        self.url = URL(string: url)!
        self.type = type
    }
}

extension Story{
    static let stories: [Story] =
        [Story(storyList: [StoryItem(url: "https://www.radiantmediaplayer.com/media/big-buck-bunny-360p.mp4", type: .movie),
                           StoryItem(url: "https://loremflickr.com/300/800?random=1", type: .image)]),
         Story(storyList: [StoryItem(url: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4", type: .movie),
                           StoryItem(url: "https://loremflickr.com/300/800?random=2", type: .image)]),
         Story(storyList: [StoryItem(url: "https://loremflickr.com/300/800?random=3", type: .image),
                           StoryItem(url: "https://www.fillmurray.com/300/800", type: .image),
                           StoryItem(url: "https://loremflickr.com/300/800?random=4", type: .image)])
    ]
}
