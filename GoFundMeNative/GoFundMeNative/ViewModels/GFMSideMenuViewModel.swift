//
//  GFMSideMenuViewModel.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 1/7/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import ReactiveCocoa

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
    
    func setupModelActions() {
    }
    
    func handleSelectRowAtIndexPath(indexPath: NSIndexPath) {
        if let menuRow = SideMenuRow(rawValue: indexPath.row) {
            self.onRowTap(menuRow)
                .observeOn(UIScheduler())
                .start({ [unowned self] event in
                    self.handleSignalEvent(event, row: menuRow)
                })
        }
    }
    
    func onRowTap(rowTapped: SideMenuRow) -> SignalProducer<Bool, NoError> {
        let producer = SignalProducer<Bool, NoError> { [unowned self] (observer, disposable) in
            switch rowTapped {
            case .ACCOUNT:
                observer.sendCompleted()
            case .FEED:
                observer.sendCompleted()
            case .SETTINGS:
                observer.sendCompleted()
            case .SIGNOUT:
                self.services.signOut(){ (isSignedOut) in
                    observer.sendNext(isSignedOut)
                    observer.sendCompleted()
                }
            }
        }
        return producer
    }
    
    func handleSignalEvent(event: Event<Bool, NoError>, row: SideMenuRow) {
        switch row {
        case .ACCOUNT:
            break
        case .FEED:
            break
        case .SETTINGS:
            break
        case .SIGNOUT:
            switch event {
            case .Next:
                if let isLoggedOut = event.value as Bool? {
                    if (isLoggedOut) {
                        let signInModel = GFMSignInModel()
                        let signInViewModel = GFMSignInViewModel(model: signInModel, services: self.services)
                        
                        self.services.popToSignIn(signInViewModel)
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
