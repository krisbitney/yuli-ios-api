import Foundation
import ComposableStorage

@objc class User: NSObject {
    @objc let username: String
    @objc let name: String?
    @objc let picUrl: String?
    @objc let followerCount: Int
    @objc let followingCount: Int
    @objc let mediaCount: Int

    @objc init(username: String, name: String?, picUrl: String?, followerCount: Int, followingCount: Int, mediaCount: Int) {
        self.username = username
        self.name = name
        self.picUrl = picUrl
        self.followerCount = followerCount
        self.followingCount = followingCount
        self.mediaCount = mediaCount
    }
}

@objc class Profile: NSObject {
    @objc let username: String
    @objc let name: String?
    @objc let picUrl: String?

    @objc init(username: String, name: String?, picUrl: String?) {
        self.username = username
        self.name = name
        self.picUrl = picUrl
    }
}

@objc protocol SocialApi {
    @objc func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void)
    @objc func restoreSession(completion: @escaping (Bool, String?) -> Void)
    @objc func fetchUserProfile(completion: @escaping (User?, String?) -> Void)
    @objc func fetchFollowers(pageDelay: Int64, completion: @escaping ([Profile]?, String?) -> Void)
    @objc func fetchFollowings(pageDelay: Int64, completion: @escaping ([Profile]?, String?) -> Void)
}
