//
//  RestaurantEnvironment.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import ComposableArchitecture

public struct Environment {
  public var mainQueue: AnySchedulerOf<DispatchQueue>
  public var apiClient: APIClient

  public init(
    mainQueue: AnySchedulerOf<DispatchQueue>,
    apiClient: APIClient
  ) {
    self.mainQueue = mainQueue
    self.apiClient = apiClient
  }

  public static var live:  Environment {
    return Environment(
      mainQueue: .main,
      apiClient: .live
    )
  }
}

#if DEBUG
extension Environment {
  public static var mock:  Environment {
    return Environment(
      mainQueue: .immediate,
      apiClient: .mock
    )
  }
}
#endif
