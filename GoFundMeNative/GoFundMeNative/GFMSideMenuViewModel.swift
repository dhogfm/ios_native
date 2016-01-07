//
//  GFMSideMenuViewModel.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 1/7/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import ReactiveCocoa

enum SideMenuRow: Int {
    case SETTING, SIGNOUT
    
    func menuTitle() -> String {
        switch self {
        case .SETTING:
            return "Setting"
        case .SIGNOUT:
            return "Sign Out"
        }
    }
    
    func onRowTap(viewModel: GFMSideMenuViewModel) -> SignalProducer<Bool, NoError>{
        let producer = SignalProducer<Bool, NoError> { [unowned viewModel] (observer, disposable) in
            switch self {
            case .SETTING:
                observer.sendCompleted()
            case .SIGNOUT:
                viewModel.services.signOut(){ (isSignedOut) in
                    observer.sendNext(isSignedOut)
                    observer.sendCompleted()
                }
            }
        }
        return producer
    }
    
    func handleSignalEvent(event: Event<Bool, NoError>, viewModel: GFMSideMenuViewModel) {
        switch self {
        case .SETTING:
            break
        case .SIGNOUT:
            switch event {
            case .Next:
                if let isLoggedOut = event.value as Bool? {
                    if (isLoggedOut) {
                        let signInModel = GFMSignInModel()
                        let signInViewModel = GFMSignInViewModel(model: signInModel, services: viewModel.services)
                        
                        viewModel.services.popToSignIn(signInViewModel)
                    }
                }
            case .Completed:
                NSLog("finished")
            case .Interrupted:
                NSLog("Interrupted")
            case .Failed:
                NSLog("Failed")
                break
            }
        }
    }
    
    static let count: Int = {
        var max: Int = 0
        while let _ = SideMenuRow(rawValue: max) { max += 1 }
        return max
    }()
}

class GFMSideMenuViewModel: GFMViewModel {

    // Inputs
    
    // Outputs
    let title = MutableProperty("GoFundMe")
    
    // Actions
    
    override init(services: GFMServices) {
        
        super.init(services: services)
        
        setupPropertyBindings()
        setupModelActions()
    }
    
    // MARK: - Mutable Property Bindings
    
    func setupPropertyBindings() {
    }
    
    // MARK: - View Actions
    
    func handleSelectRowAtIndexPath(indexPath: NSIndexPath) {
        if let menuRow = SideMenuRow(rawValue: indexPath.row) {
            menuRow.onRowTap(self)
                .observeOn(UIScheduler())
                .start({ [unowned self] event in
                    menuRow.handleSignalEvent(event, viewModel: self)
                })
        }
    }
    
    func setupModelActions() {
    }
    
    // MARK: - Data Source
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return SideMenuRow.count
    }
    
    func titleForIndexPath(indexPath: NSIndexPath) -> String {
        if let menuRow = SideMenuRow(rawValue: indexPath.row) {
            return menuRow.menuTitle()
        }
        return ""
    }
}
