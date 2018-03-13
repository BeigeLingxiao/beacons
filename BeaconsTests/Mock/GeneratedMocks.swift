// MARK: - Mocks generated from file: Beacons/Service/BuildingService.swift at 2018-01-09 00:06:26 +0000

//
//  MarkerLoader.swift
//  Beacons
//
//  Created by Антон Назаров on 26.09.17.
//  Copyright © 2017 com.epam All rights r
import Cuckoo
@testable import Beacons

import RealmSwift
import RxSwift

class MockBuildingService: BuildingService, Cuckoo.Mock {
    typealias MocksType = BuildingService
    typealias Stubbing = __StubbingProxy_BuildingService
    typealias Verification = __VerificationProxy_BuildingService
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: BuildingService?

    func spy(on victim: BuildingService) -> Self {
        observed = victim
        return self
    }

    

    

    
     func get(by id: Int)  -> Observable<Building> {
        
            return cuckoo_manager.call("get(by: Int) -> Observable<Building>",
                parameters: (id),
                original: observed.map { o in
                    return { (args) -> Observable<Building> in
                        let (id) = args
                        return o.get(by: id)
                    }
                })
        
    }
    
     func replaceAll(_ buildings: [Building])  -> [Building] {
        
            return cuckoo_manager.call("replaceAll(_: [Building]) -> [Building]",
                parameters: (buildings),
                original: observed.map { o in
                    return { (args) -> [Building] in
                        let (buildings) = args
                        return o.replaceAll(buildings)
                    }
                })
        
    }
    
     func getAll()  -> Observable<Results<Building>> {
        
            return cuckoo_manager.call("getAll() -> Observable<Results<Building>>",
                parameters: (),
                original: observed.map { o in
                    return { (args) -> Observable<Results<Building>> in
                        let () = args
                        return o.getAll()
                    }
                })
        
    }
    

    struct __StubbingProxy_BuildingService: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func get<M1: Cuckoo.Matchable>(by id: M1) -> Cuckoo.StubFunction<(Int), Observable<Building>> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return .init(stub: cuckoo_manager.createStub("get(by: Int) -> Observable<Building>", parameterMatchers: matchers))
        }
        
        func replaceAll<M1: Cuckoo.Matchable>(_ buildings: M1) -> Cuckoo.StubFunction<([Building]), [Building]> where M1.MatchedType == [Building] {
            let matchers: [Cuckoo.ParameterMatcher<([Building])>] = [wrap(matchable: buildings) { $0 }]
            return .init(stub: cuckoo_manager.createStub("replaceAll(_: [Building]) -> [Building]", parameterMatchers: matchers))
        }
        
        func getAll() -> Cuckoo.StubFunction<(), Observable<Results<Building>>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub("getAll() -> Observable<Results<Building>>", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_BuildingService: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func get<M1: Cuckoo.Matchable>(by id: M1) -> Cuckoo.__DoNotUse<Observable<Building>> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return cuckoo_manager.verify("get(by: Int) -> Observable<Building>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func replaceAll<M1: Cuckoo.Matchable>(_ buildings: M1) -> Cuckoo.__DoNotUse<[Building]> where M1.MatchedType == [Building] {
            let matchers: [Cuckoo.ParameterMatcher<([Building])>] = [wrap(matchable: buildings) { $0 }]
            return cuckoo_manager.verify("replaceAll(_: [Building]) -> [Building]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func getAll() -> Cuckoo.__DoNotUse<Observable<Results<Building>>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("getAll() -> Observable<Results<Building>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class BuildingServiceStub: BuildingService {
    

    

    
     func get(by id: Int)  -> Observable<Building> {
        return DefaultValueRegistry.defaultValue(for: Observable<Building>.self)
    }
    
     func replaceAll(_ buildings: [Building])  -> [Building] {
        return DefaultValueRegistry.defaultValue(for: [Building].self)
    }
    
     func getAll()  -> Observable<Results<Building>> {
        return DefaultValueRegistry.defaultValue(for: Observable<Results<Building>>.self)
    }
    
}




// MARK: - Mocks generated from file: Beacons/Persistence/VertexRepository.swift at 2018-01-09 00:06:26 +0000

//
//  VertexRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 09.10.2017.
//  Copyright © 2017 com.epam All rights r
import Cuckoo
@testable import Beacons

import GoogleMaps
import RealmSwift

class MockVertexRepository: VertexRepository, Cuckoo.Mock {
    typealias MocksType = VertexRepository
    typealias Stubbing = __StubbingProxy_VertexRepository
    typealias Verification = __VerificationProxy_VertexRepository
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: VertexRepository?

    func spy(on victim: VertexRepository) -> Self {
        observed = victim
        return self
    }

    

    

    
     override func getNearest(to point: CLLocationCoordinate2D)  -> Vertex? {
        
            return cuckoo_manager.call("getNearest(to: CLLocationCoordinate2D) -> Vertex?",
                parameters: (point),
                original: observed.map { o in
                    return { (args) -> Vertex? in
                        let (point) = args
                        return o.getNearest(to: point)
                    }
                })
        
    }
    
     override func getAll(fromBuilding id: Int)  -> [Vertex] {
        
            return cuckoo_manager.call("getAll(fromBuilding: Int) -> [Vertex]",
                parameters: (id),
                original: observed.map { o in
                    return { (args) -> [Vertex] in
                        let (id) = args
                        return o.getAll(fromBuilding: id)
                    }
                })
        
    }
    

    struct __StubbingProxy_VertexRepository: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func getNearest<M1: Cuckoo.Matchable>(to point: M1) -> Cuckoo.StubFunction<(CLLocationCoordinate2D), Optional<Vertex>> where M1.MatchedType == CLLocationCoordinate2D {
            let matchers: [Cuckoo.ParameterMatcher<(CLLocationCoordinate2D)>] = [wrap(matchable: point) { $0 }]
            return .init(stub: cuckoo_manager.createStub("getNearest(to: CLLocationCoordinate2D) -> Vertex?", parameterMatchers: matchers))
        }
        
        func getAll<M1: Cuckoo.Matchable>(fromBuilding id: M1) -> Cuckoo.StubFunction<(Int), [Vertex]> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return .init(stub: cuckoo_manager.createStub("getAll(fromBuilding: Int) -> [Vertex]", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_VertexRepository: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func getNearest<M1: Cuckoo.Matchable>(to point: M1) -> Cuckoo.__DoNotUse<Optional<Vertex>> where M1.MatchedType == CLLocationCoordinate2D {
            let matchers: [Cuckoo.ParameterMatcher<(CLLocationCoordinate2D)>] = [wrap(matchable: point) { $0 }]
            return cuckoo_manager.verify("getNearest(to: CLLocationCoordinate2D) -> Vertex?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func getAll<M1: Cuckoo.Matchable>(fromBuilding id: M1) -> Cuckoo.__DoNotUse<[Vertex]> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return cuckoo_manager.verify("getAll(fromBuilding: Int) -> [Vertex]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class VertexRepositoryStub: VertexRepository {
    

    

    
     override func getNearest(to point: CLLocationCoordinate2D)  -> Vertex? {
        return DefaultValueRegistry.defaultValue(for: Optional<Vertex>.self)
    }
    
     override func getAll(fromBuilding id: Int)  -> [Vertex] {
        return DefaultValueRegistry.defaultValue(for: [Vertex].self)
    }
    
}




// MARK: - Mocks generated from file: Beacons/Persistence/BuildingRepository.swift at 2018-01-09 00:06:26 +0000

//
//  BuildingsRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 04.10.2017.
//  Copyright © 2017 com.epam All rights r
import Cuckoo
@testable import Beacons

import RealmSwift

class MockBuildingRepository: BuildingRepository, Cuckoo.Mock {
    typealias MocksType = BuildingRepository
    typealias Stubbing = __StubbingProxy_BuildingRepository
    typealias Verification = __VerificationProxy_BuildingRepository
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: BuildingRepository?

    func spy(on victim: BuildingRepository) -> Self {
        observed = victim
        return self
    }

    

    

    
     override func replaceAll(_ buildings: [Building])  throws -> [Building] {
        
            return try cuckoo_manager.callThrows("replaceAll(_: [Building]) throws -> [Building]",
                parameters: (buildings),
                original: observed.map { o in
                    return { (args) throws -> [Building] in
                        let (buildings) = args
                        return try o.replaceAll(buildings)
                    }
                })
        
    }
    
     override func getAll()  -> Results<Building> {
        
            return cuckoo_manager.call("getAll() -> Results<Building>",
                parameters: (),
                original: observed.map { o in
                    return { (args) -> Results<Building> in
                        let () = args
                        return o.getAll()
                    }
                })
        
    }
    
     override func get(by id: Int)  -> Building? {
        
            return cuckoo_manager.call("get(by: Int) -> Building?",
                parameters: (id),
                original: observed.map { o in
                    return { (args) -> Building? in
                        let (id) = args
                        return o.get(by: id)
                    }
                })
        
    }
    

    struct __StubbingProxy_BuildingRepository: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func replaceAll<M1: Cuckoo.Matchable>(_ buildings: M1) -> Cuckoo.StubThrowingFunction<([Building]), [Building]> where M1.MatchedType == [Building] {
            let matchers: [Cuckoo.ParameterMatcher<([Building])>] = [wrap(matchable: buildings) { $0 }]
            return .init(stub: cuckoo_manager.createStub("replaceAll(_: [Building]) throws -> [Building]", parameterMatchers: matchers))
        }
        
        func getAll() -> Cuckoo.StubFunction<(), Results<Building>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub("getAll() -> Results<Building>", parameterMatchers: matchers))
        }
        
        func get<M1: Cuckoo.Matchable>(by id: M1) -> Cuckoo.StubFunction<(Int), Optional<Building>> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return .init(stub: cuckoo_manager.createStub("get(by: Int) -> Building?", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_BuildingRepository: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func replaceAll<M1: Cuckoo.Matchable>(_ buildings: M1) -> Cuckoo.__DoNotUse<[Building]> where M1.MatchedType == [Building] {
            let matchers: [Cuckoo.ParameterMatcher<([Building])>] = [wrap(matchable: buildings) { $0 }]
            return cuckoo_manager.verify("replaceAll(_: [Building]) throws -> [Building]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func getAll() -> Cuckoo.__DoNotUse<Results<Building>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("getAll() -> Results<Building>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func get<M1: Cuckoo.Matchable>(by id: M1) -> Cuckoo.__DoNotUse<Optional<Building>> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return cuckoo_manager.verify("get(by: Int) -> Building?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class BuildingRepositoryStub: BuildingRepository {
    

    

    
     override func replaceAll(_ buildings: [Building])  throws -> [Building] {
        return DefaultValueRegistry.defaultValue(for: [Building].self)
    }
    
     override func getAll()  -> Results<Building> {
        return DefaultValueRegistry.defaultValue(for: Results<Building>.self)
    }
    
     override func get(by id: Int)  -> Building? {
        return DefaultValueRegistry.defaultValue(for: Optional<Building>.self)
    }
    
}



