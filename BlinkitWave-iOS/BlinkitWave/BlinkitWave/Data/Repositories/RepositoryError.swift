import Foundation

/// Defines standard, localized error cases for all repository data operations.
enum RepositoryError: Error, LocalizedError {
    /// Requested entity with the given identifier was not found.
    case notFound(id: String)
    
    /// Save operation failed due to a constraint or backing store error.
    case saveFailed(reason: String)
    
    /// Delete operation failed due to a constraint or association error.
    case deleteFailed(reason: String)
    
    /// The repository was in an invalid state to perform the requested operation.
    case invalidState(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .notFound(let id):
            return "Entity with identifier \(id) was not found."
        case .saveFailed(let reason):
            return "Failed to save entity: \(reason)"
        case .deleteFailed(let reason):
            return "Failed to delete entity: \(reason)"
        case .invalidState(let reason):
            return "Invalid repository operation: \(reason)"
        }
    }
}
