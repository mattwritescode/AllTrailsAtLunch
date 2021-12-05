//
//  APIClient.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import Foundation

public struct APIClient {
  public static var live:  APIClient {
    return APIClient()
  }
}

#if DEBUG
extension APIClient {
  public static var mock:  APIClient {
    return APIClient()
  }
}
#endif
