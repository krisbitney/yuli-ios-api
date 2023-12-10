import Foundation
import Swiftagram
import SwiftagramCrypto

@objcMembers
public class SwiftSocialApi: NSObject, SocialApi {
    private var cancellables = Set<AnyCancellable>()

    private var username: String?
    private var secret: Secret?

    public func login(username: String, password: String, onChallenge: @escaping () -> String, completion: @escaping (Bool, String?) -> Void) {
        self.username = username
        Authenticator
            .keychain
            .basic(username: username, password: password)
            .authenticate()
            .sink(
                receiveCompletion: { compl in
                    switch compl {
                    case .finished:
                        break
                    case .failure(let error):
                        switch error {
                        case Authenticator.Error.twoFactorChallenge(let challenge):
                            let code = onChallenge()
                            challenge
                                .code(code)
                                .authenticate()
                                .sink(
                                    receiveCompletion: { compl in
                                        switch compl {
                                        case .finished:
                                            break
                                        case .failure(let error):
                                            completion(false, error.localizedDescription)
                                        }
                                    },
                                    receiveValue: { secret in
                                        self.secret = secret
                                        completion(true, nil)
                                    }
                                )
                                .store(in: &self.cancellables)
                            break
                        default:
                            completion(false, error.localizedDescription)
                        }
                    }
                },
               receiveValue: { secret in
                   self.secret = secret
                   completion(true, nil)
                }
            )
                .store(in: &cancellables)
    }

    public func restoreSession(completion: @escaping (Bool, String?) -> Void) {
        self.secret = try? Authenticator.keychain.secrets.get()[0]
        completion(self.secret != nil, nil)
    }

    public func fetchUserProfile(completion: @escaping (User?, String?) -> Void) {
        guard let secret = self.secret else {
            completion(nil, "User is not logged in")
            return
        }
        Endpoint
            .user(secret.identifier)
            .summary
            .unlock(with: secret)
            .session(.instagram)
            .sink(
                receiveCompletion: { compl in
                    switch compl {
                    case .finished:
                        break
                    case .failure(let error):
                        completion(nil, error.localizedDescription)
                    }
                },
               receiveValue: { profile in
                   if (profile.user == nil) {
                       completion(nil, "profile.user is nil")
                   }
                   let user = User(username: profile.user!.username,
                                   name: profile.user!.name,
                                   picUrl: profile.user!.avatar?.absoluteString,
                                   followerCount: profile.user!.counter?.followers ?? 0,
                                   followingCount: profile.user!.counter?.following ?? 0,
                                   mediaCount: profile.user!.counter?.posts ?? 0)
                   completion(user, nil)
               }
            )
            .store(in: &cancellables)

    }

    public func fetchFollowers(pageDelay: Int64, completion: @escaping ([Profile]?, String?) -> Void) {
        guard let secret = self.secret else {
            completion(nil, "User is not logged in")
            return
        }
        
        let delay = Delay(TimeInterval(Float(pageDelay) / 1000))
        var allProfiles = [Profile]()
        
        Endpoint
            .user(secret.identifier)
            .followers
            .unlock(with: secret)
            .session(.instagram)
            .pages(.max, delay: delay)
            .sink(
                receiveCompletion: { compl in
                    switch compl {
                    case .finished:
                        completion(allProfiles, nil)
                    case .failure(let error):
                        completion(nil, error.localizedDescription)
                    }
                },
               receiveValue: { pages in
                   let users = pages.users?.compactMap({user in
                       Profile(
                        username: user.username,
                        name: user.name,
                        picUrl: user.avatar?.absoluteString
                       )
                   })
                   allProfiles.append(contentsOf: users ?? [])
               }
            )
            .store(in: &cancellables)
    }

    public func fetchFollowings(pageDelay: Int64, completion: @escaping ([Profile]?, String?) -> Void) {
        guard let secret = self.secret else {
            completion(nil, "User is not logged in")
            return
        }
        
        let delay = Delay(TimeInterval(Float(pageDelay) / 1000))
        var allProfiles = [Profile]()
        
        Endpoint
            .user(secret.identifier)
            .following
            .unlock(with: secret)
            .session(.instagram)
            .pages(.max, delay: delay)
            .sink(
                receiveCompletion: { compl in
                    switch compl {
                    case .finished:
                        completion(allProfiles, nil)
                    case .failure(let error):
                        completion(nil, error.localizedDescription)
                    }
                },
               receiveValue: { pages in
                   let users = pages.users?.compactMap({user in
                       Profile(
                        username: user.username,
                        name: user.name,
                        picUrl: user.avatar?.absoluteString
                       )
                   })
                   allProfiles.append(contentsOf: users ?? [])
               }
            )
            .store(in: &cancellables)
    }
}
