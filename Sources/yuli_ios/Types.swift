import Foundation
import ComposableStorage

@objcMembers
public class User: NSObject {
    public let username: String
    public let name: String?
    public let picUrl: String?
    public let followerCount: Int
    public let followingCount: Int
    public let mediaCount: Int

    public init(username: String, name: String?, picUrl: String?, followerCount: Int, followingCount: Int, mediaCount: Int) {
        self.username = username
        self.name = name
        self.picUrl = picUrl
        self.followerCount = followerCount
        self.followingCount = followingCount
        self.mediaCount = mediaCount
    }
}

@objcMembers
public class Profile: NSObject {
    public let username: String
    public let name: String?
    public let picUrl: String?

    public init(username: String, name: String?, picUrl: String?) {
        self.username = username
        self.name = name
        self.picUrl = picUrl
    }
}

@objc
public protocol SocialApi {
    @objc func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void)
    @objc func restoreSession(completion: @escaping (Bool, String?) -> Void)
    @objc func fetchUserProfile(completion: @escaping (User?, String?) -> Void)
    @objc func fetchFollowers(pageDelay: Int64, completion: @escaping ([Profile]?, String?) -> Void)
    @objc func fetchFollowings(pageDelay: Int64, completion: @escaping ([Profile]?, String?) -> Void)
}
