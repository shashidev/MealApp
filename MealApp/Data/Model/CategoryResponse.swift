//
//  CategoryResponse.swift
//  MealApp
//
//

import Foundation

// MARK: - Category Model
struct CategoryResponseDTO : Codable {
    let categories : [CategoryDTO]?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([CategoryDTO].self, forKey: .categories)
    }
    
    init(categories : [CategoryDTO]?) {
        self.categories = categories
    }

}

struct CategoryDTO : Codable {
    let idCategory : String?
    let strCategory : String?
    let strCategoryThumb : String?
    let strCategoryDescription : String?

    enum CodingKeys: String, CodingKey {

        case idCategory = "idCategory"
        case strCategory = "strCategory"
        case strCategoryThumb = "strCategoryThumb"
        case strCategoryDescription = "strCategoryDescription"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idCategory = try values.decodeIfPresent(String.self, forKey: .idCategory)
        strCategory = try values.decodeIfPresent(String.self, forKey: .strCategory)
        strCategoryThumb = try values.decodeIfPresent(String.self, forKey: .strCategoryThumb)
        strCategoryDescription = try values.decodeIfPresent(String.self, forKey: .strCategoryDescription)
    }
    
    
    /// Converts `CategoryDTO` (API Model) to `Categories` (Domain Entity).
    /// This ensures that the data from the API is properly mapped to the domain model
    /// used in the business logic layer.
    ///
    /// - Returns: A `Categories` entity with properly assigned values.
    func toDomain() -> Categories {
        return Categories(
            idCategory: idCategory ?? "",
            strCategory: strCategory ?? "Unknown",
            strCategoryThumb: strCategoryThumb ?? "",
            strCategoryDescription: strCategoryDescription ?? ""
        )
    }
}

