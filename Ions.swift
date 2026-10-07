//
//  Ions.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import Foundation

extension Ion {
    static let sodium    = Ion(id: "sodium",    name: "sodium",    formula: "Na⁺",   charge:  1, baseImage: "ion_sodium",    radius: 102)
    static let potassium = Ion(id: "potassium", name: "potassium", formula: "K⁺",    charge:  1, baseImage: "ion_potassium", radius: 138)
    static let ammonium  = Ion(id: "ammonium",  name: "ammonium",  formula: "NH₄⁺",  charge:  1, baseImage: "ion_ammonium",  radius: 148)
    static let silver    = Ion(id: "silver",    name: "silver",    formula: "Ag⁺",   charge:  1, baseImage: "ion_silver",    radius: 115)

    static let calcium   = Ion(id: "calcium",   name: "calcium",   formula: "Ca²⁺",  charge:  2, baseImage: "ion_calcium",   radius: 100)
    static let barium    = Ion(id: "barium",    name: "barium",    formula: "Ba²⁺",  charge:  2, baseImage: "ion_barium",    radius: 135)
    static let lead      = Ion(id: "lead",      name: "lead",      formula: "Pb²⁺",  charge:  2, baseImage: "ion_lead",      radius: 119)
    static let magnesium = Ion(id: "magnesium", name: "magnesium", formula: "Mg²⁺",  charge:  2, baseImage: "ion_magnesium", radius:  72)

    static let chloride  = Ion(id: "chloride",  name: "chloride",  formula: "Cl⁻",   charge: -1, baseImage: "ion_chloride",  radius: 181)
    static let iodide    = Ion(id: "iodide",    name: "iodide",    formula: "I⁻",    charge: -1, baseImage: "ion_iodide",    radius: 220)
    static let nitrate   = Ion(id: "nitrate",   name: "nitrate",   formula: "NO₃⁻",  charge: -1, baseImage: "ion_nitrate",   radius: 179)
    static let hydroxide = Ion(id: "hydroxide", name: "hydroxide", formula: "OH⁻",   charge: -1, baseImage: "ion_hydroxide", radius: 133)

    static let sulfate   = Ion(id: "sulfate",   name: "sulfate",   formula: "SO₄²⁻", charge: -2, baseImage: "ion_sulfate",   radius: 230)
    static let carbonate = Ion(id: "carbonate", name: "carbonate", formula: "CO₃²⁻", charge: -2, baseImage: "ion_carbonate", radius: 178)
}
