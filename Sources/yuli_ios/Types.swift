import Foundation
import ComposableStorage

@objcMembers
class User: NSObject {
    let username: String
    let name: String?
    let picUrl: String?
    let followerCount: Int
    let followingCount: Int
    let mediaCount: Int

    init(username: String, name: String?, picUrl: String?, followerCount: Int, followingCount: Int, mediaCount: Int) {
        self.username = username
        self.name = name
        self.picUrl = picUrl
        self.followerCount = followerCount
        self.followingCount = followingCount
        self.mediaCount = mediaCount
    }
}

@objcMembers
class Profile: NSObject {
    let username: String
    let name: String?
    let picUrl: String?

    init(username: String, name: String?, picUrl: String?) {
        self.username = username
        self.name = name
        self.picUrl = picUrl
    }
}

@objc
protocol SocialApi {
    @objc func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void)
    @objc func restoreSession(completion: @escaping (Bool, String?) -> Void)
    @objc func fetchUserProfile(completion: @escaping (User?, String?) -> Void)
    @objc func fetchFollowers(pageDelay: Int64, completion: @escaping ([Profile]?, String?) -> Void)
    @objc func fetchFollowings(pageDelay: Int64, completion: @escaping ([Profile]?, String?) -> Void)
}
