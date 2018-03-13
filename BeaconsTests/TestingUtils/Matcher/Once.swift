//
//  Once.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 14/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Cuckoo

func once() -> CallMatcher {
  return times(1)
}
