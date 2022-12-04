//
//  ProfilePresenter.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 07/11/22.
//

import Foundation
import RxSwift

class ProfilePresenter: ObservableObject {
    private let profileUseCase: ProfileUseCase
    
    init(profileUseCase: ProfileUseCase) {
        self.profileUseCase = profileUseCase
    }
    
    func getProfileInfo() -> Observable<ProfileModel> {
        return profileUseCase.getProfileInfo()
    }
}
