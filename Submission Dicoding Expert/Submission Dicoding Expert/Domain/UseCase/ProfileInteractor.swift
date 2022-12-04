//
//  ProfileInteractor.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 07/11/22.
//

import Foundation
import RxSwift

protocol ProfileUseCase {
    
    func getProfileInfo() -> Observable<ProfileModel>

}

class ProfileInteractor: ProfileUseCase {
    
    private let repository: ProfileRepositoryProtocol
    
    required init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProfileInfo() -> Observable<ProfileModel> {
        return repository.getProfileInfo()
    }

}
