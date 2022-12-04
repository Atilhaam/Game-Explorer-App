//
//  ProfileRepository.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 07/11/22.
//

import Foundation
import RxSwift

protocol ProfileRepositoryProtocol {
    
    func getProfileInfo() -> Observable<ProfileModel>
    
}

final class ProfileRepository: NSObject {
    
    typealias ProfileInstance = (LocaleDataSource) -> ProfileRepository
    fileprivate let locale: LocaleDataSource
    private init(locale: LocaleDataSource) {
        self.locale = locale
    }
    
    static let sharedInstance: ProfileInstance = { localeRepo in
        return ProfileRepository(locale: localeRepo)
    }
}

extension ProfileRepository: ProfileRepositoryProtocol {
    func getProfileInfo() -> Observable<ProfileModel> {
        return self.locale.getProfileInfo()
    }

}
