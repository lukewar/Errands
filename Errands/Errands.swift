//
//  Copyright © 2018 Lukasz Warchol. All rights reserved.
//

import Foundation

typealias DoneClosure<T> = (T) -> Void
typealias OperationClosure<T, U> = (T, @escaping DoneClosure<U>) -> Void

class Errands {
    fileprivate var anchorTask: Task<Void, Void>?
    
    func first<O>(_ operation: @escaping (@escaping DoneClosure<O>) -> Void) -> Task<Void, O> {
        guard self.anchorTask == nil else {
            preconditionFailure("Errands setup more than once.")
        }
        
        anchorTask = Task<Void, Void>(errands: self){ _, done in done(()) }
        
        let nextTask = Task<Void, O>(errands: self) { _, done in
            operation(done)
        }
        anchorTask!.bind(nextTask: nextTask)
        
        return nextTask
    }
}

class Task<I, O> {
    let operation: OperationClosure<I, O>
    
    private(set) var errands: Errands?
    private var completion: (DoneClosure<O>)?
    
    init(errands: Errands, operation: @escaping OperationClosure<I, O>) {
        self.errands = errands
        self.operation = operation
        self.completion = nil
    }
    
    func then<T>(_ operation: @escaping OperationClosure<O, T>) -> Task<O, T> {
        guard let errands = self.errands else {
            preconditionFailure("Errands already run.")
        }
        guard self.completion == nil else {
            preconditionFailure("Task already binded.")
        }
        
        let nextTask = Task<O, T>(errands: errands, operation: operation)
        bind(nextTask: nextTask)
        return nextTask
    }
    
    fileprivate func bind<T>(nextTask task: Task<O, T>) {
        completion = { [weak self] output in
            self?.errands = nil
            task.execute(input: output)
        }
    }
    
    private func execute(input: I) {
        guard self.errands != nil else {
            preconditionFailure("Errands already run.")
        }
        guard let completion = completion else {
            preconditionFailure("Task not binded yet.")
        }
        operation(input, completion)
    }
    
    func finally(_ completion: @escaping DoneClosure<Void>) {
        guard let errands = self.errands else {
            preconditionFailure("Errands already completed.")
        }
        guard let anchorTask = errands.anchorTask else {
            fatalError()
        }
        
        let lastTask = Task<O, Void>(errands: errands)
        lastTask.completion = { arg in
            lastTask.errands = nil
            completion(arg)
        }
        self.bind(nextTask: lastTask)
        
        anchorTask.execute(input: ())
    }
}

private extension Task where O == Void {
    convenience init(errands: Errands) {
        self.init(errands: errands) { _, done in
            done(())
        }
    }
}
